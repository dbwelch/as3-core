package org.w3c.dom
{
	/*
	Interface				nodeName						nodeValue														attributes
	Attr					same as Attr.name				same as Attr.value												null
	CDATASection			"#cdata-section"				same as CharacterData.data,										null
															the content of the CDATA Section
	Comment					"#comment"						same as CharacterData.data,										null
															the content of the comment	
	Document				"#document"						null															null
	DocumentFragment		"#document-fragment"			null															null
	DocumentType			same as DocumentType.name		null															null
	Element					same as Element.tagName			null															NamedNodeMap
	Entity					entity name						null															null
	EntityReference			name of entity referenced		null															null
	Notation				notation name					null															null
	ProcessingInstruction	same as
							ProcessingInstruction.target	same as ProcessingInstruction.data								null
	Text					"#text"							same as CharacterData.data,										null
															the content of the text node
	*/
	
	/**
	* 	Represents a node in the document tree.
	* 
	* 	The Node interface is the primary datatype
	* 	for the entire Document Object Model. It
	* 	represents a single node in the document tree.
	* 	While all objects implementing the Node interface
	* 	expose methods for dealing with children,
	* 	not all objects implementing the Node interface
	* 	may have children. For example, Text nodes may
	* 	not have children, and adding children to such
	* 	nodes results in a DOMException being raised.
	*
	*	The attributes nodeName, nodeValue and attributes
	* 	are included as a mechanism to get at node information
	* 	without casting down to the specific derived interface.
	* 	In cases where there is no obvious mapping of these
	* 	attributes for a specific nodeType (e.g., nodeValue for
	* 	an Element or attributes for a Comment), this returns null.
	* 	Note that the specialized interfaces may contain
	* 	additional and more convenient mechanisms to get
	* 	and set the relevant information.
	*/
	public interface Node
	{		
		/**
		* 	The name of this node.
		*/
		function get nodeName():String;
		
		/**
		* 	A value for this node.
		*/
		function get nodeValue():String;
		function set nodeValue( value:String ):void;
		
		/**
		* 	The type of this node.
		*/
		function get nodeType():Number;
		
		/**
		* 	The parent of this node.
		*/
		function get parentNode():Node;
		
		/**
		* 	The list of child nodes that belong to this node.
		*/
		function get childNodes():NodeList;
		
		/**
		* 	A first child node when this node
		* 	has children.
		*/
		function get firstChild():Node;
		
		/**
		* 	A last child node when this node
		* 	has children.
		*/
		function get lastChild():Node;
		
		/**
		* 	The previous sibling of this node
		* 	if this node has a previous sibling
		* 	otherwise <code>null</code>.
		*/
		function get previousSibling():Node;
		
		/**
		* 	The next sibling of this node
		* 	if this node has a next sibling
		* 	otherwise <code>null</code>.
		*/
		function get nextSibling():Node;
		
		/**
		*	A collection of attributes for this node.
		*/
		function get attributes():NamedNodeMap;
		
		/**
		* 	The document that owns this node.
		*/
		function get ownerDocument():Document;
		
		/**
		* 	A namespace <code>URI></code> for this node.
		*/
		function get namespaceURI():String;
		
		/**
		* 	A namespace prefix associated with this node.
		*/
		function get prefix():String;
		function set prefix( value:String ):void;
		
		/**
		* 	The local name of this node.
		*/
		function get localName():String;
		
		/**
		* 	The base <code>URI></code> for this node.
		*/
		function get baseURI():String;
		
		/**
		* 	Text content for this node.
		*/
		function get textContent():String;
		function set textContent( value:String ):void;
		
		/**
		* 	Inserts a node before another node.
		* 
		* 	@param child The new child to insert.
		* 	@param before The existing reference node to insert before.
		* 
		* 	@return The new child node.
		*/
		function insertBefore( child:Node, before:Node ):Node;
		
		/**
		* 	Replaces a node with another node.
		* 
		* 	@param child The new child to insert.
		* 	@param before The existing reference node to replace.
		* 
		* 	@return The new child node.
		*/
		function replaceChild( child:Node, existing:Node ):Node;
		
		/**
		* 	TODO
		*/
		function removeChild( child:Node ):Node;
		
		/**
		* 	Appends a node to the children of this node.
		* 
		* 	If the specified node is <code>null</code> it will
		* 	not be added.
		* 
		* 	@param child The node to append.
		* 
		* 	@return The specified child node.
		*/
		function appendChild( child:Node ):Node;
		
		/**
		* 	Determines whether this node has any child nodes.
		*/
		function hasChildNodes():Boolean;
		
		/**
		* 	Retrieves a clone of this node.
		* 
		* 	@param deep Whether child nodes should also be cloned.
		* 
		* 	@return A clone of this node.
		*/
		function cloneNode( deep:Boolean ):Node;
				
		/**
		* 	Normalizes adjacent text nodes into
		* 	a single text node.
		*/
		function normalize():void;
		
		/**
		* 	Determines whether a feature is supported.
		* 
		* 	@param feature The feature name.
		* 	@param version A version for the feature.
		* 
		* 	@return Whether the feature is supported.
		*/
		function isSupported(
			feature:String = null, version:String = null ):Boolean;
			
		/**
		* 	Determines whether this node has any attributes.
		* 
		* 	@return Whether this node has any attributes.
		*/
		function hasAttributes():Boolean;
		
		/**
		* 	TODO
		*/
		function compareDocumentPosition( other:Node ):Number;
		
		/**
		* 	TODO
		*/
		function isSameNode( other:Node ):Boolean;
		
		/**
		* 	TODO
		*/
		function lookupPrefix( namespaceURI:String ):String;
		
		/**
		* 	TODO
		*/
		function isDefaultNamespace( namespaceURI:String ):Boolean;
		
		/**
		* 	TODO
		*/
		function lookupNamespaceURI( prefix:String ):String;
		
		/**
		* 	TODO
		*/
		function isEqualNode( arg:Node ):Boolean;
		
		/**
		* 	TODO
		*/
		function getFeature(
			feature:String, version:String ):Object;
			
		/**
		* 	TODO
		*/
		function setUserData(
			key:String, data:*, handler:UserDataHandler ):*;
			
		/**
		* 	TODO
		*/
		function getUserData( key:String ):*;
	}
}