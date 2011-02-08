package com.ffsys.dom
{
	import flash.events.*;
	import flash.utils.Dictionary;
	
	import com.ffsys.css.Selector;
	
	import com.ffsys.dom.core.*;
	
	/**
	*	Represents dynamic <code>DOM</code> queries.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class ActionscriptQuery extends NodeList
	{	
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
		private static var __doms__:Vector.<Document> = null;
		
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
		* 	The DOM documents registered for query access.
		*/
		public static function get doms():Vector.<Document>
		{
			if( __doms__ == null )
			{
				__doms__ = new Vector.<Document>();
			}
			return __doms__;
		}
		
		/**
		* 	Binds a DOM document for query access.
		* 
		* 	@param document The document to bind.
		* 
		* 	@return Whether the document was bound.
		*/
		public static function bind( document:Document ):Boolean
		{
			if( document != null )
			{
				ActionscriptQuery.doms.push( document );
				return true;
			}
			return false;
		}
		
		/**
		* 	Unbinds a DOM document for query access.
		* 
		* 	@param document The document to unbind.
		* 
		* 	@return Whether the document was unbound.
		*/
		public static function unbind( document:Document ):Boolean
		{
			var index:int = ActionscriptQuery.doms.indexOf( document );
			if( document != null && index > -1 )
			{
				ActionscriptQuery.doms.splice( index, 1 );
				return true;
			}
			return false;
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
		
		/**
		* 	Iterates over matched elements executing the specified
		* 	callback function for each matched element.
		* 
		* 	@param callback The callback function to invoke for each
		* 	matched element.
		* 
		* 	@return An actionscript query.
		*/
		public function each( callback:Function ):ActionscriptQuery
		{
			if( callback != null )
			{
				var element:Element = null;
				for( var i:int = 0;i < length;i++ )
				{
					element = this[ i ] as Element;
					if( element != null )
					{
						callback.apply( element, [ i ] );
					}
				}
			}
			return this;
		}
		
		/**
		* 	Filters matched elements to an element at the specified
		* 	index.
		* 
		* 	If there is no element at the specified index no filtering
		* 	will occur.
		* 
		* 	@param index The index of the element to select.
		* 	
		* 	@return An actionscript query.
		*/
		public function eq( index:uint ):ActionscriptQuery
		{
			var element:Element = this[ index ] as Element;
			//remove all other elements and add the element
			//at the specified index
			if( element != null )
			{
				clear();
				concat( element );
				//return element;
			}
			return this;
		}
		
		public function even():void
		{
			//TODO
		}
		
		/**
		* 	Retrieves the index of a matched element.
		* 
		* 	@param subject The element to retrieve the index for.
		* 
		* 	@return The index of the element or -1 if the element
		* 	was not found.
		*/
		public function index( subject:Element ):int
		{
			if( subject != null )
			{
				var element:Element = null;
				for( var i:int = 0;i < length;i++ )
				{
					element = this[ i ] as Element;
				
					if( element != null && element == subject )
					{
						return i;
					}
				}
			}
			return -1;
		}
		
		/**
		* 	Retrieves either a single element at a specified
		* 	index or a vector containing all matched elements
		* 	if no index is specified or the index is less than zero.
		* 
		* 	@param index A specific index to retrieve an element at.
		* 
		* 	@return A single element or a vector of all matched elements.
		*/
		public function get( index:int = -1 ):Object
		{
			var element:Element = null;
			var output:Object = null;
			
			//place all matched elements in a vector of elements
			if( index < 0 )
			{
				output = new Vector.<Element>();
				for( var i:int = 0;i < length;i++ )
				{
					element = this[ i ] as Element;
					if( element != null )
					{
						output.push( element );
					}
				}
			}else{
				output = this[ index ] as Element;
			}
			return output;
		}
		
		/**
		* 	Gets the number of elements in this query.
		* 
		* 	This returns the same number as the <code>length</code>
		* 	property.
		* 
		* 	@return The number of elements in this query.
		*/
		public function size():uint
		{
			return this.length;
		}
		
		/**
		* 	Retrieves or sets style properties on matched elements.
		* 
		* 	When <code>target</code> is a <code>String</code> and no
		* 	<code>value</code> is specified this method will retrieve the named
		* 	style property on the first matched element.
		* 
		*	If <code>target</code> is an <code>Object</code> and no
		* 	<code>value</code> is specified this method will assign all enumerable
		* 	properties of the <code>target</code> to the styles of each
		* 	element matched by this query.
		* 
		* 	When <code>target</code> is a <code>String</code> and a
		* 	<code>value</code> is specified this method will assign the specified
		* 	style property <code>value</code> to all matched elements.
		* 
		* 	@param target The name of the style property or an object containing
		* 	enumerable properties to assign to all matched elements.
		* 	@param value A value to assign to a style property.
		* 
		* 	@return Either a style property value or a query.
		*/
		public function css( target:Object, value:Object = null ):Object
		{
			var element:Element = null;
			var node:Node = null;
			var z:String = null;
			
			//retrieve a single css property from the first matched element
			if( target is String
				&& value == null )
			{
				element = this.first() as Element;
				if( element != null )
				{
					return element.styles[ target ];
				}
			}else if( target is Object
				&& value == null )
			{				
				//assign all enumerable properties to all matched elements
				for each( node in this )
				{
					element = node as Element;
					if( element != null )
					{
						for( z in target )
						{
							element.styles[ z ] = target[ z ];
						}
					}
				}
			}else if( target is String
				&& ( value is String || value is Number ) )
			{
				//assign a single property to all matched elements
				for each( node in this )
				{
					element = node as Element;
					if( element != null )
					{
						element.styles[ target ] = value;
					}
				}
			}
			return this;
		}
		
		/**
		* 	Retrieves or sets inner <code>DOM</code> markup.
		* 
		* 	@param xml Markup to assign to all matched elements.
		* 
		* 	@return The inner <code>DOM</code> markup as either
		* 	<code>XML</code> or an <code>XMLList</code> when retrieving
		* 	inner markup.
		*/
		public function html( xml:Object = null, inner:Boolean = true ):Object
		{
			var element:Element = null;
			if( xml == null
				&& length > 0 )
			{
				element = this[ 0 ] as Element;
				if( element != null )
				{
					//return the child/children as it's the inner markup
					//we are interested in
					var children:XMLList = element.xml.children();
					return children.length() == 1 ? children[ 0 ] : children;
				}
			}
			
			//trace("ActionscriptQuery::html()", xml );
			
			if( xml != null )
			{
				for( var i:int = 0;i < length;i++ )
				{
					element = this[ i ] as Element;
					if( element != null )
					{
						element.html( xml, inner );
					}
				}
			}
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
			var parts:Array = query.split( Selector.DELIMITER );
			//still no valid query
			//find all elements
			if( query == null || query == Selector.UNIVERSAL )
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
			
			if( Selector.ATTRIBUTE_SELECTOR.test( query ) )
			{
				//trace("ActionscriptQuery::doFindElement()", "[GOT ATTR SELECTOR]", query );
				handleAttributeFilter( query, context );
				return;
			}
			
			if( query.indexOf( Selector.DESCENDANT ) > -1 )
			{
				handleDescendantSelector( query, context );
				return;
			}
			
			//remove any # identifier selector or . dot class selector
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
		private function handleAttributeFilter( query:String, context:Element ):void
		{
			//find matches for the first part
			var parts:Array = query.match( Selector.ATTRIBUTE_SELECTOR );
			
			//trace("ActionscriptQuery::handleAttributeFilter()", "[GOT ATTR PARTS]", parts );
			
			var first:String = query.substr( 0, query.indexOf( "[" ) );
			
			//trace("ActionscriptQuery::handleAttributeFilter() [FIRST]", first );
			
			var part:String = null;
			var tmp:ActionscriptQuery = new ActionscriptQuery();
			
			if( first.length == 0 )
			{
				throw new Error( "Cannot apply an attribute filter selector with no selector defined." );
			}
			
			//find the main contexts for the attribute filter
			tmp.doFindElement( first, context );
			tmp.setContexts( tmp );

			for( var i:int = 0;i < parts.length;i++ )
			{
				part = String( parts[ i ] );
				
				//parse each filter placing matches in this query
				tmp = tmp.doAttributeFilter( part );
				
				if( tmp.length == 0 )
				{
					break;
				}
			}
			addMatchedList( tmp );
		}
		
		internal function doAttributeFilter( query:String ):ActionscriptQuery
		{
			var output:ActionscriptQuery = new ActionscriptQuery();
			var nm:String = getAttributeFilterName( query );
			var operator:String = null;	
			var value:String = null;						
			var qualified:Boolean = hasAttributeFilterQualifier( query );
			
			if( qualified )
			{
				operator = getAttributeFilterOperator( query );
				value = getAttributeFilterValue( query );
			}

			var node:Node = null;
			var element:Element = null;
			for each( node in this )
			{
				element = node as Element;
				if( element != null )
				{
					//trace("ActionscriptQuery::doAttributeFilter()", qualified, nm, node, element.hasAttribute( nm ) );
					
					//no qualifier - add elements with the target
					//attribute
					if( element.hasAttribute( nm ) )
					{
						if( !qualified )
						{
							output.concat( node );
						}else{
							if( attributeFilterMatches(
								element.getAttribute( nm ), operator, value, nm ) )
							{
								output.concat( node );
							}
						}
					}
				}
			}
			return output;
		}
		
		private function attributeFilterMatches(
			attribute:String, operator:String, expected:String, name:String ):Boolean
		{
			switch( operator )
			{
				case "*=":
					return attribute.indexOf( expected ) > -1;
					break;
				case "$=":	
					return ( ( attribute.indexOf( expected ) + expected.length ) == attribute.length );
					break;
				case "=":
					return ( attribute == expected );
					break;
				case "!=":
					return ( attribute != expected );
					break;
				case "^=":
					return attribute.indexOf( expected ) == 0;
					break;
			}
			return false;
		}

		/**
		* 	@private
		*/
		private function stripAttributeFilterDelimiters( query:String ):String
		{
			query = query.replace( /^\[/, "" );
			query = query.replace( /\]$/, "" );
			return query;
		}
		
		/**
		* 	@private
		*/
		private function getAttributeFilterOperator( query:String ):String
		{
			query = stripAttributeFilterDelimiters( query );	
			var op:String = query.replace( /^[a-zA-Z0-9]+((\*|\$|\!|\^)?=).*$/, "$1" );
			return op;
		}
		
		/**
		* 	@private
		*/
		private function getAttributeFilterValue( query:String ):String
		{
			query = stripAttributeFilterDelimiters( query );
			var index:int = query.indexOf( "=" );
			if( index > -1 )
			{
				query = query.substr( index + 1 );
			}
			query = query.replace( /^'|"/, "" );
			query = query.replace( /'|"$/, "" );
			return query;
		}
		
		/**
		* 	@private
		*/
		private function getAttributeFilterName( query:String ):String
		{
			query = stripAttributeFilterDelimiters( query )
			if( hasAttributeFilterQualifier( query ) )
			{
				query = query.replace( /[\*\$\!\^]?=.*$/, "" );
			}
			return query;
		}
		
		/**
		* 	@private
		*/
		private function hasAttributeFilterQualifier( query:String ):Boolean
		{
			var re:RegExp = /(\*|\$|\!|\^)?=/;
			return re.test( query );
		}
		
		/**
		* 	@private
		*/
		private function handleDescendantSelector( query:String, context:Element ):void
		{
			//find matches for the first part
			var parts:Array = query.split( Selector.DESCENDANT );
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