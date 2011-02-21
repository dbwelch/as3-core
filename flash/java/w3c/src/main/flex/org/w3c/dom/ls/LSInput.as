/**
	<p>Defines the interfaces for the DOM load and save module.</p>
*/
package org.w3c.dom.ls
{
	
	/**
	* 	This interface represents an input source for data.
	* 
	* 	This interface allows an application to encapsulate
	* 	information about an input source in a single object,
	* 	which may include a public identifier, a system identifier,
	* 	a byte stream (possibly with a specified encoding), a
	* 	base URI, and/or a character stream.
	* 
	* 	The exact definitions of a byte stream and a character
	* 	stream are binding dependent.
	* 
	* 	The application is expected to provide objects that
	* 	implement this interface whenever such objects are needed.
	* 	The application can either provide its own objects that
	* 	implement this interface, or it can use the generic factory
	* 	method DOMImplementationLS.createLSInput() to create objects
	* 	that implement this interface.
	* 
	* 	The LSParser will use the LSInput object to determine
	* 	how to read data. The LSParser will look at the different
	* 	inputs specified in the LSInput in the following order to
	* 	know which one to read from, the first one that is not null
	* 	and not an empty string will be used:
	* 
	* 	<ol>
	* 		<li><code>LSInput.characterStream</code></li>
	* 		<li><code>LSInput.byteStream</code></li>
	* 		<li><code>LSInput.stringData</code></li>
	* 		<li><code>LSInput.systemId</code></li>
	* 		<li><code>LSInput.publicId</code></li>
	* 	</ol>
	* 
	* 	<p>If all inputs are null, the LSParser will report a
	* 	DOMError with its DOMError.type set to "no-input-specified"
	* 	and its DOMError.severity set to DOMError.SEVERITY_FATAL_ERROR.</p>
	* 
	* 	<p>LSInput objects belong to the application. The DOM implementation
	* 	will never modify them (though it may make copies and modify the copies, if necessary).</p>
	*/
	public interface LSInput
	{
		
		
		/*
		
		String	getBaseURI() 
		          The base URI to be used (see section 5.1.4 in [IETF RFC 2396]) for resolving a relative systemId to an absolute URI.
		 InputStream	getByteStream() 
		          An attribute of a language and binding dependent type that represents a stream of bytes.
		 boolean	getCertifiedText() 
		          If set to true, assume that the input is certified (see section 2.13 in [XML 1.1]) when parsing [XML 1.1].
		 Reader	getCharacterStream() 
		          An attribute of a language and binding dependent type that represents a stream of 16-bit units.
		 String	getEncoding() 
		          The character encoding, if known.
		 String	getPublicId() 
		          The public identifier for this input source.
		 String	getStringData() 
		          String data to parse.
		 String	getSystemId() 
		          The system identifier, a URI reference [IETF RFC 2396], for this input source.
		 void	setBaseURI(String baseURI) 
		          The base URI to be used (see section 5.1.4 in [IETF RFC 2396]) for resolving a relative systemId to an absolute URI.
		 void	setByteStream(InputStream byteStream) 
		          An attribute of a language and binding dependent type that represents a stream of bytes.
		 void	setCertifiedText(boolean certifiedText) 
		          If set to true, assume that the input is certified (see section 2.13 in [XML 1.1]) when parsing [XML 1.1].
		 void	setCharacterStream(Reader characterStream) 
		          An attribute of a language and binding dependent type that represents a stream of 16-bit units.
		 void	setEncoding(String encoding) 
		          The character encoding, if known.
		 void	setPublicId(String publicId) 
		          The public identifier for this input source.
		 void	setStringData(String stringData) 
		          String data to parse.
		 void	setSystemId(String systemId) 
		          The system identifier, a URI reference [IETF RFC 2396], for this input source.		
		
		
		*/
		
	}
}