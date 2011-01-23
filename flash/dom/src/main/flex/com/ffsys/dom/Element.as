package com.ffsys.dom
{
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.ui.css.IStyleManagerAware;
	
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
		
		private var _namespaceDeclarations:Array;		
		
		private var _classNames:String;
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
			_nodeType = Node.ELEMENT_NODE;
			super( xml );
		}
		
		/**
		* 	The namespace declarations for the element.
		*/
		public function get namespaceDeclarations():Array
		{
			if( _namespaceDeclarations == null )
			{
				_namespaceDeclarations = new Array();
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
					output = output.concat( Element( child ).text );
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
		
		/**
		* 	@private
		*/
		override internal function added():void
		{
			super.added();
			
			//TODO: compute css tag level inheritance
			
			//trace("Element::added()", this.styleManager, this, parentNode );
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
		* 	@param name The name of the attribute node.
		* 
		* 	@return The attribute node if it exists otherwise <code>null</code>.
		*/
		public function getAttributeNode( name:String ):Attr
		{
			var attr:Node = null;
			for each( attr in attributes )
			{
				if( attr != null
					&& attr is Attr
				 	&& Attr( attr ).name == name )
				{
					break;
				}
			}
			return attr as Attr;
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
				
				//trace("[ATTR] Element::setAttributeNode()", this, attr, attr.isQualified(), attr.name, attr.value, attr.uri, attributes.length );
				
				attr.setOwnerElement( this );
				attributes.setNamedItem( attr );
				
				this.xml.@[ attr.nodeName ] = attr.value;
								
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
				if( child == attr )
				{
					var qn:QName = new QName( attr.uri, attr.name );
					delete xml.@[ qn ];
					attributes.removeNamedItem( child.name );
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
				//trace("Element::hasAttribute()", attr );
				if( attr is Attr
					&& Attr( attr ).name == name )
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
			var list:NodeList = getChildrenByTagName( tagName );
			//append child element matches
			var elems:Vector.<Element> = this.elements;
			var child:Element = null;
			for each( child in elems )
			{
				list.concat( child.getChildrenByTagName( tagName ) );
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
			if( this[ tagName ] == null )
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
			
			if( hasOwnProperty( name ) )
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