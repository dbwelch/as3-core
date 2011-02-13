/**
	<p>A collection of interfaces for the !Document Object Model (DOM)
	core level 3 specification.</p>
*/
package org.w3c.dom
{
	/**
	* 	The Element interface represents an
	* 	element in an HTML or XML document. Elements
	* 	may have attributes associated with them;
	* 	since the Element interface inherits from Node,
	* 	the generic Node interface attribute attributes
	* 	may be used to retrieve the set of all attributes
	* 	for an element. There are methods on the Element
	* 	interface to retrieve either an Attr object by
	* 	name or an attribute value by name. In XML, where
	* 	an attribute value may contain entity references,
	* 	an Attr object should be retrieved to examine the
	* 	possibly fairly complex sub-tree representing the
	* 	attribute value. On the other hand, in HTML,
	* 	where all attributes have simple string values,
	* 	methods to directly access an attribute value
	* 	can safely be used as a convenience.
	*/
	public interface Element extends Node
	{
		/**
		* 	The name of the element
		* 
		* 	If Node.localName is different from null,
		* 	this attribute is a qualified name.
		* 	For example, in:
		* 
		* 	<pre>&lt;elementExample id="demo"&gt;
		*	...
		*	&lt;/elementExample&gt;</pre>
		* 
		*	tagName has the value "elementExample".
		* 
		* 	Note that this is case-preserving in XML,
		* 	as are all of the operations of the DOM.
		* 	The HTML DOM returns the tagName of an
		* 	HTML element in the canonical uppercase
		* 	form, regardless of the case
		* 	in the source HTML document.
		*/
		function get tagName():String;
		
		/**
		* 	The type information associated with this element.
		* 
		* 	@since DOM Level 3
		*/
		function get schemaTypeInfo():TypeInfo;
		
		/**
		* 	Retrieves an attribute value by name.
		* 
		* 	@param name The name of the attribute to retrieve.
		* 
		* 	@return The Attr value as a string, or the
		* 	empty string if that attribute does not have
		* 	a specified or default value.
		*/
		function getAttribute( name:String ):String;
		
		/**
		* 	Adds a new attribute.
		* 	
		* 	If an attribute with that name is already
		* 	present in the element, its value is changed
		* 	to be that of the value parameter. This value
		* 	is a simple string; it is not parsed as it
		* 	is being set. So any markup (such as syntax
		* 	to be recognized as an entity reference) is
		* 	treated as literal text, and needs to be
		* 	appropriately escaped by the implementation
		* 	when it is written out. In order to assign
		* 	an attribute value that contains entity references,
		* 	the user must create an Attr node plus any Text
		* 	and EntityReference nodes, build the appropriate
		* 	subtree, and use setAttributeNode to
		* 	assign it as the value of an attribute.
		* 
		*	To set an attribute with a qualified name
		* 	and namespace URI, use the setAttributeNS method.
		* 
		* 	@param name The name of the attribute to create or alter.
		* 	@param value Value to set in string form.
		* 
		* 	@throws DOMException INVALID_CHARACTER_ERR: Raised
		* 	if the specified name is not an XML name according
		* 	to the XML version in use specified in
		* 	the Document.xmlVersion attribute.
		* 	@throws DOMException NO_MODIFICATION_ALLOWED_ERR:
		* 	Raised if this node is readonly.
		*/
		function setAttribute( name:String, value:String ):void;
		
		/**
		* 	Removes an attribute by name.
		* 
		* 	If a default value for the removed
		* 	attribute is defined in the DTD,
		* 	a new attribute immediately appears
		* 	with the default value as well as the
		* 	corresponding namespace URI, local name, and
		* 	prefix when applicable. The implementation
		* 	may handle default values from other schemas
		* 	similarly but applications should use
		* 	Document.normalizeDocument() to guarantee this
		* 	information is up-to-date. 
		* 
		*	If no attribute with the name is found,
		* 	this method has no effect.
		* 
		*	To remove an attribute by local name
		* 	and namespace URI, use the removeAttributeNS method.
		*/
		function removeAttribute( name:String ):void;
		
		/**
		* 	Retrieves an attribute node by name. 
		* 
		*	To retrieve an attribute node by
		* 	qualified name and namespace URI,
		* 	use the getAttributeNodeNS method.
		* 
		* 	@param name The name (<code>nodeName</code>)
		* 	of the attribute to retrieve.
		* 
		* 	@return The Attr node with the specified
		* 	name (<code>nodeName</code>) or null if
		* 	there is no such attribute.
		*/
		function getAttributeNode( name:String ):Attr;
		
		/**
		* 	Adds a new attribute node.
		* 
		* 	If an attribute with that name
		* 	(<code>nodeName</code>) is already present
		* 	in the element, it is replaced by the new one.
		* 
		* 	Replacing an attribute node by itself has no effect.
		* 
		*	To add a new attribute node with a qualified name
		* 	and namespace URI, use the setAttributeNodeNS method.
		*/
		function setAttributeNode( attr:Attr ):Attr;
		
		/**
		* 	Removes the specified attribute node.
		* 	
		* 	If a default value for the removed Attr
		* 	node is defined in the DTD, a new node
		* 	immediately appears with the default value
		* 	as well as the corresponding namespace URI,
		* 	local name, and prefix when applicable.
		* 
		* 	The implementation may handle default values
		* 	from other schemas similarly but applications
		* 	should use Document.normalizeDocument()
		* 	to guarantee this information is up-to-date.
		*/
		function removeAttributeNode( attr:Attr ):Attr;
		
		/**
		* 	Returns a NodeList of all descendant Elements
		* 	with a given tag name, in document order.
		* 
		* 	@param name The name of the tag to match on.
		* 	The special value "*" matches all tags.
		*/
		function getElementsByTagName( name:String ):NodeList;
		
		/**
		* 	Retrieves an attribute value by local name
		* 	and namespace URI.
		* 	
		*	Per [XML Namespaces], applications must use
		* 	the value null as the namespaceURI parameter
		* 	for methods if they wish to have no namespace.
		* 
		* 	@param namespaceURI The namespace URI of the attribute to retrieve.
		* 	@param localName The local name of the attribute to retrieve.
		* 
		* 	@throws DOMException NOT_SUPPORTED_ERR: May be raised
		* 	if the implementation does not support the feature "XML"
		* 	and the language exposed through the Document does not
		* 	support XML Namespaces (such as [HTML 4.01]).
		* 
		* 	@return The Attr value as a string, or the empty
		* 	string if that attribute does not have a
		* 	specified or default value.
		*/
		function getAttributeNS(
			namespaceURI:String, localName:String ):String;
		
		/**
		* 	Adds a new attribute.
		* 
		* 	If an attribute with the same local
		* 	name and namespace URI is already
		* 	present on the element, its prefix
		* 	is changed to be the prefix part of
		* 	the qualifiedName, and its value is changed
		* 	to be the value parameter. This value is a
		* 	simple string; it is not parsed as it is being set.
		* 	So any markup (such as syntax to be recognized as
		* 	an entity reference) is treated as literal text,
		* 	and needs to be appropriately escaped by the
		* 	implementation when it is written out.
		* 	In order to assign an attribute value that contains
		* 	entity references, the user must create an Attr node
		* 	plus any Text and EntityReference nodes, build the
		* 	appropriate subtree, and use setAttributeNodeNS or
		* 	setAttributeNode to assign it as the value
		* 	of an attribute.
		* 
		*	Per [XML Namespaces], applications must use the
		* 	value null as the namespaceURI parameter for
		* 	methods if they wish to have no namespace.
		* 	
		* 	@param namespaceURI The namespace URI of
		* 	the attribute to create or alter.
		* 	@param qualifiedName The qualified name of the
		* 	attribute to create or alter.
		* 	@param value The value to set in string form.
		* 
		* 	@throws DOMException INVALID_CHARACTER_ERR: Raised
		* 	if the specified qualified name is not an XML
		* 	name according to the XML version in use specified
		* 	in the Document.xmlVersion attribute. 
		* 
		*	@throws DOMException NO_MODIFICATION_ALLOWED_ERR:
		* 	Raised if this node is readonly. 
		* 
		*	@throws DOMException NAMESPACE_ERR: Raised if the
		* 	qualifiedName is malformed per the Namespaces in
		* 	XML specification, if the qualifiedName has a prefix
		* 	and the namespaceURI is null, if the qualifiedName
		* 	has a prefix that is "xml" and the namespaceURI is
		* 	different from " http://www.w3.org/XML/1998/namespace",
		* 	if the qualifiedName or its prefix is "xmlns" and
		* 	the namespaceURI is different from "http://www.w3.org/2000/xmlns/",
		* 	or if the namespaceURI is "http://www.w3.org/2000/xmlns/"
		* 	and neither the qualifiedName nor its prefix is "xmlns".
		* 
		*	@throws DOMException NOT_SUPPORTED_ERR: May be raised
		* 	if the implementation does not support the feature "XML"
		* 	and the language exposed through the Document does
		* 	not support XML Namespaces (such as [HTML 4.01]).
		*/
		function setAttributeNS(
			namespaceURI:String,
			qualifiedName:String,
			value:String ):void;
			
		/**
		* 	Removes an attribute by local name and namespace URI.
		* 
		* 	If a default value for the removed attribute is
		* 	defined in the DTD, a new attribute immediately
		* 	appears with the default value as well as the
		* 	corresponding namespace URI, local name, and
		* 	prefix when applicable. The implementation may
		* 	handle default values from other schemas similarly
		* 	but applications should use Document.normalizeDocument()
		* 	to guarantee this information is up-to-date. 
		* 	
		*	If no attribute with this local name and namespace
		* 	URI is found, this method has no effect.
		* 
		*	Per [XML Namespaces], applications must use the
		* 	value null as the namespaceURI parameter for
		* 	methods if they wish to have no namespace.
		* 
		* 	@param namespaceURI The namespace URI of the attribute to remove.
		* 	@param localName The local name of the attribute to remove.
		* 
		* 	@throws DOMException NO_MODIFICATION_ALLOWED_ERR: Raised	
		* 	if this node is readonly. 
		* 
		*	@throws DOMException NOT_SUPPORTED_ERR: May be raised
		* 	if the implementation does not support the feature
		* 	"XML" and the language exposed through the
		* 	Document does not support XML Namespaces (such as [HTML 4.01]).
		*/
		function removeAttributeNS(
			namespaceURI:String,
			localName:String ):void;
			
		/**
		* 	Retrieves an Attr node by local name and namespace URI. 
		* 
		*	Per [XML Namespaces], applications must use the
		* 	value null as the namespaceURI parameter for methods
		* 	if they wish to have no namespace.
		* 
		* 	@param namespaceURI The namespace URI of the attribute to retrieve.
		* 	@param localName The local name of the attribute to retrieve.
		* 
		* 	@throws DOMException NOT_SUPPORTED_ERR: May be
		* 	raised if the implementation does not support
		* 	the feature "XML" and the language exposed
		* 	through the Document does not support
		* 	XML Namespaces (such as [HTML 4.01]).
		*/
		function getAttributeNodeNS(
			namespaceURI:String, localName:String ):Attr;
		
		/**
		* 	Adds a new attribute.
		* 	
		* 	If an attribute with that local name and
		* 	that namespace URI is already present in
		* 	the element, it is replaced by the new one.
		* 
		* 	Replacing an attribute node by itself has no effect. 
		* 
		*	Per [XML Namespaces], applications must use the
		* 	value null as the namespaceURI parameter for
		* 	methods if they wish to have no namespace.
		* 
		* 	@param attr The Attr node to add to the attribute list.
		*/
		function setAttributeNodeNS( attr:Attr ):Attr;
		
		/**
		* 	Returns a NodeList of all the descendant
		* 	Elements with a given local name and
		* 	namespace URI in document order.
		* 
		* 	@param namespaceURI The namespace URI of the
		* 	elements to match on. The special value "*"
		* 	matches all namespaces.
		*	@param localName The local name of the
		* 	elements to match on. The special value "*"
		* 	matches all local names.
		* 
		* 	@throws DOMException - NOT_SUPPORTED_ERR
		* 	May be raised if the implementation does
		* 	not support the feature "XML" and the
		* 	language exposed through the Document does
		* 	not support XML Namespaces (such as [HTML 4.01]).
		* 
		* 	@return A new NodeList object containing
		* 	all the matched Elements.
		*/
		function getElementsByTagNameNS(
			namespaceURI:String, localName:String ):NodeList;
			
		/**
		* 	Returns true when an attribute with a given
		* 	name is specified on this element or has a
		* 	default value, false otherwise.
		* 
		* 	@param name The name of the attribute to look for.
		* 
		* 	@return true if an attribute with the given
		* 	name is specified on this element or has
		* 	a default value, false otherwise.
		*/
		function hasAttribute( name:String ):Boolean;
		
		/**
		*	Returns true when an attribute with a given
		* 	local name and namespace URI is specified
		* 	on this element or has a default value, false otherwise. 
		* 
		*	Per [XML Namespaces], applications must use the value
		* 	null as the namespaceURI parameter for methods if
		* 	they wish to have no namespace.
		*/
		function hasAttributeNS(
			namespaceURI:String, localName:String ):Boolean;
			
		/**
		* 	If the parameter isId is true, this method
		* 	declares the specified attribute to be a
		* 	user-determined ID attribute. This affects
		* 	the value of Attr.isId and the behavior
		* 	of Document.getElementById, but does not
		* 	change any schema that may be in use,
		* 	in particular this does not affect the Attr.schemaTypeInfo
		* 	of the specified Attr node.
		* 	
		* 	Use the value false for the parameter isId
		* 	to undeclare an attribute for being a
		* 	user-determined ID attribute.
		* 
		*	To specify an attribute by local name and namespace URI,
		* 	use the setIdAttributeNS method.
		* 
		* 	@since DOM Level 3
		* 
		* 	@param name The name of the attribute.
		* 	@param isId Whether the attribute is a of type ID.
		* 
		* 	@throws DOMException NO_MODIFICATION_ALLOWED_ERR:
		* 	Raised if this node is readonly. 
		*	@throws DOMException NOT_FOUND_ERR: Raised if the
		* 	specified node is not an attribute of this element.
		*/
		function setIdAttribute(
			name:String, isId:Boolean ):void;
			
		/**
		* 	If the parameter isId is true, this method
		* 	declares the specified attribute to be a
		* 	user-determined ID attribute. This affects
		* 	the value of Attr.isId and the behavior of
		* 	Document.getElementById, but does not change
		* 	any schema that may be in use, in particular
		* 	this does not affect the Attr.schemaTypeInfo
		* 	of the specified Attr node.
		* 
		* 	Use the value false for the parameter isId
		* 	to undeclare an attribute for being a
		* 	user-determined ID attribute.
		* 
		* 	@since DOM Level 3
		* 
		* 	@param namespaceURI The namespace URI of the attribute.
		* 	@param localName The local name of the attribute.
		* 	@param isId Whether the attribute is a of type ID.
		* 
		* 	@throws DOMException NO_MODIFICATION_ALLOWED_ERR: Raised
		* 	if this node is readonly. 
		*	@throws DOMException NOT_FOUND_ERR: Raised if
		* 	the specified node is not an attribute of this element.
		*/
		function setIdAttributeNS(
			namespaceURI:String,
			localName:String,
			isId:Boolean ):void;
			
		/**
		* 	If the parameter isId is true, this method declares
		* 	the specified attribute to be a user-determined
		* 	ID attribute. This affects the value of Attr.isId
		* 	and the behavior of Document.getElementById,
		* 	but does not change any schema that may be in use,
		* 	in particular this does not affect the Attr.schemaTypeInfo
		* 	of the specified Attr node
		* 
		* 	Use the value false for the parameter isId to
		* 	undeclare an attribute for being a user-determined ID attribute.
		* 
		* 	@since DOM Level 3
		* 
		* 	@param idAttr The attribute node.
		* 	@param isId Whether the attribute is a of type ID.
		* 
		* 	@throws DOMException NO_MODIFICATION_ALLOWED_ERR: Raised
		* 	if this node is readonly.
		* 
		*	@throws DOMException NOT_FOUND_ERR: Raised if the
		* 	specified node is not an attribute of this element.
		*/
		function setIdAttributeNode(
			idAttr:Attr, isId:Boolean ):void;
	}
}