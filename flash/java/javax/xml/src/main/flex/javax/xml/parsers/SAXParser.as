package javax.xml.parsers
{
	
	/**
	* 	Defines the API that wraps an XMLReader implementation class.
	* 
	* 	In JAXP 1.0, this class wrapped the Parser interface, however
	* 	this interface was replaced by the XMLReader. For ease of
	* 	transition, this class continues to support the same name and
	* 	interface as well as supporting new methods. An instance of this
	* 	class can be obtained from the SAXParserFactory.newSAXParser()
	* 	method. Once an instance of this class is obtained, XML can be
	* 	parsed from a variety of input sources. These input sources are
	* 	InputStreams, Files, URLs, and SAX InputSources.
	* 
	* 	This static method creates a new factory instance based on a
	* 	system property setting or uses the platform default if no
	* 	property has been defined.
	* 
	* 	The system property that controls which Factory implementation
	* 	to create is named "javax.xml.parsers.SAXParserFactory". This
	* 	property names a class that is a concrete subclass of this
	* 	abstract class. If no property is defined, a platform default
	* 	will be used.
	* 
	* 	As the content is parsed by the underlying parser, methods of
	* 	the given HandlerBase or the DefaultHandler are called.
	* 
	* 	Implementors of this class which wrap an underlaying implementation
	* 	can consider using the ParserAdapter class to initially adapt their
	* 	SAX1 implementation to work under this revised class.
	*/
	public class SAXParser extends Object
	{
		/**
		* 	@private
		* 
		* 	Creates a <code>SAXParser</code> instance.
		*/
		public function SAXParser()
		{
			super();
		}
		
		/*
		
		abstract  Object	getProperty(String name) 
		          Returns the particular property requested for in the underlying implementation of XMLReader.
		
		 Schema	getSchema() 
		          Get a reference to the the Schema being used by the XML processor.
		
		abstract  XMLReader	getXMLReader() 
		          Returns the XMLReader that is encapsulated by the implementation of this class.
		
		abstract  boolean	isNamespaceAware() 
		          Indicates whether or not this parser is configured to understand namespaces.
		
		abstract  boolean	isValidating() 
		          Indicates whether or not this parser is configured to validate XML documents.
		
		 boolean	isXIncludeAware() 
		          Get the XInclude processing mode for this parser.
		
		 void	parse(File f, DefaultHandler dh) 
		          Parse the content of the file specified as XML using the specified DefaultHandler.
		
		 void	parse(InputStream is, DefaultHandler dh, String systemId) 
		          Parse the content of the given InputStream instance as XML using the specified DefaultHandler.
		
		 void	parse(String uri, DefaultHandler dh) 
		          Parse the content described by the giving Uniform Resource Identifier (URI) as XML using the specified DefaultHandler.
		
		 void	parse(String uri, HandlerBase hb) 
		          Parse the content described by the giving Uniform Resource Identifier (URI) as XML using the specified HandlerBase.
		
		 void	reset() 
		          Reset this SAXParser to its original configuration.
		
		abstract  void	setProperty(String name, Object value) 
		          Sets the particular property in the underlying implementation of XMLReader.
		
		*/
	}
}