package com.ffsys.w3c.dom
{	
	import flash.display.*;
	
	import javax.xml.*;
	import org.w3c.dom.*;
	
	import org.w3c.dom.events.DOMEvent;
	import org.w3c.dom.events.EventListener;	
	
	import com.ffsys.ioc.*;
	
	/**
	*	An abstract implementation of a <code>DOM</code>
	* 	document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class CoreDocumentImpl extends ParentNode
		implements Document
	{
		/**
		* 	The node name for document nodes.
		*/
		public static const NODE_NAME:String = "#document";
		
		/**
		* 	@private
		* 
		* 	Reproduced from the xerces-j documentation.
		* 
		*	Number of alterations made to this document since its creation.
		*	Serves as a "dirty bit" so that live objects such as NodeList can
		*	recognize when an alteration has been made and discard its cached
		*	state information.
		* 
		*	<p>Any method that alters the tree structure MUST cause or be
		*	accompanied by a call to changed(), to inform it that any outstanding
		*	NodeLists may have to be updated.</p>
		* 
		*	<p>(Required because NodeList is simultaneously "live" and integer-
		*	indexed -- a bad decision in the DOM's design.)</p>
		* 
		*	<p>Note that changes which do not affect the tree's structure -- changing
		*	the node's name, for example -- do _not_ have to call changed().</p>
		* 
		*	<p>Alternative implementation would be to use a cryptographic
		*	Digest value rather than a count. This would have the advantage that
		*	"harmless" changes (those producing equal() trees) would not force
		*	NodeList to resynchronize. Disadvantage is that it's slightly more prone
		*	to "false negatives", though that's the difference between "wildly
		*	unlikely" and "absurdly unlikely". IF we start maintaining digests,
		*	we should consider taking advantage of them.</p>
		*	
		*	<p>Note: This used to be done a node basis, so that we knew what
		*	subtree changed. But since only DeepNodeList really use this today,
		*	the gain appears to be really small compared to the cost of having
		*	an int on every (parent) node plus having to walk up the tree all the
		*	way to the root to mark the branch as changed everytime a node is
		*	changed.</p>
		* 
		*	<p>So we now have a single counter global to the document. It means that
		*	some objects may flush their cache more often than necessary, but this
		*	makes nodes smaller and only the document needs to be marked as changed.</p>
		*/
		protected var __changes:int = 0;
		
		private var _identifiers:Object = new Object();
		private var _tags:Object = new Object();
		
		private var _doctype:DocumentType;
		private var _implementation:DOMImplementation;
		
		private var _inputEncoding:String;
		private var _xmlEncoding:String;
		private var _xmlStandalone:Boolean;
		private var _xmlVersion:String;
		private var _strictErrorChecking:Boolean = true;
		private var _documentURI:String;
		private var _domConfig:DOMConfiguration;
		
		private var _elements:Vector.<Element>;
		
		/**
		* 	@private
		*/
		protected var _documentElement:Element;
		
		private var _errorChecking:Boolean = true;
		
		/**
		* 	Creates a <code>CoreDocumentImpl</code> instance.
		*/
		public function CoreDocumentImpl()
		{
			super();
		}
			
		/**
		* 	
		*/
		public function get errorChecking():Boolean
		{
			return _errorChecking;
		}		
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return NODE_NAME;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeType.DOCUMENT_NODE;
		}
		
		/**
		* 	Ensures that the elements for a document
		* 	are created from a fresh list.
		*/
		override public function get elements():Vector.<Element>
		{
			if( _elements == null )
			{
				_elements = new Vector.<Element>();
			}
			return _elements;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function onload():void
		{
			//trace("[ON LOAD] Document::onload()", this, this.id );
		}
		
		/**
		* 	Ensures that when no owner document has been specified a document
		* 	will consider itself as the owner.
		*/
		override public function get ownerDocument():Document
		{
			var doc:Document = super.ownerDocument;
			if( doc == null )
			{
				doc = this;
			}
			return doc;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get documentElement():Element
		{
			return _documentElement;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementById( id:String ):Element
		{
			return _identifiers[ id ] as Element;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementsByTagName( tagName:String ):NodeList
		{
			//var output:NodeList =  _tags[ tagName ] as NodeList;
			
			var output:NodeListImpl =  new NodeListImpl();

			//retrieve all descendant elements
			var elements:NodeList = getElements( true );
			
			//trace("[ELEMENTS BY TAG NAME] CoreDocumentImpl::getElementsByTagName()", elements );
			
			var el:Element = null;
			for( var i:int = 0;i < elements.length;i++ )
			{
				el = Element( elements.item( i ) );
				if( tagName == "*" || el.tagName === tagName )
				{
					output.concat( el );
				}
			}
			return output;
		}
		
		public function getChildrenByTagName( tagName:String ):NodeList
		{
			//filter children for tag name matches
			var output:NodeListImpl = new NodeListImpl();
			var elem:Element = null;
			for each( elem in elements )
			{
				if( elem.tagName == tagName )
				{
					output.concat( elem );
				}
			}
			return output;
		}
		
		public function getElementsByTagNameNS( namespaceURI:String, localName:String ):NodeList
		{
			//
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get doctype():DocumentType
		{
			return _doctype;
		}
		
		/**
		* 	@private
		*/
		internal function setDocumentType( doctype:DocumentType ):void
		{
			_doctype = doctype;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get implementation():DOMImplementation
		{
			return _implementation;
		}
		
		/**
		* 	@private
		*/
		internal function setImplementation( implementation:DOMImplementation ):void
		{
			_implementation = implementation;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get inputEncoding():String
		{
			return _inputEncoding;
		}
		
		/**
		* 	@private
		*/
		internal function setInputEncoding( encoding:String ):void
		{
			_inputEncoding = encoding;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlEncoding():String
		{
			return _xmlEncoding;
		}
		
		/**
		* 	@private
		*/
		internal function setXmlEncoding( encoding:String ):void
		{
			_xmlEncoding = encoding;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlStandalone():Boolean
		{
			return _xmlStandalone;
		}		
		
		public function set xmlStandalone( value:Boolean ):void
		{
			_xmlStandalone = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get xmlVersion():String
		{
			return _xmlVersion;
		}
		
		public function set xmlVersion( value:String ):void
		{
			_xmlVersion = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get strictErrorChecking():Boolean
		{
			return _strictErrorChecking;
		}
		
		public function set strictErrorChecking( value:Boolean ):void
		{
			_strictErrorChecking = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get documentURI():String
		{
			return _documentURI;
		}
		
		public function set documentURI( value:String ):void
		{
			_documentURI = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get domConfig():DOMConfiguration
		{
			return _domConfig;
		}
		
		/**
		* 	@private
		*/
		internal function setDomConfig( config:DOMConfiguration ):void
		{
			_domConfig = config;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createElement( tagName:String ):Element
		{
			var element:Element = null;
			
			if( !XMLGrammar.isValidXMLName( tagName ) )
			{
				throw new DOMException(
					DOMException.INVALID_XML_NAME_MSG,
					null,
					DOMException.INVALID_CHARACTER_ERR,
					[ tagName ] );
			}
			
			try
			{
				//TODO: handle namespace prefixes when looking via bean document
				
				//try to extract as a bean with the tag name
				element = Element( getDomBean(
					tagName ) );
			}catch( e:Error )
			{
				//no stress we'll create an element finally
			}finally
			{
				if( element == null )
				{
					//TODO: extract namespace uri based on any tag name prefix	
					element = new ElementImpl( this, tagName );
				}
			}
			if( element != null )
			{
				NodeImpl( element ).setNodeName( tagName );
			}
			return element;
		}
		
		/*
		
		NAMESPACE_ERR: Raised if the qualifiedName is a malformed qualified name,
		if the qualifiedName has a prefix and the namespaceURI is null,
		or if the qualifiedName has a prefix that is "xml" and the
		namespaceURI is different from "http://www.w3.org/XML/1998/namespace"
		[XML Namespaces] , or if the qualifiedName or its prefix is "xmlns"
		and the namespaceURI is different from "http://www.w3.org/2000/xmlns/",
		or if the namespaceURI is "http://www.w3.org/2000/xmlns/" and neither
		the qualifiedName nor its prefix is "xmlns".
		*/
		
		/**
		* 	@inheritDoc
		*/
		public function createElementNS( 
			namespaceURI:String, qualifiedName:String ):Element
		{
			var element:Element = null;
			
			if( implementation != null
				&& !implementation.hasFeature( DOMFeature.XML_MODULE, null ) )
			{
				throw new DOMException(
					DOMException.UNSUPPORTED_FEATURE_MODULE_MSG,
					null,
					DOMException.NOT_SUPPORTED_ERR,
					[ DOMFeature.XML_MODULE ] );
			}
			
			if( !XMLGrammar.isValidXMLName( qualifiedName ) )
			{
				throw new DOMException(
					DOMException.INVALID_XML_NAME_MSG,
					null,
					DOMException.INVALID_CHARACTER_ERR,
					[ qualifiedName ] );
			}
			
			try
			{
				//trace("[ATTEPTING BEAN CREATION] CoreDocumentImpl::createElementNS()", qualifiedName );
				
				element = Element( getDomBean(
					qualifiedName, null, namespaceURI ) );
			}catch( e:Error )
			{
				//no specific bean declared for the element
			}finally{
				if( element == null )
				{
					//trace("[CREATING DEFAULT NON-BEAN ELEMENT] CoreDocumentImpl::createElementNS()" );
					
					element = new ElementImpl(
						this,
						qualifiedName );
						//TODO: extract prefix from namespaceURI
						//new QName( namespaceURI, qualifiedName ) );
				}
			}
			
			if( element != null )
			{
				NodeImpl( element ).setNamespaceURI( namespaceURI );
				NodeImpl( element ).setNodeName( qualifiedName );
			}
			return element;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createDocumentFragment():DocumentFragment
		{
			var fragment:DocumentFragment = DocumentFragment( getDomBean(
				DocumentFragmentImpl.NAME ) );
			return fragment;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createTextNode( data:String ):Text
		{
			var text:Text = Text( getDomBean(
				TextImpl.NAME, { data: data } ) );
			return text;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createComment( data:String ):Comment
		{
			var comment:Comment = Comment( getDomBean(
				CommentImpl.NAME, { data: data } ) );
			return comment;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createCDATASection( data:String ):CDATASection
		{
			var cdata:CDATASection = CDATASection( getDomBean(
				CDATASectionImpl.NAME, { data: data } ) );
			return cdata;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createProcessingInstruction(
			target:String, data:String ):ProcessingInstruction
		{
			var instruction:ProcessingInstructionImpl = ProcessingInstructionImpl(
				getDomBean(
					ProcessingInstructionImpl.NAME, { data: data } ) );
			instruction.setTarget( target );
			return instruction;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createAttribute( name:String ):Attr
		{
			var attr:Attr = Attr( getDomBean(
				AttrImpl.NAME,
					{ name: name } ) );
			
			//trace("Document::createAttribute()", attr, attr.name );
			
			return attr;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createAttributeNS(
			namespaceURI:String, qualifiedName:String ):Attr
		{
			var attr:Attr = Attr( getDomBean(
				AttrImpl.NAME,
					{ name: qualifiedName, uri: namespaceURI } ) );
			
			//trace("Document::createAttributeNS()", attr );
			return attr;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createEntityReference( name:String ):EntityReference
		{
			//TODO: check this
			//{ name: name }
			var ref:EntityReference = EntityReference( getDomBean(
				EntityReferenceImpl.NAME, { name: name } ) );
			
			return ref;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function importNode( source:Node, deep:Boolean ):Node
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function adoptNode( source:Node ):Node
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function normalizeDocument():void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function renameNode(
			n:Node,
			namespaceURI:String,
			qualifiedName:String ):Node
		{
			/*
			trace("[RENAME NODE] CoreDocumentImpl::renameNode()",
				n, namespaceURI, qualifiedName );
			*/
				
			if( n == null )
			{
				//TODO: throw exception attempting to rename a null node
			}
				
			//non-qualified rename
			if( namespaceURI == null || namespaceURI == "" )
			{
				//TODO validate qualified name
				//does not contain a prefix when
				//no namespaceURI has been specified
				
				NodeImpl( n ).setNodeName(
					qualifiedName, null );
			}else{
				
				NodeImpl( n ).setNodeName(
					qualifiedName, namespaceURI );
			}

			return n;
		}
		
		/**
		* 	@private
		*/
	    public function addNodeEventListener(
			node:Node, type:String,
			listener:EventListener, useCapture:Boolean ):void
		{
	        //
	    }
		
		/**
		* 	@private
		*/
	    public function removeNodeEventListener(
			node:Node, type:String,
			listener:EventListener, useCapture:Boolean ):void
		{
	        //
	    }

		/**
		* 	@private
		*/
	    public function dispatchNodeEvent(
			node:Node, event:DOMEvent ):Boolean
		{
	        return false;
	    }
		
		//TODO: implement and change return type to display object
		public function getComponent( name:String ):Object
		{
			return null;
		}
		
		private function getComponentBean( beanName:String ):Object
		{
			return null;
		}
		
		/**
		* 	@private
		*/
		protected function getDomBean(
			beanName:String,
			properties:Object = null,
			namespaceURI:String = null ):Object
		{
			if( this.document == null )
			{
				//TODO: move to DomException
				throw new Error( "Cannot retrieve a DOM bean with no valid bean document." );
			}
			
			var doc:IBeanDocument = this.document;
			
			/*
			if( namespaceURI != null
				&& doc.id != namespaceURI )
			{
				var xref:IBeanDocument = null;
				for each( xref in doc.xrefs )
				{
					if( xref.id == namespaceURI )
					{
						doc = xref;
						break;
					}
				}
			}
			*/
			
			//trace("CoreDocumentImpl::getDomBean()", namespaceURI, doc, doc.id, beanName );
			
			var descriptor:IBeanDescriptor = doc.getBeanDescriptor(
				beanName );
				
			//trace("[DESCRIPTOR] CoreDocumentImpl::getComponentBean()", beanName, descriptor );
				
			if( descriptor == null )
			{
				throw new Error( "Could not locate an implementation for bean identifier '"
				 	+ beanName + "'." );
			}
			
			var bean:Object = descriptor.getBean( true, false );
			
			//trace("[CREATED DOCUMENT BEAN] Document::getDomBean()", descriptor, bean );
			
			if( bean != null
				&& properties != null )
			{
				var z:String = null;
				for( z in properties )
				{
					if( bean.hasOwnProperty( z ) )
					{
						bean[ z ] = properties[ z ];
					}
				}
			}
			
			if( bean is NodeImpl )
			{
				NodeImpl( bean ).setOwnerDocument( this );
			}
			
			//register the element with this document
			/*
			if( bean is Element )
			{
				registerElement( Element( bean ) );
			}
			*/
			
			bean.finalized();
			return bean;
		}
		
		/**
		* 	@inheritDoc
		*/	
		override public function appendChild( child:Node ):Node
		{
			if( child is NodeImpl )
			{
				NodeImpl( child ).setOwnerDocument( this );
			}
			var el:Element = this.documentElement;
			
			if( el != null && child != el )
			{
				return el.appendChild( child );
			}
			
			return super.appendChild( child );
		}
		
		override protected function propertyMissing( name:* ):*
		{
			var element:Element = _identifiers[ name ] as Element;
			if( element != null )
			{
				return element;
			}
			return super.propertyMissing( name );
		}
				
		internal function registerElement( element:Element ):void
		{
			if( element != null && element != this )
			{				
				if( element is NodeImpl
					&& NodeImpl( element ).id != null )
				{
					var existing:Element = _identifiers[ NodeImpl( element ).id ] as Element;
					
					//TOOD: re-integrate this
					
					/*
					if( existing != null )
					{
						throw new Error( "Duplicate id found '" + element.id + "' on " + element );
					}
					*/
					
					_identifiers[ NodeImpl( element ).id ] = element;
				}
				
				//all currently registered elements
				elements.push( element );
				
				var nm:String = NodeImpl( element ).beanName;
				if( nm != null )
				{
					//keep track of document elements by tag name
					var exists:NodeList = _tags[ nm ] as NodeList;
					if( exists == null )
					{
						_tags[ nm ] = new NodeListImpl();
					}
					_tags[ nm ].concat( element );
					
				
					//trace("[REGISTER ELEMENT] Document::registerElement()", element, element.id, nm, _tags[ nm ].length );					
				}
			}
		}

		/**
		* 	@private
		* 	
		*	Denotes that this node has changed.
		*/
		override protected function changed():void
		{
			__changes++;
		}

		/**
		* 	@private
		* 	
		*	Returns the number of changes to this node.
		*/
		override protected function changes():int
		{
			return __changes;
		}
		
		// Notification methods overidden in subclasses

	    /**
	    *	A method to be called when some text was changed in a text node,
	    *	so that live objects can be notified.
	    */
		internal function replacedText( node:CharacterDataImpl ):void
		{
			//
		}

		/**
		*	A method to be called when some text was deleted from a text node,
		*	so that live objects can be notified.
		*/
		internal function deletedText(
			node:CharacterDataImpl, offset:int, count:int ):void
		{
			//
		}

		/**
		*	A method to be called when some text was inserted into a text node,
		*	so that live objects can be notified.
		*/
		internal function insertedText(
			node:CharacterDataImpl, offset:int, count:int ):void
		{
			//
		}

		/**
		*	A method to be called when a character data node is about to be modified.
		*/
		internal function modifyingCharacterData( node:NodeImpl, replace:Boolean ):void 
		{
			//
		}

		/**
		*	A method to be called when a character data node has been modified.
		*/
		internal function modifiedCharacterData(
			node:NodeImpl,
			oldvalue:String,
			value:String,
			replace:Boolean ):void
		{
			//
		}

		
		/**
	    *	A method to be called when a node is about to be inserted in the tree.
	    */
	    internal function insertingNode( node:NodeImpl, replace:Boolean ):void
		{
			//TODO
	    }

		/**
		*	A method to be called when a node has been inserted in the tree.
		*/
		internal function insertedNode(
			node:NodeImpl,
			newInternal:NodeImpl,
			replace:Boolean ):void
		{
			//
		}

		/**
		*	A method to be called when a node is about to be removed from the tree.
		*/
		internal function removingNode(
			node:NodeImpl,
			oldChild:NodeImpl,
			replace:Boolean ):void
		{
			
		}

		/**
		*	A method to be called when a node has been removed from the tree.
		*/
		internal function removedNode( node:NodeImpl, replace:Boolean ):void
		{
			
		}

		/**
		*	A method to be called when a node is about to be replaced in the tree.
		*/
		internal function replacingNode( node:NodeImpl ):void
		{
			
		}

		/**
		*	A method to be called when a node has been replaced in the tree.
		*/
		internal function replacedNode( node:NodeImpl ):void
		{
			
		}

		/**
		*	A method to be called when a character data node is about to be replaced
		*/
		internal function replacingData( node:NodeImpl ):void
		{
			
		}

		/**
		* 	A method to be called when a character data node has been replaced.
		*/
		internal function replacedCharacterData(
			node:NodeImpl,
			oldvalue:String,
			value:String):void
		{
		}


		/**
		*	A method to be called when an attribute value has been modified.
		*/
		internal function modifiedAttrValue(
			attr:AttrImpl, oldvalue:String ):void
		{
			
		}

		/**
		*	A method to be called when an attribute node has been set
		*/
		internal function setAttrNode(
			attr:AttrImpl, previous:AttrImpl ):void
		{
			//
		}

		/**
		*	A method to be called when an attribute node has been removed.
		*/
		internal function removedAttrNode(
			attr:AttrImpl,
			oldOwner:NodeImpl,
			name:String ):void
		{
			//
		}

		/**
		*	A method to be called when an attribute node has been renamed.
		*/
		internal function renamedAttrNode( oldAt:Attr, newAt:Attr ):void
		{
			//
		}

		/**
		*	A method to be called when an element has been renamed.
		*/
		internal function renamedElement( oldEl:Element, newEl:Element ):void
		{
			//
		}
	}
}