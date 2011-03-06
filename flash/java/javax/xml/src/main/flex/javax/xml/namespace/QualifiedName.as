package javax.xml.namespace
{
	import java.util.Map;
	import java.util.HashMap;
	
	/**
	* 	QualifiedName represents a qualified name as defined
	* 	in the XML specifications: XML Schema Part2:
	* 	Datatypes specification, Namespaces in XML,
	* 	Namespaces in XML Errata.
	* 
	* 	<strong>Note:</strong> This class name could not match
	* 	the Java equivalent <code>QName</code> due to the top-level Actionscript
	* 	class <code>QName</code>. This implementation cannot extend <code>QName</code>
	* 	because <code>QName</code> is final.
	* 
	* 	The value of a QualifiedName contains a <strong>Namespace URI</strong>,
	* 	<strong>local part</strong> and <strong>prefix</strong>.
	* 
	* 	The prefix is included in QualifiedName to retain lexical information
	* 	when present in an XML input source. The prefix is NOT used in
	* 	QualifiedName.equals(Object) or to compute the QualifiedName.hashCode().
	* 	Equality and the hash code are defined using only the
	* 	Namespace URI and local part.
	* 
	* 	If not specified, the Namespace URI is set to XMLConstants.NULL_NS_URI.
	* 	If not specified, the prefix is set to XMLConstants.DEFAULT_NS_PREFIX.
	* 
	* 	QualifiedName is immutable.
	*/
	public class QualifiedName extends Object
	{	
		private static const XMLNS:String = "xmlns";
		private static const DELIMITER:String = ":";
		
		private var _namespaceURI:String;
		private var _localPart:String;
		private var _prefix:String;
		
		/**
		* 	Creates a <code>QualifiedName</code> instance.
		* 
		* 	QualifiedName constructor specifying the Namespace
		* 	URI, local part and prefix.
		* 
		* 	If the Namespace URI is null, it is set to
		* 	XMLConstants.NULL_NS_URI. This value represents no
		* 	explicitly defined Namespace as defined by the
		* 	Namespaces in XML specification. This action preserves
		* 	compatible behavior with QName 1.0. Explicitly
		* 	providing the XMLConstants.NULL_NS_URI value is
		* 	the preferred coding style.
		* 
		* 	If the local part is null an IllegalArgumentException
		* 	is thrown. A local part of "" is allowed to preserve
		* 	compatible behavior with QName 1.0.
		* 
		* 	If the prefix is null, an IllegalArgumentException
		* 	is thrown. Use XMLConstants.DEFAULT_NS_PREFIX to
		* 	explicitly indicate that no prefix is present or the
		* 	prefix is not relevant.
		* 
		* 	The Namespace URI is not validated as a URI reference.
		* 	The local part and prefix are not validated as a NCName
		* 	as specified in Namespaces in XML.
		* 
		* 	@param namespaceURI Namespace URI of the QualifiedName.
		* 	@param localPart Local part of the QualifiedName.
		* 	@param prefix Prefix of the QualifiedName.
		*/
		public function QualifiedName(
			namespaceURI:String,
			localPart:String,
			prefix:String )
		{
			super();
			_namespaceURI = namespaceURI;
			_localPart = localPart;
			_prefix = prefix;
		}
		
		public function getLocalPart():String
		{
			return _localPart;
		}
		
		/**
		* 	@private
		*/
		protected function setLocalPart( value:String ):void
		{
			_localPart = value;
		}
		
		public function getNamespaceURI():String
		{
			return _namespaceURI;
		}
		
		/**
		* 	@private
		*/
		protected function setNamespaceURI( value:String ):void
		{
			_namespaceURI = value;
		}
		
		public function getPrefix():String
		{
			return _prefix;
		}
		
		/**
		* 	@private
		*/
		protected function setPrefix( value:String ):void
		{
			_prefix = value;
		}
		
		public function equals( other:Object ):Boolean
		{
			//TODO
			return false;
		}		
		
		public function hashCode():int
		{
			return -1;
		}
		
		public function toString():String
		{
			return null;
		}
		
		/**
		* 	Retrieves a qualfied name from a prefix
		* 	and local name.
		* 
		* 	@param prefix The namespace prefix.
		* 	@param localName The local name for the qualified name.
		* 
		* 	@return A fully qualified name.
		*/
		public static function toName( prefix:String, localName:String ):String
		{
			if( prefix == null )
			{
				return localName;
			}
			return prefix + DELIMITER + localName;
		}
		
		/**
		* 	Retrives a qualfied name wrapped as a self-closing
		* 	XML element.
		* 
		* 	@param prefix The namespace prefix.
		* 	@param localName The local name for the qualified name.
		* 	@param attributes A map of attributes.
		* 	@param namespaces A list of namespaces to add as attributes.
		* 
		* 	@return A fully qualified element wrapped in a self-closing
		* 	tag.
		*/
		public static function toXMLName(
			prefix:String,
			localName:String,
			attributes:Map = null,
			namespaces:Vector.<Namespace> = null ):String
		{
			var i:int = 0;
			var output:String = "<" + toName( prefix, localName );

			if( namespaces != null )
			{
				var ns:Namespace = null;
				for( i = 0;i < namespaces.length;i++ )
				{
					ns = namespaces[ i ];
					output += " " + toName( XMLNS, ns.prefix )  + "=\"" + ns.uri + "\"";
				}
			}
			
			if( attributes != null )
			{
				var keys:Array = attributes.keySet().toArray();				
				var key:String = null;
				for( i = 0;i < keys.length;i++ )
				{
					key = String( keys[ i ] );
					output += " " + key  + "=\"" + attributes.item( key ) + "\"";
				}
			}
			output += "/>";
			return output;
		}
		
		public static function valueOf( qname:String ):QualifiedName
		{
			//TODO: parse qname
			return null;
		}
	}
}