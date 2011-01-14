package asquery
{
	import flash.events.*;
	import flash.utils.Dictionary;
	
	import com.ffsys.dom.*;

	dynamic public class ActionscriptQuery extends NodeList
	{
		/**
		* 	The delimiter between multiple queries.
		*/
		public static const SELECTOR_DELIMITER:String = ",";
		
		/**
		* 	The delimiter between descendant queries.
		*/
		public static const DESCENDANT_SELECTOR_DELIMITER:String = " ";		
		
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
		
		static private var _callbacks:Vector.<Function>;
		
		/**
		* 	Creates an <code>ActionscriptQuery</code> instance.
		* 
		* 	@param query The query object.
		*/
		public function ActionscriptQuery( query:Object = null )
		{
			super();
			if( query != null )
			{
				handle( query );
			}
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
		
		public function get callbacks():Vector.<Function>
		{
			if( _callbacks == null )
			{
				_callbacks = new Vector.<Function>();
			}
			return _callbacks;
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
			
			return this;
		}
		
		public function html( xml:String ):Object
		{
			
			
			return this;
		}
		
		/**
		* 	Retrieves a single attribute and sets multiple
		* 	attributes.
		* 
		* 	@param key The attribute key.
		* 	@param value The attribute value.
		* 	
		* 	@return Either the value of a matched attribute or
		* 	a chained query.
		*/
		public function attr( key:Object, value:Object = null ):Object
		{
			var child:Node = null;
			if( key is String && value == null )
			{
				child = first();
				if( child is Element )
				{
					return child.getAttribute( String( key ) );
				}
			//assign a single attribute to all matches	
			}else if( key is String && value is String )
			{
				for each( child in this )
				{
					if( child is Element )
					{
						Element( child ).setAttribute(
							String( key ), String( value ) );
					}
				}
			//assign all attributes to all matches
			}else if( key is Object && value is Object )
			{
				var prop:String = null;
				for each( child in this )
				{
					if( child is Element )
					{
						for( prop in value )
						{
							Element( child ).setAttribute(
								prop, value[ prop ] );
						}
					}
				}
			}
			
			return this;
		}
		
		/**
		* 	@private
		* 
		* 	Adds existing DOM element references to the elements
		* 	matched by this query.
		*/
		private function addReferences( query:Object ):ActionscriptQuery
		{
			clear();
			if( query is Element )
			{	
				addMatchedElement( Element( query ) );
			}else if( query is NodeList )
			{
				addMatchedList( NodeList( query ) );
			}
			return this;
		}
		
		/**
		* 	@private
		* 
		* 	Retrieves a copy of this query suitable for chaining.
		* 
		* 	@return A query suitable for chaining.
		*/
		private function getChainedQuery():ActionscriptQuery
		{
			var output:ActionscriptQuery = new ActionscriptQuery();
			//ensure the chain value has the correct matches
			output.children = this.children;
			output.setContexts( this );
			
			//trace("[OUTPUT QUERY] ActionscriptQuery::getChainedQuery()", output, output.children, output.contexts );

			return output;
		}
		
		public function setContexts( parent:ActionscriptQuery ):void
		{
			this.contexts = new Vector.<Element>();
			var node:Node = null;
			for each( node in parent.children )
			{
				if( node is Element )
				{
					this.contexts.push( Element( node ) );
				}
			}
		}
		
		/**
		* 	Finds all elements of the current set of contexts.
		*/
		public function findAll( context:Element = null ):void
		{
			addMatchedElements( context.elements );
			//trace("[FIND ALL] ActionscriptQuery::findAll()", context.elements, length );
		}
		
		private function isEventName( methodName:* ):Boolean
		{
			return ( methodName == QueryEventProxy.CLICK );
		}
		
		private function isEventTrigger( methodName:*, parameters:Array ):Boolean
		{
			return parameters.length == 0;
		}
		
		private function isEventHandler( methodName:*, parameters:Array ):Boolean
		{
			return parameters.length >= 1 && parameters[ 0 ] is Function;
		}
		
		private function getDisplayListEventType( methodName:String ):String
		{
			var mapping:Object = {
				click: MouseEvent.CLICK 
			};
			return mapping[ methodName ];
		}
		
		static private var _eventCache:Dictionary = new Dictionary( true );
		
		private function bindEventHandler( methodName:*, handler:Function, parameters:Array ):void
		{
			var type:String = getDisplayListEventType( String( methodName ) );
			var node:Node = null;
			var proxy:QueryEventProxy = new QueryEventProxy();
			proxy.type = type;
			proxy.methodName = methodName;
			proxy.handler = handler;
			proxy.parameters = parameters;
			for each( node in this )
			{
				_eventCache[ node ] = proxy;
			}
		}
		
		public function click( handler:Function = null, ...parameters ):*
		{
			if( handler != null )
			{
				bindEventHandler( QueryEventProxy.CLICK, handler, parameters );
			}else{
				triggerEventHandler( QueryEventProxy.CLICK, parameters );
			}
			
			return getChainedQuery();
		}
		
		private function triggerEventHandler( methodName:*, parameters:Array ):void
		{
			var type:String = getDisplayListEventType( String( methodName ) );
			
			//TODO: keep track of event handler cache?

			/*
			trace("[ASQUERY TRIGGER EVENT HANDLER] ActionscriptQuery::bindEventHandler()",
				methodName, type, length );
			*/
			
			var node:Node = null;
			var proxy:QueryEventProxy = null;			
			for each( node in this )
			{
				proxy = _eventCache[ node ] as QueryEventProxy;
				if( proxy != null )
				{
					//trace("[FOUND QUERY PROXY EVENT TO TRIGGER] ActionscriptQuery::triggerEventHandler()", proxy, proxy.type );
					
					node.addEventListener(
						proxy.type, proxy.accept );
					proxy.execute( node );
				}
			}
		}
		
		/**
		* 	@private
		*/
		override protected function methodMissing( methodName:*, parameters:Array ):*
		{
			//trace("ActionscriptQuery::methodMissing()", methodName, parameters );

			//check out matched elements for the method
			var node:Node = null;
			for each( node in children )
			{
				//trace("ActionscriptQuery::methodMissing()", node );
				if( node != null
				 	&& node.hasOwnProperty( methodName )
					&& node[ methodName ] is Function )
				{
					//trace("[CALLING CHILD METHOD] ActionscriptQuery::methodMissing()");
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
			var parts:Array = query.split( SELECTOR_DELIMITER );
			//still no valid query
			//find all elements
			if( query == null || query == QUERY_WILDCARD )
			{
				findAll( context );
			}else{
				doFind( parts, context );
			}
		}
		
		/**
		* 	@private
		*/
		private function doFind( parts:Array, context:Element ):void
		{
			var part:String = null;
			for( var i:int = 0;i < parts.length;i++ )
			{
				part = parts[ i ];
				part = part.replace( /^\s+/, "" );
				part = part.replace( /\s+$/, "" );
				doFindElement( part, context );
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
		internal function doFindElement( query:String, context:Element, descendants:Boolean = true ):void
		{
			var identifier:Boolean = isIdentifier( query );
			var className:Boolean = isClassName( query );
			var tagName:Boolean = !identifier && !className;
			
			
			if( query.indexOf( DESCENDANT_SELECTOR_DELIMITER ) > -1 )
			{
				handleDescendantSelector( query, context );
				return;
			}
			
			var candidate:String = query.replace( /^(#|\.)/, "" );
			
			/*
			trace("ActionscriptQuery::doFindElement() dom/query/identifier/className/tagName:",
				context, query, identifier, className, tagName );
			*/
			
			if( identifier )
			{
				//trace("[FIND BY ID] ActionscriptQuery::doFindElement()", context, candidate );
				addMatchedElement( context.getElementById( candidate ) );
				//trace("[FIND BY ID AFTER] ActionscriptQuery::doFindElement()", length );					
			}else if( className )
			{
				//trace("[FIND BY CLASS] ActionscriptQuery::doFindElement()", candidate, context );					
				findElementsByClassName( candidate, context );
				//trace("[FIND BY CLASS AFTER] ActionscriptQuery::doFindElement()", length );
			}else if( tagName )
			{
				//trace("[FIND BY TAG] ActionscriptQuery::doFindElement()", context, candidate, descendants, context.getElementsByTagName( candidate ) );
				
				if( !descendants )
				{				
					addMatchedList( context.getChildrenByTagName( candidate ) );	
				}else{
					addMatchedList( context.getElementsByTagName( candidate ) );
				}
				//trace("[FIND BY TAG AFTER] ActionscriptQuery::doFindElement()", length );					
			}
		}
		
		/**
		* 	@private
		*/
		private function handleDescendantSelector( query:String, context:Element ):void
		{
			//find matches for the first part
			var parts:Array = query.split( DESCENDANT_SELECTOR_DELIMITER );
			var first:String = parts[ 0 ];
			var part:String = null;
			var tmp:ActionscriptQuery = new ActionscriptQuery();
			tmp.doFindElement( first, context );
			tmp.setContexts( tmp );
			for( var i:int = 1;i < parts.length;i++ )
			{
				part = String( parts[ i ] );
				tmp.query = part;
				//tmp.clear();
				//find the matches for each descendant element
				//tmp.doFindElement( part );
				
				tmp.find( part );
				
				//trace("[FIRST DESCENDANT QUERY MATCHES] ActionscriptQuery::handleDescendantSelector()", tmp.length );
				
				if( tmp.length == 0 )
				{
					break;
				}
				
				//update the contexts to the matched elements
				tmp.setContexts( tmp );
			}
			
			//trace("[FIRST DESCENDANT QUERY MATCHES] ActionscriptQuery::handleDescendantSelector()", tmp );			
			
			//update our matches to the temp
			addMatchedList( tmp );
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
		private function addMatchedList(
			list:NodeList ):void
		{
			//trace("[ADDING LIST] ActionscriptQuery::addMatchedList()", list );
			var node:Node = null;
			for each( node in list )
			{
				if( node is Element )
				{
					//trace("[ADDING LIST ELEMENT] ActionscriptQuery::addMatchedList()", node );
					addMatchedElement( Element( node ) );
				}
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
			className:String, context:Element ):void
		{
			var element:Element = null;
			for each( element in context.elements )
			{
				//trace("ActionscriptQuery::findElementsByClassName()", className, context, element, element.hasClass( className ), element.classes );
				if( element.hasClass( className ) )
				{
					addMatchedElement( element );
				}
			}
		}
		
		/**
		*	@private
		*/
		public function onload( dom:Document ):void
		{
			if( doms.indexOf( dom ) == -1 )  
			{
				doms.push( dom );
				dom.onload();
			}
			
			//trace("[ASQUERY ONLOAD] ActionscriptQuery::onload()", callbacks );
			
			if( callbacks.length > 0 )
			{
				//trace("[INVOKE ON LOAD CALLBACKS] ActionscriptQuery::onload()", dom );
				
				var f:Function = null;
				for each( f in callbacks )
				{
					//invoke onload callbacks in the scope of the document
					f.apply( dom, [] );
				}
			}
		}
		
		/**
		* 	@private
		*/
		internal function handle( query:Object ):*
		{
			if( query == null || query is String || query is RegExp )
			{
				find( query );
			}else if( query is Function )
			{
				callbacks.push( query as Function );
			}else if( query is Node || query is NodeList )
			{
				addReferences( query );
			}

			return getChainedQuery();
		}
	}
}