package com.ffsys.dom
{
	import com.ffsys.ui.css.CssStyle;
	import com.ffsys.ui.css.CssStyleCache;	
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.ui.css.IStyleManagerAware;
	import com.ffsys.ui.css.StyleSheetFactory;
	
	/**
	*	Represents a <code>DOM</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class Element extends Node
		implements IStyleManagerAware
	{	
		/**
		* 	The attribute name that determines class style names.
		*/
		public static const CLASS:String = "class";
		
		/**
		* 	The name of the property used internally to store
		* 	class style names so that there is no conflict
		* 	with the <code>class</code> actionscript keyword.
		*/
		public static const CLASS_NAMES:String = "classNames";
		
		/**
		* 	The name of the style object used to store
		* 	styles declared inline using the <code>style</code>
		* 	attribute.
		*/
		public static const INLINE_STYLE_SHEET_NAME:String = "inline-style";
		
		/**
		* 	@private
		*/
		protected var _inlineStyleCache:ICssStyleSheet = null;		
		
		private var _namespaceDeclarations:Array;		
		
		private var _title:String;
		private var _classNames:String;
		private var _styles:CssStyle;
		private var _styleNameCache:Vector.<String> = null;
		private var _styleManager:IStyleManager;
		
		/**
		*	@private	 
		*/
		protected var _elements:Vector.<Element>;
		
		/**
		* 	Creates an <code>Element</code> instance.
		*/
		public function Element( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return Node.ELEMENT_NODE;
		}
		
		/**
		* 	A title for the element.
		*/
		public function get title():String
		{
			return _title;
		}
		
		public function set title( value:String ):void
		{
			_title = value;
		}
		
		/**
		* 	The namespace declarations for this element.
		*/
		public function get namespaceDeclarations():Array
		{
			if( _namespaceDeclarations == null )
			{
				if( ownerDocument == null || ( ownerDocument == this ) )
				{
					_namespaceDeclarations = new Array();
				}else
				{
					_namespaceDeclarations = ownerDocument.namespaceDeclarations.slice();
				}
			}
			return _namespaceDeclarations;
		}
		
		public function set namespaceDeclarations( value:Array ):void
		{
			_namespaceDeclarations = value;
		}
		
		/**
		* 	Attempts to retrieve a namespace prefix from
		* 	the namespace declarations assocaited with this element
		* 	based on the specified target namespace.
		* 
		* 	@param ns The target namespace.
		* 
		* 	@return The prefix for the namespace or <code>null</code>
		* 	if no matching namespace was found.
		*/
		public function getPrefixByNamespace( ns:Namespace ):String
		{
			if( ns != null )
			{
				var uri:String = ns.uri;
				
				var child:Namespace = null;
				for each( child in namespaceDeclarations )
				{
					if( child
						&& child.uri.length > 0
						&& ns.uri == child.uri )
					{
						return child.prefix;
					}
				}
			}
			return null;
		}
		
		/**
		* 	Attempts to retrieve a namespace URI from
		* 	the namespace declarations assocaited with this element
		* 	based on the specified prefix.
		* 
		* 	@param prefix The namespace prefix.
		* 
		* 	@return The <code>URI</code> for the namespace or <code>null</code>
		* 	if no matching namespace was found.
		*/
		public function getUriByPrefix( prefix:String ):String
		{
			if( prefix != null )
			{
				var child:Namespace = null;
				for each( child in namespaceDeclarations )
				{
					if( child
						&& child.prefix == prefix
						&& child.uri.length > 0 )
					{
						return child.uri;
					}
				}
			}
			return null;
		}
		
		private var _xmlns:String;
		
		/**
		* 	The XML namespace <code>URI</code> for this element.
		*/
		public function get xmlns():String
		{
			if( _xmlns == null )
			{
				var declarations:Array = this.namespaceDeclarations;
				var child:Namespace = null;
				for each( child in namespaceDeclarations )
				{
					if( !child.prefix
						&& child.uri.length > 0 )
					{
						_xmlns = child.uri;
						break;
					}
				}
			}
			return _xmlns;
		}
		
		public function set xmlns( value:String ):void
		{
			var ns:String = this.xmlns;
			
			var declarations:Array = this.namespaceDeclarations;
			var child:Namespace = null;
			
			//no previous default namespace specified
			if( ns == null )
			{
				//create on our namespace declarations
				this.namespaceDeclarations.push(
					new Namespace( value ) );
			}else{
				//update an existing default declaration
				for( var i:int = 0;i < declarations.length;i++ )
				{
					child = declarations[ i ];
					if( !child.prefix
						&& child.uri.length > 0 )
					{
						declarations.splice( i, 1, new Namespace( value ) );
						break;
					}
				}
			}
			
			_xmlns = value;
		}
		
		/**
		* 	The language for this element.
		* 
		* 	The qualified <code>xml:lang</code> attribute is preferred
		* 	but if it is not present and a <code>lang</code>
		* 	attribute is available it will be used.
		*/
		public function get lang():String
		{
			//TODO: constants			
			var ns:String = "xml";
			var nm:String = "lang";
			var uri:String = getUriByPrefix( ns );				
			
			var attr:Attr = getAttributeNodeNS( uri, nm );
			
			//check for non-qualified lang attribute
			if( attr == null )
			{
				attr = getAttributeNode( nm );
			}
			
			//attempt to retrieve a default language
			//at the document level
			if( attr == null
				&& ownerDocument != null
				&& ownerDocument != this )
			{
				return ownerDocument.lang;
			}
			
			return attr != null ? attr.value : null;
		}
		
		public function set lang( value:String ):void
		{
			//TODO: constants			
			var ns:String = "xml";
			var nm:String = "lang";
			var uri:String = getUriByPrefix( ns );
			
			var attr:Attr = getAttributeNodeNS( uri, nm );
			
			//creating first time around
			if( attr == null && value != null )
			{

				attr = ownerDocument.createAttributeNS(
					uri, nm );
			}
			
			if( attr != null
				&& value != null )
			{
				attr.value = value;
			}else if( attr != null
				&& value == null )
			{
				//delete the language attribute on this element
				removeAttributeNode( attr );
				attr = null;				
			}
			
			if( attr != null )
			{
				setAttributeNode( attr );
			}
		}
		
		/**
		* 	An XML schema for this element.
		* 
		* 	Stored as the qualified <code>xml:xsi</code> attribute.
		*/
		public function get xsi():String
		{
			//TODO: constants
			var ns:String = "xml";
			var nm:String = "xsi";
			var uri:String = getUriByPrefix( ns );			
			
			var attr:Attr = getAttributeNodeNS( uri, nm );

			//attempt to retrieve a default xsi
			//at the document level
			if( attr == null
				&& ownerDocument != null
				&& ( ownerDocument != this ) )
			{
				return ownerDocument.xsi;
			}

			return attr != null ? attr.value : null;
		}

		public function set xsi( value:String ):void
		{
			//TODO: constants
			var ns:String = "xml";
			var nm:String = "xsi";
			var uri:String = getUriByPrefix( ns );			
			
			var attr:Attr = getAttributeNodeNS( uri, nm );
			
			//creating first time around
			if( attr == null )
			{
				attr = ownerDocument.createAttributeNS(
					uri, nm );
			}			
			
			if( attr != null
				&& value != null )
			{
				attr.value = value;
			}else if( attr != null
				&& value == null )
			{
				//delete the xsi attribute on this element
				removeAttributeNode( attr );
				attr = null;
			}
			
			if( attr != null )
			{
				setAttributeNode( attr );
			}
		}
		
		/**
		* 	Adds namespace declarations associated
		* 	with this element to the attributes of an XML element.
		* 
		* 	@param x The XML element.
		*/
		protected function addNamespaceAttributes( x:XML ):void
		{
			if( namespaceDeclarations != null )
			{
				//trace("[GOT NAMESPACE DECLARATION] Document::get xml()", namespaceDeclarations );
				var ns:Namespace = null;
				var nm:String = null;
				for each( ns in namespaceDeclarations )
				{
					if( !ns.prefix )
					{
						//continue;	
						nm = "xmlns";
					}else
					{
						nm = "xmlns:" + ns.prefix;
					}
					if( x.@[ nm ].length() == 0 )
					{
						x.@[ nm ] = ns.uri;
					}
				}
			}
		}
		
		/**
		* 	Sets or retrieves the text of this element.
		* 
		* 	@param value A value to assign to the text
		* 	of this element.
		* 
		* 	@return This element when assigning text contents
		* 	or the cumulative text contents when retrieving
		* 	text values.
		*/
		public function text( value:String = null ):Object
		{
			if( ownerDocument == null
				|| ownerDocument.implementation == null )
			{
				throw new Error(
					"Cannot assign text content with no available DOM implementation." );
			}
			
			//trace("Element::text()", "[TEXT]", this, childNodes, value );
			
			//set a text value
			if( value != null )
			{
				//clear any existing child elements
				clear();
				
				//add the text
				appendChild(
					ownerDocument.createTextNode( value ) );
					
			//retrieve a cumulative value of all descendant text nodes
			}else{
				var txt:String = "";
				var elements:Vector.<Text> = this.textNodes;
				var child:Text = null;
				
				//trace("Element::text()", "[RETRIEVING CUMULATIVE TEXT]", elements );
				
				for( var i:int = 0;i < elements.length;i++ )
				{
					child = elements[ i ];
					txt += child.data;
				}
				return txt;
			}
			return this;
		}
		
		/**
		* 	Retrieves all descendant nodes that are
		* 	text.
		*/
		public function get textNodes():Vector.<Text>
		{
			var output:Vector.<Text> = new Vector.<Text>();
			var child:Node = null;
			for( var i:int = 0;i < childNodes.length;i++ )
			{
				child = childNodes[ i ];
				
				//trace("Element::get textNodes()", child, child is Text );
				
				if( child is Text )
				{
					output.push( Text( child ) );
				}else if( child is Element )
				{
					output = output.concat(
						Element( child ).textNodes );
				}
			}
			return output;
		}
		
		/**
		* 	Sets the markup of this element.
		* 
		* 	The markup parameter can be <code>XML</code>, <code>XMLList</code>
		* 	or a <code>String</code>.
		* 
		* 	By default markup is treated as inner markup. If you specify
		* 	the <code>inner</code> parameter as <code>false</code>
		* 	and the markup root node name matches the tag name
		* 	for this element then the entire markup block is parsed
		* 	into this element.
		* 
		* 	@param markup The markup for this element.
		* 	@param inner Whether the markup should be treated
		* 	as inner markup.
		* 
		* 	@return This element after the markup has been assigned.
		*/
		public function html( markup:Object, inner:Boolean = true ):Element
		{
			if( ownerDocument == null
				|| ownerDocument.implementation == null )
			{
				throw new Error(
					"Cannot assign inner markup with no available DOM implementation." );
			}
			
			var tmp:XML = new XML( "<" + tagName + " />" );
			
			//convert string values to XMLList
			if( markup is String )
			{
				markup = new XMLList( markup );
			}
			
			if( !( markup is XML || markup is XMLList ) )
			{
				throw new Error( "Inner markup must be XML or an XMLList." );
			}
			
			if( markup is XML )
			{
				var mx:XML = markup as XML;
				if( mx.name()
					&& mx.name().localName == tagName
					&& !inner )
				{
					//matching root tag name use the entire xml block
					tmp = mx;
				}else
				{
					tmp.appendChild( mx );
				}
			}else if( markup is XMLList )
			{
				var node:XML = null;
				for each( node in XMLList( markup ) )
				{
					tmp.appendChild( node );
				}
			}
			
			//clear any existing child nodes before
			//assigning the markup
			clear();
			
			//parse the markup into this element
			ownerDocument.implementation.parse(
				tmp, null, this );
			
			return this;
		}
		
		private var _styleCache:CssStyleCache;
		
		public function get styleCache():CssStyleCache
		{
			return _styleCache;
		}
		
		private function getStyleCache():void
		{
			var names:Vector.<String> = getClassLevelStyleNames();
			var inline:CssStyle = getInlineStyle();
			var styles:Vector.<CssStyle> = new Vector.<CssStyle>();
			var styleObjects:Array = new Array();
			var style:CssStyle = null;
			for( var i:int = 0;i < names.length;i++ )
			{
				style = stylesheet.getCssStyle( names[ i ] );
				styles.push( style );
				styleObjects.push( style );
			}
			
			if( inline != null )
			{
				names.push( INLINE_STYLE_SHEET_NAME );
				styles.push( inline );
			}
			
			//stylesheet.getFlatStyle( data[ 1 ] );
			
			trace("Element::added()", this, parentNode, names, styles );
			
			var parentCache:CssStyleCache = parentNode != null ? parentNode.styleCache : null;
			
			_styleCache = new CssStyleCache( parentCache, names, styles );
			_styleCache.source = stylesheet.getFlatStyle( styleObjects );
			
			/*
			
			var data:Array = stylesheet.getStyleInformation( this );

			
			output = new ComponentStyleCache();
			output.styleNames = data[ 0 ];
			output.styleObjects = data[ 1 ];
			output.styles = this.styles;
			output.source = stylesheet.getFlatStyle( data[ 1 ] );			
			
			*/			
		}
		
		/**
		* 	@private
		*/
		override internal function added():void
		{
			super.added();
			
			//TODO: compute css tag level inheritance
			getStyleCache();
			
		}
		
		/**
		* 	The styles for this element.
		*/
		public function get styles():CssStyle
		{
			if( _styles == null )
			{
				if( _styleCache == null )
				{
					getStyleCache();
				}
				_styles = _styleCache.source;
			}
			return _styles;
		}
		
		public function set styles( value:CssStyle ):void
		{
			_styles = value;
		}
		
		/**
		* 	The css style manager for this element.
		*/
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
		}
		
		/**
		* 	The css style sheet used by this element.
		*/
		public function get stylesheet():ICssStyleSheet
		{
			if( styleManager )
			{
				return styleManager.stylesheet;
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get classNames():String
		{
			if( _classNames == null )
			{
				_classNames = "";
			}
			return _classNames;
		}
		
		public function set classNames( value:String ):void
		{
			//invalidate the style name cache
			if( value != _classNames )
			{
				_styleNameCache = null;
			}
			
			_classNames = value;
			
			getClassLevelStyleNames();
		}
		
		/**
		* 	Retrieves a style object representing inline styles
		* 	declared on this element using a <code>style</code> attribute.
		* 
		* 	@return An object containing inline style
		* 	properties.
		*/
		public function getInlineStyle():CssStyle
		{
			var style:CssStyle = null;
			
			//check for a style string property
			var inline:String = this.style as String;
				
			//create the style cache first time around		
			if( _inlineStyleCache == null
				&& inline != null )
			{
				_inlineStyleCache = StyleSheetFactory.create();
			}
			
			if( _inlineStyleCache != null && inline != null )
			{
				_inlineStyleCache.id = INLINE_STYLE_SHEET_NAME;
								
				//remove any existing inline style object
				_inlineStyleCache.removeBeanDescriptor(
					_inlineStyleCache.getBeanDescriptor( INLINE_STYLE_SHEET_NAME ) );
				//wrap the inline styles in a valid style declaration
				var css:String = INLINE_STYLE_SHEET_NAME + " {\n" + inline + "\n}";
				_inlineStyleCache.parse( css );
				style = CssStyle( _inlineStyleCache.getStyle(
					INLINE_STYLE_SHEET_NAME ) );
			}
			
			return style;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getClassLevelStyleNames():Vector.<String>
		{
			if( _styleNameCache == null )
			{
				var output:Vector.<String> = new Vector.<String>();
				
				var clazz:Class = getClass();
				
				var hash:String = Selector.IDENTIFIER;
				var wildcard:String = Selector.WILDCARD;				
				
				//wildcard first
				output.push( wildcard );
				
				//then the raw class name
				output.push( clazz.name );
				
				//add any bean descriptor identifier and aliases
				if( _descriptor != null
					&& _descriptor.id != clazz.name.toLowerCase() )
				{
					output.push( _descriptor.id );
					//add bean descriptor name aliases
					output = output.concat( _descriptor.names );
				}
				
				//our own identifier
				if( id != null )
				{
					output.push( hash + id );
				}				
				
				//finally add the set of styles currently assigned
				output = output.concat( this.classes );
				
				//trace("[CREATED CLASS STYLE NAME CACHE] Element::getClassLevelStyleNames()", output );
				
				_styleNameCache = output;
			}
			return _styleNameCache;
		}
		
		/**
		* 	Determines whether the specified class name
		* 	exists on this instance.
		* 
		* 	@param name The class name to test for existence.
		* 
		* 	@return Whether the class name has been assigned to this
		* 	implementation.
		*/
		public function hasClass( name:String ):Boolean
		{
			return new RegExp( " ?" + name + " ?" ).test( classNames );
		}
		
		/**
		* 	Adds a class name to this element.
		* 
		* 	@param name The class name to add.
		* 
		* 	@return Whether the class was added.
		*/
		public function addClass( name:String ):Boolean
		{
			if( name != null )
			{
				var nm:String = this.classNames;
				if( /[^\s]/.test( nm ) )
				{
					nm += " ";
				}
				nm += name;
				this.classNames = nm;
				//trace("Element::addClass()", this, this.classNames );
				
				//TODO: invalidate css styles
				
				return true;
			}
			
			return false;
		}
		
		/**
		* 	Removes a class name from this element.
		* 
		* 	@param name The class name to remove.
		* 
		* 	@return Whether the class was removed.
		*/
		public function removeClass( name:String ):Boolean
		{
			var current:Vector.<String> = this.classes;
			var len:uint = current.length;
			var nm:String = null;
			for( var i:int = 0;i < len;i++ )
			{
				nm = current[ i ];
				if( nm == name )
				{
					current.splice( i, 1 );
					break;
				}
			}
			
			if( len != current.length )
			{
				classNames = current.join( " " );
			
				//TODO: invalidate css styles	
				
				return true;
			}
			
			return false;
		}
		
		/**
		* 	Retrieves a list of class names that correspond to the names
		* 	specified in the <code>classNames</code> property.
		*/
		public function get classes():Vector.<String>
		{
			var output:Vector.<String> = new Vector.<String>();
			if( _classNames != null )
			{
				var parts:Array = _classNames.split( " " );
				for( var i:int = 0;i < parts.length;i++ )
				{
					output.push( String( parts[ i ] ) );
				}
			}
			return output;
		}
		
		/**
		* 	The name of the tag that created this element.
		*/
		public function get tagName():String
		{
			return beanName;
		}
		
		/**
		* 	Retrieves a list of child nodes that are elements.
		*/
		public function get elements():Vector.<Element>
		{
			var elements:Vector.<Element> = new Vector.<Element>();
			var node:Node = null;
			for each( node in childNodes )
			{
				if( node is Element )
				{
					elements.push( Element( node ) );
				}
			}
			return elements;
		}
		
		/**
		* 	TODO
		*/
		public function setAttribute( name:String, value:String ):void
		{
			var attr:Attr = ownerDocument.createAttribute(
				name );
				
			attr.value = value;
			
			//trace("Element::setAttribute() attr: ", this, attr, attr.name, attr.value, attributes.length );			
			
			setAttributeNode( attr );
		}
		
		/**
		* 	TODO
		*/
		public function getAttribute( name:String ):String
		{
			var value:String = null;
			var attr:Attr = getAttributeNode( name );
			//trace("Element::getAttribute()", name, attr, length );
			if( attr != null )
			{
				value = attr.value;
			}
			return value;
		}
		
		/**
		* 	TODO
		*/
		public function removeAttribute( name:String ):void
		{
			var attr:Attr = getAttributeNode( name );
			if( attr != null )
			{
				removeAttributeNode( attr );
			}
		}
		
		/**
		* 	TODO
		*/
		public function setAttributeNS(
			namespaceURI:String, qualifiedName:String, value:String ):void
		{
			//This method can raise a DOMException object.
			var attr:Attr = ownerDocument.createAttributeNS(
				namespaceURI, qualifiedName );
			attr.value = value;	
			
			//trace("Element::setAttributeNS()", attr.name, attr.value, attr.uri );
			
			setAttributeNode( attr );
		}
		
		/**
		* 	Retrieves an attribute node by name.
		* 
		* 	@param localName The local name of the attribute.
		* 
		* 	@return The attribute node if it exists otherwise <code>null</code>.
		*/
		public function getAttributeNode( localName:String ):Attr
		{
			var attr:Node = null;
			for each( attr in attributes )
			{
				if( attr is Attr
				 	&& Attr( attr ).localName == localName )
				{
					return attr as Attr;
				}
			}
			return null;
		}
		
		/**
		* 	Adds an attribute node to this element.
		* 
		* 	@param attr The attribute to add.
		* 
		* 	@return The attribute that was added or <code>null</code>
		* 	if the specified attribute was <code>null</code>.
		*/
		public function setAttributeNode( attr:Attr ):Attr
		{
			if( attr != null )
			{		
				attr.setOwnerElement( this );
				
				//prevent duplicates
				if( hasAttribute( attr.nodeName ) )
				{
					//trace("Element::setAttributeNode()", "[HAS EXISTING ATTRIBUTE MATCH]", hasAttribute( attr.nodeName ) );					
					return attr;
				}
				
				attributes.setNamedItem( attr );
				
				this.xml.@[ attr.nodeName ] = attr.value;
								
				//trace("[ATTR] Element::setAttributeNode()", this, attr, attr.nodeName, hasAttribute( attr.nodeName ), attr.isQualified(), attr.name, attr.value, attr.uri, attributes.length );
								
				if( xml != null
					&& attr.name != null
				 	&& attr.value != null )
				{
					attributeSet( attr );
				}
			}
			return attr;
		}
		
		/**
		* 	Retrieves a list of all attributes with the specified
		* 	<code>localName</code>.
		* 
		* 	@param localName The local name of the attribute to search for.
		* 
		* 	@return A list of all attributes whose <code>localName</code>
		* 	matches the specified <code>localName</code>.
		*/
		public function getAttributeNodeList( localName:String ):Vector.<Attr>
		{
			var output:Vector.<Attr> = new Vector.<Attr>();
			var attr:Node = null;
			for each( attr in attributes )
			{
				if( attr is Attr
				 	&& Attr( attr ).localName == localName )
				{
					output.push( attr );
				}
			}
			return output;
		}
		
		public function getAttributeNodeNS(
			namespaceURI:String, localName:String ):Attr
		{
			var attr:Attr = getAttributeNode( localName );
			return ( attr != null && attr.uri == namespaceURI ) ? attr : null;
		}
		
		public function setAttributeNodeNS( attr:Attr ):Attr
		{
			return setAttributeNode( attr );
		}
		
		/**
		* 	Adds an attribute node to this element.
		* 
		* 	@param attr The attribute to add.
		* 
		* 	@return The attribute that was added or <code>null</code>
		* 	if the specified attribute was <code>null</code>.
		*/
		public function removeAttributeNode( attr:Attr ):Attr
		{
			var child:Attr = null;
			for( var i:int = 0;i < attributes.length;i++ )
			{
				child = attributes.item( i ) as Attr;
				if( child.nodeName == attr.nodeName )
				{
					delete xml.@[ attr.nodeName ];
					attributes.removeNamedItem( attr.nodeName );
					break;
				}
			}
			return attr;
		}
		
		/**
		* 	Determines whether this element has the specified attribute.
		* 
		* 	@param name The local name of the attribute.
		* 
		* 	@param A boolean indicating whether the named attribute exists.
		*/
		public function hasAttribute( name:String ):Boolean
		{
			if( !hasAttributes() )
			{
				return false;
			}
		
			//trace("Element::hasAttribute()", this, name, attributes );
			var attr:Node = null;
			for each( attr in attributes )
			{
				//trace("Element::hasAttribute() [ITEM]", attr, attr.nodeName );
				if( attr is Attr
					&& Attr( attr ).nodeName == name )
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		* 	Determines this elements has an attribute in the specified
		* 	namespace.
		* 
		* 	@param namespaceURI The <code>URI</code> for the namespace.
		* 	@param localName The local name for the namespace.
		* 
		* 	@return A boolean indicating whether an attribute exists
		* 	matching the specified namespace.
		*/
		public function hasAttributeNS( namespaceURI:String, localName:String ):Boolean
		{
			var attr:Attr = getAttributeNode( localName );
			return attr != null && attr.uri == namespaceURI;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementById( id:String ):Element
		{
			return ownerDocument.getElementById( id );
		}
		
		/**
		* 	Retrieves direct child elements by tag name.
		* 
		* 	@param tagName The name of the tag to retrieve elements for.
		* 
		* 	@return A node list containing any matched elements. 
		*/
		public function getElementsByTagName( tagName:String ):NodeList
		{
			var list:NodeList = new NodeList();
			//append child element matches
			var elems:Vector.<Element> = this.elements;
			var child:Element = null;
			for each( child in elems )
			{
				if( child != null )
				{
					if( child.tagName == tagName )
					{
						list.concat( child );
					}
					list.concat(
						child.getChildrenByTagName( tagName ) );
				}
			}
			return list;
		}
		
		/**
		* 	Retrieves all descendants by tag name.
		* 
		* 	@param tagName The name of the tag to retrieve descendant elements for.
		* 
		* 	@return A node list containing any matched elements.
		*/
		public function getChildrenByTagName( tagName:String ):NodeList
		{
			if( !( this[ tagName ] is NodeList ) )
			{
				return new NodeList();
			}
			return this[ tagName ] as NodeList;
		}
		
		/*
		
		Object Element	
		Element has the all the properties and methods of the Node object as well as the properties and methods defined below.
		The Element object has the following properties:
		
		tagName
		This read-only property is of type String.
		
		The Element object has the following methods:
		
		getAttribute(name)
		This method returns a String.
		The name parameter is of type String.
		
		setAttribute(name, value)
		This method has no return value.
		
		The name parameter is of type String.
		The value parameter is of type String.
		This method can raise a DOMException object.
		
		removeAttribute(name)
		
		This method has no return value.
		The name parameter is of type String.
		This method can raise a DOMException object.
		
		getAttributeNode(name)
		This method returns a Attr object.
		The name parameter is of type String.
		
		setAttributeNode(newAttr)
		This method returns a Attr object.
		The newAttr parameter is a Attr object.
		This method can raise a DOMException object.
		
		removeAttributeNode(oldAttr)
		This method returns a Attr object.
		The oldAttr parameter is a Attr object.
		This method can raise a DOMException object.
		
		getAttributeNS(namespaceURI, localName)
		This method returns a String.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		
		setAttributeNS(namespaceURI, qualifiedName, value)
		This method has no return value.
		The namespaceURI parameter is of type String.
		The qualifiedName parameter is of type String.
		The value parameter is of type String.
		This method can raise a DOMException object.
		
		removeAttributeNS(namespaceURI, localName)
		This method has no return value.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		This method can raise a DOMException object.
		
		
		
		getAttributeNodeNS(namespaceURI, localName)
		This method returns a Attr object.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		
		setAttributeNodeNS(newAttr)
		This method returns a Attr object.
		The newAttr parameter is a Attr object.
		This method can raise a DOMException object.
		
		
		
		getElementsByTagNameNS(namespaceURI, localName)
		This method returns a NodeList object.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		
		
		
		hasAttribute(name)
		This method returns a Boolean.
		The name parameter is of type String.
		
		hasAttributeNS(namespaceURI, localName)
		This method returns a Boolean.
		The namespaceURI parameter is of type String.
		The localName parameter is of type String.
		
		*/
		
		/**
		* 	@private
		* 
		* 	Handles configuring attributes when an
		* 	XML node is associated with this element.
		*/
		protected function importAttributes(
			node:XML, target:Element ):void
		{
			if( node.attributes().length() > 0 && target )
			{
				/*
				trace("::::::::::::::: !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> Element::importAttributes()",
					this,
					this.id,
					node.attributes().length() );
				*/
				
				var child:XML = null;
				var name:QName = null;
				var value:String = null;
				
				var attrs:XMLList = node.attributes();
				for each( child in attrs )
				{
					name = child.name();
					value = child.toString();
					var local:Boolean = !name.uri;
					
					//trace("Element::importAttributes() beanName/name/value/local: ", beanName, name.localName, value, local );
					
					if( local )
					{
						target.setAttribute( name.localName, value );
					}else{
						target.setAttributeNS( name.uri, name.localName, value );
					}
				}
			}
		}		
		
		/**
		* 	@private
		*/
		protected function attributeSet( attr:Attr ):void
		{
			//trace("Element::attributeSet()", name, value, xml.@[name], hasOwnProperty( name ) );
			
			var name:String = attr.name;
			var value:String = attr.value;
			
			if( hasOwnProperty( name )
				&& this[ name ] != value )
			{
				doWithProperty( name, value );
			}else{
				doWithMissingProperty( name, value );
			}
		}
		
		/**
		* 	@private
		*/
		protected function doWithProperty( name:String, value:String ):void
		{
			//TODO: check for exception
			this[ name ] = value;	
			
			//trace("Element::doWithProperty() AFTER SETTING THE PROPERTY: ", this, name, this[ name ] );		
		}
		
		/**
		* 	@private
		*/
		protected function doWithMissingProperty( name:String, value:String ):void
		{
			switch( name )
			{
				case CLASS:
					this[ CLASS_NAMES ] = value;
					
					//trace("Element::doWithMissingProperty()", "[SETTING CLASS NAMES]", value );
					break;
			}
		}			
	}
}