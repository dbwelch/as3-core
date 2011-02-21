package javax.xml
{
	
	/**
	* 	Utility class to contain basic XML
	* 	values as constants.
	*/
	public class XMLConstants extends Object
	{
		
		/**
		* 	Namespace URI to use to represent that there is no Namespace.
		*
		*	Defined by the Namespace specification to be "".
		*/
		public static const DEFAULT_NS_PREFIX:String = "";
		
		/**
		* 	Feature for secure processing.
		* 
		* 	<ul>
		* 		<li>true instructs the implementation to process XML securely.
		* 		This may set limits on XML constructs to avoid conditions such
		* 		as denial of service attacks.</li>
		* 		<li>false instructs the implementation to process XML according
		* 		to the letter of the XML specifications ingoring security issues
		* 		such as limits on XML constructs to avoid conditions such as
		* 		denial of service attacks.</li>
		* 	</ul>
		*/
		public static const FEATURE_SECURE_PROCESSING:String =
			"http://javax.xml.XMLConstants/feature/secure-processing";
		
		/**
		* 	Namespace URI to use to represent that there is no Namespace.
		*
		*	Defined by the Namespace specification to be "".
		*/
		public static const NULL_NS_URI:String = "";	
		
		/**
		* 	RELAX NG Namespace URI.
		*
		*	Defined to be "http://relaxng.org/ns/structure/1.0".
		*/
		public static const RELAXNG_NS_URI:String =
			"http://relaxng.org/ns/structure/1.0";
		
		/**
		* 	W3C XML Schema Instance Namespace URI.
		*
		*	Defined to be "http://www.w3.org/2001/XMLSchema-instance".
		*/
		public static const W3C_XML_SCHEMA_INSTANCE_NS_URI:String =
			"http://www.w3.org/2001/XMLSchema-instance";
		
		/**
		* 	W3C XML Schema Namespace URI.
		*
		*	Defined to be "http://www.w3.org/2001/XMLSchema".
		*/
		public static const W3C_XML_SCHEMA_NS_URI:String =
			"http://www.w3.org/2001/XMLSchema";
		
		/**
		* 	W3C XPath Datatype Namespace URI.
		*
		*	Defined to be "http://www.w3.org/2003/11/xpath-datatypes".
		*/
		public static const W3C_XPATH_DATATYPE_NS_URI:String =
			"http://www.w3.org/2003/11/xpath-datatypes";
		
		/**
		* 	XML Document Type Declaration Namespace URI as an arbitrary value.
		*
		*	Since not formally defined by any existing standard,
		* 	arbitrarily defined to be "http://www.w3.org/TR/REC-xml".
		*/
		public static const XML_DTD_NS_URI:String =
			"http://www.w3.org/TR/REC-xml";
		
		/**
		* 	The official XML Namespace prefix.
		*
		*	Defined by the XML specification to be "xml".
		*/
		public static const XML_NS_PREFIX:String =
			"xml";
		
		/**
		* 	The official XML Namespace name URI.
		*
		*	Defined by the XML specification to be
		* 	"http://www.w3.org/XML/1998/namespace".
		*/
		public static const XML_NS_URI:String =
			"http://www.w3.org/XML/1998/namespace";
		
		/**
		* 	The official XML attribute used for specifying XML Namespace declarations.
		*
		*	It is NOT valid to use as a prefix.
		* 	Defined by the XML specification to be "xmlns".
		*/
		public static const XMLNS_ATTRIBUTE:String =
			"xmlns";
		
		/**
		* 	The official XML attribute used for specifying XML
		* 	Namespace declarations, XMLConstants.XMLNS_ATTRIBUTE, 
		* 	Namespace name URI.
		*
		*	Defined by the XML specification to be "http://www.w3.org/2000/xmlns/".
		*/
		public static const XMLNS_ATTRIBUTE_NS_URI:String =
			"http://www.w3.org/2000/xmlns/";
	}
}