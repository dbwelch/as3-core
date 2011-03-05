package javax.xml.parsers
{
	import java.lang.UnsupportedOperationException;
	
	import javax.xml.validation.Schema;

	import org.w3c.dom.Document;
	import org.w3c.dom.DOMImplementation;
	
	/**
	* 	Defines the API to obtain DOM Document instances from an XML document.
	* 
	* 	Using this class, an application programmer can obtain a Document from XML.
	* 
	* 	An instance of this class can be obtained from the
	* 	DocumentBuilderFactory.newDocumentBuilder() method. Once an instance
	* 	of this class is obtained, XML can be parsed from a variety of input sources.
	* 
	* 	These input sources are InputStreams, Files, URLs, and SAX InputSources.
	*/
	public class DocumentBuilder extends Object
	{
		/**
		* 	@private
		* 
		* 	Creates a <code>DocumentBuilder</code> instance.
		*/
		public function DocumentBuilder()
		{
			super();
		}	
		
		/**
		* 	Obtain an instance of a DOMImplementation object.
		*/
		public function getDOMImplementation():DOMImplementation
		{
			return null;
		}
		
		/**
		* 	Get a reference to the the Schema being used by the XML processor.
		* 
		* 	If no schema is being used, null is returned.
		* 
		* 	@return Schema being used or null if none in use	
		*/
		public function getSchema():Schema
		{
			throw new UnsupportedOperationException();
		}
		
		/**
		* 	Indicates whether or not this parser is configured
		* 	to understand namespaces.
		* 
		* 	@return true if this parser is configured to
		* 	understand namespaces; false otherwise.
		*/
		public function isNamespaceAware():Boolean
		{
			return false;
		}
		
		/**
		* 	Indicates whether or not this parser is configured
		* 	to validate XML documents.
		* 
		* 	@return true if this parser is configured to validate
		* 	XML documents; false otherwise.
		*/
		public function isValidating():Boolean
		{
			return false;
		}
		
		/**
		* 	Get the XInclude processing mode for this parser.
		*/
		public function isXIncludeAware():Boolean
		{
			throw new UnsupportedOperationException();
		}
		
		/**
		* 	Obtain a new instance of a DOM Document object
		* 	to build a DOM tree with.
		* 
		* 	@return A new instance of a DOM Document object.
		*/
		public function newDocument():Document
		{
			//TODO
			return null;
		}
	}
}