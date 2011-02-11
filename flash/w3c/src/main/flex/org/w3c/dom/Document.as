package org.w3c.dom
{
	/**
	* 	Represents a document.
	*/
	public interface Document extends Node
	{
		/**
		* 	The document type for this document.
		* 
		* 	The Document Type Declaration (see DocumentType)
		* 	associated with this document. For XML documents
		* 	without a document type declaration this returns null.
		* 	For HTML documents, a DocumentType object may be returned,
		* 	independently of the presence or absence of document
		* 	type declaration in the HTML document.
		* 
		*	This provides direct access to the DocumentType node,
		* 	child node of this Document. This node can be set at
		* 	document creation time and later changed through the
		* 	use of child nodes manipulation methods, such as
		* 	Node.insertBefore, or Node.replaceChild.
		* 
		* 	Note, however, that while some implementations may
		* 	instantiate different types of Document objects
		* 	supporting additional features than the "Core",
		* 	such as "HTML" [DOM Level 2 HTML] , based on
		* 	the DocumentType specified at creation time,
		* 	changing it afterwards is very unlikely to result
		* 	in a change of the features supported.
		*/
		function get doctype():DocumentType;
		
		/**
		* 	The implementation that created this document.
		* 
		* 	The DOMImplementation object that handles this document.
		* 	A DOM application may use objects from multiple implementations.
		*/
		function get implementation():DOMImplementation;
		
		/**
		* 	The document element.
		* 
		* 	This is a convenience attribute that allows direct
		* 	access to the child node that is the document element
		* 	of the document.
		*/
		function get documentElement():Element;
		
		/**
		* 	The input encoding.
		* 
		* 	An attribute specifying the encoding used
		* 	for this document at the time of the parsing.
		* 	This is null when it is not known, such as
		* 	when the Document was created in memory.
		*/
		function get inputEncoding():String;
		
		/**
		* 	An XML encoding.
		* 
		* 	An attribute specifying, as part of the
		* 	XML declaration, the encoding of this document.
		* 	This is null when unspecified or when it is not
		* 	known, such as when the Document was created in memory.
		*/
		function get xmlEncoding():String;
		
		/**
		* 	Whether the XML is standalone.
		* 
		* 	An attribute specifying, as part of the XML
		* 	declaration, whether this document is standalone.
		* 	This is false when unspecified.
		* 
		*	Note: No verification is done on the value when
		* 	setting this attribute. Applications should use
		* 	Document.normalizeDocument() with the "validate"
		* 	parameter to verify if the value matches the validity
		* 	constraint for standalone document declaration as defined
		* 	in [XML 1.0].
		* 
		* 	@throws DOMException - NOT_SUPPORTED_ERR: Raised if this
		* 	document does not support the "XML" feature.
		*/
		function get xmlStandalone():Boolean;
		function set xmlStandalone( value:Boolean ):void;
		
		/**
		* 	The XML version.
		* 
		* 	An attribute specifying, as part of the XML
		* 	declaration, the version number of this document.
		* 	If there is no declaration and if this document
		* 	supports the "XML" feature, the value is "1.0".
		* 	If this document does not support the "XML" feature,
		* 	the value is always null. Changing this attribute
		* 	will affect methods that check for invalid characters
		* 	in XML names. Application should invoke Document.normalizeDocument()
		* 	in order to check for invalid characters in the Nodes
		* 	that are already part of this Document. 
		*	DOM applications may use the DOMImplementation.hasFeature(feature, version)
		* 	method with parameter values "XMLVersion" and "1.0" (respectively)
		* 	to determine if an implementation supports [XML 1.0].
		* 	DOM applications may use the same method with parameter
		* 	values "XMLVersion" and "1.1" (respectively) to determine if
		* 	an implementation supports [XML 1.1]. In both cases, in order
		* 	to support XML, an implementation must also support the "XML"
		* 	feature defined in this specification. Document objects
		* 	supporting a version of the "XMLVersion" feature must
		* 	not raise a NOT_SUPPORTED_ERR exception for the same
		* 	version number when using Document.xmlVersion.
		* 
		* 	@throws DOMException - NOT_SUPPORTED_ERR: Raised if the
		* 	version is set to a value that is not supported
		* 	by this Document or if this document does not
		* 	support the "XML" feature.
		*/
		function get xmlVersion():String;
		function set xmlVersion( value:String ):void;
		
		/**
		* 	Whether strict error checking is enabled.
		* 
		* 	An attribute specifying whether error
		* 	checking is enforced or not. When set to
		* 	false, the implementation is free to not
		* 	test every possible error case normally
		* 	defined on DOM operations, and not raise
		* 	any DOMException on DOM operations or report
		* 	errors while using Document.normalizeDocument().
		* 	In case of error, the behavior is undefined.
		* 	This attribute is true by default.
		*/
		function get strictErrorChecking():Boolean;
		function set strictErrorChecking( value:Boolean ):void;
		
		/**
		* 	A document URI.
		* 
		* 	The location of the document or null if undefined or if the Document was created using DOMImplementation.createDocument. No lexical checking is performed when setting this attribute; this could result in a null value returned when using Node.baseURI.
		* 	
		*	Beware that when the Document supports the feature "HTML" [DOM Level 2 HTML] , the href attribute of the HTML BASE element takes precedence over this attribute when computing Node.baseURI.
		*/
		function get documentURI():String;
		function set documentURI( value:String ):void;
		
		/**
		* 	A DOMConfiguration implementation.
		* 
		* 	The configuration used when
		* 	Document.normalizeDocument() is invoked.
		*/
		function get domConfig():DOMConfiguration;
		
		/**
		* 	Creates an element by tag name.
		* 
		* 	Creates an element of the type specified.
		* 	Note that the instance returned implements
		* 	the Element interface, so attributes can be
		* 	specified directly on the returned object. 
		*	In addition, if there are known attributes
		* 	with default values, Attr nodes representing
		* 	them are automatically created and attached
		* 	to the element. 
		* 
		*	To create an element with a qualified name
		* 	and namespace URI, use the createElementNS method.
		* 
		* 	@param tagName The tag name of the element to create.
		* 
		* 	@return A new Element object with the nodeName
		* 	attribute set to tagName, and localName,
		* 	prefix, and namespaceURI set to null.
		* 
		* 	@throws DOMException - INVALID_CHARACTER_ERR: Raised
		* 	if the specified name is not an XML name according
		* 	to the XML version in use specified in the
		* 	Document.xmlVersion attribute.
		*/
		function createElement( tagName:String ):Element;
		
		/**
		* 	Creates a qualified element.
		* 
		* 	Creates an element of the given qualified name and namespace URI. 
		*	Per [XML Namespaces] , applications must use the value null
		* 	as the namespaceURI parameter for methods if they wish to have
		* 	no namespace.
		* 
		* 	@param namespaceURI The namespace URI of the element to create.
		* 	@param qualifiedName The qualified name of the element type to instantiate.
		* 
		* 	@throws DOMException - INVALID_CHARACTER_ERR: Raised if
		* 	the specified qualifiedName is not an XML name according
		* 	to the XML version in use specified in the Document.xmlVersion
		* 	attribute. 
		*	@throws DOMException - NAMESPACE_ERR: Raised if the
		* 	qualifiedName is a malformed qualified name,
		* 	if the qualifiedName has a prefix and the
		* 	namespaceURI is null, or if the qualifiedName has a
		* 	prefix that is "xml" and the namespaceURI is different
		* 	from " http://www.w3.org/XML/1998/namespace" [XML Namespaces],
		* 	or if the qualifiedName or its prefix is "xmlns" and the
		* 	namespaceURI is different from "http://www.w3.org/2000/xmlns/",
		* 	or if the namespaceURI is "http://www.w3.org/2000/xmlns/"
		* 	and neither the qualifiedName nor its prefix is "xmlns". 
		* 
		*	@throws DOMException - NOT_SUPPORTED_ERR: Always thrown if
		* 	the current document does not support the "XML" feature,
		* 	since namespaces were defined by XML.
		* 
		* 	@return A new Element object with the following attributes:
		* 
		* 	<ul>
		* 		<li>Node.nodeName -- qualifiedName</li>
		* 		<li>Node.namespaceURI -- namespaceURI</li>
		* 		<li>Node.prefix	-- prefix, extracted from qualifiedName, or null if there is no prefix</li>
		* 		<li>Node.localName -- local name, extracted from qualifiedName</li>
		* 		<li>Element.tagName -- qualifiedName</li>
		* 	</ul>
		*/
		function createElementNS( 
			namespaceURI:String, qualifiedName:String ):Element;
			
		/**
		* 	Creates a document fragment.
		* 
		* 	Creates an empty DocumentFragment object.
		* 
		* 	@return A new DocumentFragment.
		*/
		function createDocumentFragment():DocumentFragment;
		
		/**
		* 	Creates a Text node given the specified string.
		* 
		* 	@param data The data for the node.
		* 
		* 	@return The new Text object.
		*/
		function createTextNode( data:String ):Text;
		
		/**
		* 	Creates a Comment node given the specified string.
		* 
		* 	@param data The data for the node.
		* 
		* 	@return The new Comment object.
		*/
		function createComment( data:String ):Comment;
		
		/**
		* 	Creates a CDATASection node whose value
		* 	is the specified string.
		* 
		* 	@param data The data for the CDATASection contents.
		* 
		* 	@throws DOMException - NOT_SUPPORTED_ERR: Raised if
		* 	this document is an HTML document.
		* 
		* 	@return The new CDATASection object.
		*/
		function createCDATASection( data:String ):CDATASection;
		
		/**
		* 	Creates a ProcessingInstruction node given the
		* 	specified target and data strings.
		* 
		* 	@param target The target part of the processing instruction
		* 	Unlike Document.createElementNS or Document.createAttributeNS,
		* 	no namespace well-formed checking is done on the target name.
		* 	Applications should invoke Document.normalizeDocument() with
		* 	the parameter "namespaces" set to true in order to ensure
		* 	that the target name is namespace well-formed.
		* 
		* 	@param data The data for the node.
		* 
		* 	@return The new ProcessingInstruction object.
		*/
		function createProcessingInstruction(
			target:String, data:String ):ProcessingInstruction;
				
		/**
		* 	Creates an Attr of the given name.
		* 	
		* 	Note that the Attr instance can then be
		* 	set on an Element using the setAttributeNode method. 
		* 	
		*	To create an attribute with a qualified name and
		* 	namespace URI, use the createAttributeNS method.
		* 
		* 	@param name The name of the attribute.
		* 
		* 	@throws DOMException - INVALID_CHARACTER_ERR: Raised
		* 	if the specified name is not an XML name according
		* 	to the XML version in use specified in the
		* 	Document.xmlVersion attribute.
		* 
		* 	@return A new Attr object with the nodeName
		* 	attribute set to name, and localName,
		* 	prefix, and namespaceURI set to null.
		* 	The value of the attribute is the empty string.
		* 
		* 	
		*/
		function createAttribute( name:String ):Attr;
		
		/**
		* 	Creates an attribute of the given qualified
		* 	name and namespace URI.
		* 
		*	Per [XML Namespaces], applications must use the valu
		* 	null as the namespaceURI parameter for methods
		* 	if they wish to have no namespace.
		* 
		* 	@param namespaceURI The namespace URI of the attribute to create.
		* 	@param qualifiedName The qualified name of the attribute to instantiate.
		* 
		* 	@return The created attribute.
		*/
		function createAttributeNS(
			namespaceURI:String, qualifiedName:String ):Attr;
			
		/**
		* 	Creates an EntityReference object. In addition,
		* 	if the referenced entity is known, the child
		* 	list of the EntityReference node is made the same
		* 	as that of the corresponding Entity node.
		* 
		* 	Note: If any descendant of the Entity node has an
		* 	unbound namespace prefix, the corresponding descendant
		* 	of the created EntityReference node is also unbound;
		* 	(its namespaceURI is null). The DOM Level 2 and 3
		* 	do not support any mechanism to resolve namespace prefixes
		* 	in this case.
		* 
		* 	@param name The name of the entity reference.
		* 
		* 	@return An entity reference implementation.
		*/
		function createEntityReference( name:String ):EntityReference;
	}
}