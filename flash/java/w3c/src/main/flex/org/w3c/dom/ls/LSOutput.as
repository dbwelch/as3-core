package org.w3c.dom.ls
{
	
	/**
	* 	This interface represents an output destination for data.
	* 
	*	This interface allows an application to encapsulate information
	* 	about an output destination in a single object, which may include
	* 	a URI, a byte stream (possibly with a specified encoding),
	* 	a base URI, and/or a character stream.
	* 
	* 	The exact definitions of a byte stream and a character
	* 	stream are binding dependent.
	* 
	* 	The application is expected to provide objects that implement
	* 	this interface whenever such objects are needed. The application
	* 	can either provide its own objects that implement this interface,
	* 	or it can use the generic factory method DOMImplementationLS.createLSOutput()
	* 	to create objects that implement this interface.
	* 
	* 	The LSSerializer will use the LSOutput object to determine where
	* 	to serialize the output to. The LSSerializer will look at the different
	* 	outputs specified in the LSOutput in the following order to know
	* 	which one to output to, the first one that is not null and not an
	* 	empty string will be used:
	* 
	* 	<ol>
	* 		<li><code>LSOutput.characterStream</code></li>
	* 		<li><code>LSOutput.byteStream</code></li>
	* 		<li><code>LSOutput.systemId</code></li>
	* 	</ol>
	* 
	* 	LSOutput objects belong to the application. The DOM implementation
	* 	will never modify them (though it may make copies and modify the
	* 	copies, if necessary).
	* 
	* 	See also the Document Object Model (DOM) Level 3 Load and Save Specification.
	*/
	public interface LSOutput
	{
		
		/*
		
		
		OutputStream	getByteStream() 
		          An attribute of a language and binding dependent type that represents a writable stream of bytes.
		 Writer	getCharacterStream() 
		          An attribute of a language and binding dependent type that represents a writable stream to which 16-bit units can be output.
		 String	getEncoding() 
		          The character encoding to use for the output.
		 String	getSystemId() 
		          The system identifier, a URI reference [IETF RFC 2396], for this output destination.
		 void	setByteStream(OutputStream byteStream) 
		          An attribute of a language and binding dependent type that represents a writable stream of bytes.
		 void	setCharacterStream(Writer characterStream) 
		          An attribute of a language and binding dependent type that represents a writable stream to which 16-bit units can be output.
		 void	setEncoding(String encoding) 
		          The character encoding to use for the output.
		 void	setSystemId(String systemId) 
		          The system identifier, a URI reference [IETF RFC 2396], for this output destination.		
		
		
		*/
	}
}