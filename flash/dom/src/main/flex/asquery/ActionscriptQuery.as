package asquery
{
	import com.ffsys.dom.*;

	dynamic public class ActionscriptQuery extends NodeList
	{
		/**
		* 	The delimiter between multiple queries.
		*/
		public static const QUERY_DELIMITER:String = " ";
		
		/**
		* 	The character used to indicate a query that
		* 	matches all descendant elements.
		*/
		public static const QUERY_WILDCARD:String = "*";
		
		/**
		* 	The regular expression used to determine
		* 	if a query is an element identifier.
		*/
		public static const IDENTIFIER_QUERY:RegExp = /^#/;
		
		/**
		* 	The regular expression used to determine
		* 	if a query is a class name identifier.
		*/
		public static const CLASS_NAME_QUERY:RegExp = /^\./;
		
		/**
		* 	A list of all registered DOM implementations.
		*/
		public static var doms:Vector.<Document> = new Vector.<Document>();
		
		private var _doms:Vector.<Document>;
		private var _query:String;
		private var _list:NodeList;
		private var _contexts:Vector.<Element>;
		
		/**
		* 	Creates an <code>ActionscriptQuery</code> instance.
		*/
		public function ActionscriptQuery()
		{
			super();
		}
		
		/**
		* 	The list of DOM implementations that this 
		* 	query applies to.
		*/
		public function get doms():Vector.<Document>
		{
			if( _doms == null )
			{
				_doms = ActionscriptQuery.doms;
			}
			return _doms;
		}
		
		public function set doms( value:Vector.<Document> ):void
		{
			_doms = value;
		}
		
		/**
		* 	A list of elements contexts for this query.
		* 
		* 	This defaults to the DOM implementations
		* 	registered if no contexts have been specified.
		*/
		public function get contexts():Vector.<Element>
		{
			if( _contexts == null )
			{
				_contexts = new Vector.<Element>();
				for each( var dom:Document in doms )
				{
					_contexts.push( Element( dom ) );
				}
			}
			return _contexts;
		}
		
		public function set contexts( value:Vector.<Element> ):void
		{
			_contexts = value;
		}
		
		/**
		* 	The query used to find elements. 
		*/
		public function get query():String
		{
			return _query;
		}
		
		public function set query( value:String ):void
		{
			_query = value;
		}
		
		/**
		* 	Finds elements that match the specified query
		* 	and injects them into the elements stored by this
		* 	query.
		* 
		* 	@param query The query string.
		* 
		* 	@return An actionscript query encapsulating the matched
		* 	elements.
		*/
		public function find( query:Object = null ):ActionscriptQuery
		{
			if( query == null
				&& this.query != null )
			{
				query = this.query;
			}
			
			//clear before retrieving any new matches
			clear();
			
			//trace("ActionscriptQuery::find()", contexts );
			
			var context:Element = null;
			for each( context in contexts )
			{	
				if( query is String )
				{	
					findInContext( String( query ), context );
				}else if( query is RegExp )
				{
					findByRegExpInContext( RegExp( query ), context );
				}
			}
			
			var output:ActionscriptQuery = new ActionscriptQuery();
			//ensure the chain value has the correct matches
			output.children = this.children;
			output.contexts = new Vector.<Element>();
			var node:Node = null;
			for each( node in this.children )
			{
				if( node is Element )
				{
					output.contexts.push( Element( node ) );
				}
			}
			
			//trace("[OUTPUT QUERY] ActionscriptQuery::find()", output, output.children, output.contexts );

			return output;
		}
		
		/**
		* 	Finds all elements of the current set of contexts.
		*/
		public function findAll( context:Element = null ):void
		{
			addMatchedElements( context.elements );
			//trace("[FIND ALL] ActionscriptQuery::findAll()", context.elements, length );
		}
		
		/**
		* 	@private
		*/
		override protected function methodMissing( methodName:*, parameters:Array ):*
		{
			trace("ActionscriptQuery::methodMissing()", methodName, parameters );
			
			//check out matched elements for the method
			var node:Node = null;
			for each( node in children )
			{
				trace("ActionscriptQuery::methodMissing()", node );
				if( node != null
				 	&& node.hasOwnProperty( methodName )
					&& node[ methodName ] is Function )
				{
					trace("[CALLING CHILD METHOD] ActionscriptQuery::methodMissing()");
					node[ methodName ].apply( node, parameters );
				}
			}
		}
		
		/**
		* 	@private
		* 
		* 	Retrieves matches by regular expression test on the element <code>id</code>.
		* 
		* 	@param query The regular expression.
		* 	@param context The parent element context.
		*/
		private function findByRegExpInContext( query:RegExp, context:Element ):void
		{
			var elements:Vector.<Element> = context.elements;
			var element:Element = null;
			for each( element in elements )
			{
				if( element != null
				 	&& element.id != null
					&& query.test( element.id ) )
				{
					addMatchedElement( element );
				}
			}
		}		
		
		/**
		* 	@private
		*/
		private function findInContext( query:String, context:Element ):void
		{
			var parts:Array = query.split( QUERY_DELIMITER );
			//still no valid query
			//find all elements
			if( query == null || query == QUERY_WILDCARD )
			{
				findAll( context );
			}else{
				if( parts.length == 1 )
				{
					doFindElement( String( parts[ i ] ) );
				}else
				{
					for( var i:int = 0;i < parts.length;i++ )
					{
						doFind( String( parts[ i ] ) );
					}
				}
			}
		}
		
		/**
		* 	@private
		*/
		private function doFind( query:String ):void
		{
			var dom:Document = null;
			for each( dom in doms )
			{
				trace("ActionscriptQuery::doFind()", dom, query );
			}
		}
		
		/**
		* 	@private
		*/
		private function isIdentifier( query:String ):Boolean
		{
			return IDENTIFIER_QUERY.test( query )
		}
		
		/**
		* 	@private
		*/
		private function isClassName( query:String ):Boolean
		{
			return CLASS_NAME_QUERY.test( query )
		}
		
		/**
		* 	@private
		*/
		private function doFindElement( query:String ):void
		{
			var identifier:Boolean = isIdentifier( query );
			var className:Boolean = isClassName( query );
			var tagName:Boolean = !identifier && !className;
			
			var candidate:String = query.replace( /^(#|\.)/, "" );
			
			var dom:Document = null;
			var element:Element = null;
			for each( dom in doms )
			{
				if( identifier )
				{
					//trace("[FIND BY ID] ActionscriptQuery::doFindElement()", candidate );
					addMatchedElement( dom.getElementById( candidate ) );
					//trace("[FIND BY ID AFTER] ActionscriptQuery::doFindElement()", length );					
				}else if( className )
				{
					//trace("[FIND BY CLASS] ActionscriptQuery::doFindElement()", candidate );					
					findElementsByClassName( candidate, dom );
					//trace("[FIND BY CLASS AFTER] ActionscriptQuery::doFindElement()", length );					
				}
				
				/*
				trace("ActionscriptQuery::doFindElement() dom/query/identifier/className/tagName:",
					dom, query, identifier, className, tagName );
				*/
			}
		}
		
		/**
		* 	@private
		*/
		private function addMatchedElements(
			elements:Vector.<Element> ):void
		{
			var element:Element = null;
			for each( element in elements )
			{
				addMatchedElement( element );
			}
		}		
		
		/**
		* 	@private
		*/
		private function addMatchedElement( element:Element ):void
		{
			if( element != null )
			{
				children.push( element );
			}
		}
		
		/**
		* 	@private
		*/
		private function findElementsByClassName(
			className:String, dom:Document ):void
		{
			var element:Element = null;
			for each( element in dom.elements )
			{
				if( element.hasClass( className ) )
				{
					addMatchedElement( element );
				}
			}
		}
		
		internal function handle( query:Object ):*
		{
			if( query == null || query is String || query is RegExp )
			{
				return find( query );
			}
			
			//TODO: handle element and node list parameters
			
			return this;
		}
	}
}