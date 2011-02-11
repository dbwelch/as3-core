package org.w3c.dom
{
	/**
	* 	Represents a document object model implementation.
	* 
	* 	The DOMImplementation interface provides a number
	* 	of methods for performing operations that are
	* 	independent of any particular instance of the
	* 	document object model.
	*/
	public interface DOMImplementation
	{	
		/**
		* 	Determines whether this implementation
		* 	has a specific feature.
		* 
		* 	Test if the DOM implementation implements
		* 	a specific feature and version,
		* 	as specified in DOM Features.
		* 
		* 	@param feature The name of the feature to test.
		* 	@param version This is the version number of
		* 	the feature to test.
		* 
		* 	@return true if the feature is implemented in
		* 	the specified version, false otherwise.
		*/
		function hasFeature(
			feature:String, version:String ):Boolean;
		
		/**
		* 	Creates an empty DocumentType node.
		* 
		* 	Entity declarations and notations are not made available.
		* 	Entity reference expansions and default attribute
		* 	additions do not occur.
		* 
		* 	@param qualifiedName The qualified name of the document
		* 	type to be created.
		* 	@param publicId The external subset public identifier.
		* 	@param systemId The external subset system identifier.
		* 
		* 	@throws DOMException INVALID_CHARACTER_ERR: Raised if the
		* 	specified qualified name is not an XML name according to [XML 1.0].
		* 	
		* 	@throws DOMException NAMESPACE_ERR: Raised if the qualifiedName
		* 	is malformed. 
		* 
		* 	@throws DOMException NOT_SUPPORTED_ERR: May be raised if the
		* 	implementation does not support the feature "XML" and the
		* 	language exposed through the Document does not support
		* 	XML Namespaces (such as [HTML 4.01]).
		* 
		* 	@return A new DocumentType node with Node.ownerDocument
		* 	set to null.
		*/
		function createDocumentType(
			qualifiedName:String,
			publicId:String,
			systemId:String ):DocumentType;
		
		/**
		* 	Creates a DOM Document object of the
		* 	specified type with its document element. 
		* 
		*	Note that based on the DocumentType given
		* 	to create the document, the implementation
		* 	may instantiate specialized Document objects
		* 	that support additional features than the "Core",
		* 	such as "HTML" [DOM Level 2 HTML]. On the other
		* 	hand, setting the DocumentType after the document
		* 	was created makes this very unlikely to happen.
		* 
		* 	Alternatively, specialized Document creation methods,
		* 	such as createHTMLDocument [DOM Level 2 HTML] , can
		* 	be used to obtain specific types of Document objects.
		* 
		* 	@param namespaceURI The namespace URI of the document
		* 	element to create or null.
		* 	@param qualifiedName The qualified name of the document
		* 	element to be created or null.
		* 	@param doctype The type of document to be created or null.
		* 	When doctype is not null, its Node.ownerDocument attribute
		* 	is set to the document being created.
		* 
		* 	@throws DOMException INVALID_CHARACTER_ERR: Raised if the
		* 	specified qualified name is not an XML name according to [XML 1.0]. 
		* 
		* 	@throws DOMException NAMESPACE_ERR: Raised if the qualifiedName
		* 	is malformed, if the qualifiedName has a prefix and the
		* 	namespaceURI is null, or if the qualifiedName is null
		* 	and the namespaceURI is different from null, or if
		* 	the qualifiedName has a prefix that is "xml" and
		* 	the namespaceURI is different from
		* 	"http://www.w3.org/XML/1998/namespace" [XML Namespaces],
		* 	or if the DOM implementation does not support the "XML"
		* 	feature but a non-null namespace URI was provided,
		* 	since namespaces were defined by XML.
		* 
		* 	@throws DOMException WRONG_DOCUMENT_ERR: Raised
		* 	if doctype has already been used with a
		* 	different document or was created from a different
		* 	implementation.
		* 
		* 	@throws DOMException NOT_SUPPORTED_ERR: May be raised if the implementation does not support the feature "XML" and the language exposed through the Document does not support XML Namespaces (such as [HTML 4.01]).
		* 
		* 	@return A new Document object with its document element.
		* 	If the NamespaceURI, qualifiedName, and doctype are null,
		* 	the returned Document is empty with no document element.
		*/
		function createDocument(
			namespaceURI:String,
			qualifiedName:String,
			doctype:DocumentType ):Document;
			
		/**
		* 	This method returns a specialized object
		* 	which implements the specialized APIs of
		* 	the specified feature and version, as
		* 	specified in DOM Features. The specialized
		* 	object may also be obtained by using
		* 	binding-specific casting methods but is not
		* 	necessarily expected to. This method also
		* 	allow the implementation to provide specialized
		* 	objects which do not support the DOMImplementation interface.
		* 
		* 	@since DOM Level 3
		* 
		* 	@param feature The name of the feature requested.
		* 	Note that any plus sign "+" prepended to the name	
		*	of the feature will be ignored since it is
		* 	not significant in the context of this method.
		* 	@param version This is the version number of the feature to test.
		* 
		* 	@return Returns an object which implements the
		* 	specialized APIs of the specified feature and version,
		* 	if any, or null if there is no object which implements
		* 	interfaces associated with that feature. If the DOMObject
		* 	returned by this method implements the DOMImplementation
		* 	interface, it must delegate to the primary core
		* 	DOMImplementation and not return results inconsistent
		* 	with the primary core DOMImplementation such as
		* 	hasFeature, getFeature, etc.
		*/
		function getFeature(
			feature:String, version:String ):Object;
	}
}