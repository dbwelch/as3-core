package org.w3c.dom.ls
{
	
	/**
	* 	LSResourceResolver provides a way for applications
	* 	to redirect references to external resources.
	* 
	* 	<p>Applications needing to implement custom handling
	* 	for external resources can implement this interface
	* 	and register their implementation by setting the
	* 	"resource-resolver" parameter of DOMConfiguration
	* 	objects attached to LSParser and LSSerializer.
	* 	It can also be register on DOMConfiguration objects
	* 	attached to Document if the "LS" feature is supported.</p>
	* 
	* 	<p>The LSParser will then allow the application to
	* 	intercept any external entities, including the external
	* 	DTD subset and external parameter entities, before including
	* 	them. The top-level document entity is never passed
	* 	to the resolveResource method.</p>
	* 
	* 	<p>Many DOM applications will not need to implement this
	* 	interface, but it will be especially useful for
	* 	applications that build XML documents from databases
	* 	or other specialized input sources, or for applications
	* 	that use URNs.</p>
	* 
	* 	<p><strong>Note:</strong> LSResourceResolver is based on
	* 	the SAX2 [SAX] EntityResolver interface.</p>
	* 
	* 	<p>See also the Document Object Model (DOM) Level 3 Load and Save Specification.</p>
	*/
	public interface LSResourceResolver
	{
		/**
		* 	Allow the application to resolve external resources. 
		* 
		* 	<p>The LSParser will call this method before opening any
		* 	external resource, including the external DTD subset,
		* 	external entities referenced within the DTD, and external
		* 	entities referenced within the document element (however,
		* 	the top-level document entity is not passed to this method).
		* 	The application may then request that the LSParser resolve the
		* 	external resource itself, that it use an alternative URI, or
		* 	that it use an entirely different input source.</p>
		* 
		* 	<p>Application writers can use this method to redirect external
		* 	system identifiers to secure and/or local URI, to look up public
		* 	identifiers in a catalogue, or to read an entity from a database
		* 	or other input source (including, for example, a dialog box).</p>
		* 
		* 	@param type The type of the resource being resolved. For
		* 	XML [XML 1.0] resources (i.e. entities), applications must use
		* 	the value "http://www.w3.org/TR/REC-xml". For XML Schema
		* 	[XML Schema Part 1], applications must use the value
		* 	"http://www.w3.org/2001/XMLSchema". Other types of resources are
		* 	outside the scope of this specification and therefore should
		* 	recommend an absolute URI in order to use this method.
		* 	@param namespaceURI The namespace of the resource being resolved,
		* 	e.g. the target namespace of the XML Schema [XML Schema Part 1]
		* 	when resolving XML Schema resources.
		* 	@param publicId The public identifier of the external entity
		* 	being referenced, or null if no public identifier was supplied
		* 	or if the resource is not an entity.
		* 	@param systemId The system identifier, a URI reference [IETF RFC 2396],
		* 	of the external resource being referenced, or null if no system
		* 	identifier was supplied.
		* 	@param baseURI The absolute base URI of the resource being parsed,
		* 	or null if there is no base URI.
		* 
		* 	@return A LSInput object describing the new input source,
		* 	or null to request that the parser open a regular URI connection to the resource.
		*/
		function resolveResource(
			type:String,
			namespaceURI:String,
			publicId:String,
			systemId:String,
			baseURI:String):LSInput;
	}
}