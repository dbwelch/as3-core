package org.xml.sax
{
	/**
	* 	Interface for a list of XML attributes.
	* 
	* 	<p>This interface allows access to a list of attributes in three different ways:</p>
	* 
	* 	<ul>
	* 		<li>by attribute index;</li>
	* 		<li>by Namespace-qualified name; or</li>
	* 		<li>by qualified (prefixed) name.</li>
	*	</ul>
	* 
	* 	<p>The list will not contain attributes that were declared
	* 	#IMPLIED but not specified in the start tag. It will also
	* 	not contain attributes used as Namespace declarations
	* 	(xmlns*) unless the http://xml.org/sax/features/namespace-prefixes
	* 	feature is set to true (it is false by default). Because
	* 	SAX2 conforms to the original "Namespaces in XML" recommendation,
	* 	it normally does not give namespace declaration attributes a namespace URI.</p>
	* 
	* 	<p>Some SAX2 parsers may support using an optional feature flag
	* 	(http://xml.org/sax/features/xmlns-uris) to request that those
	* 	attributes be given URIs, conforming to a later backwards-incompatible
	* 	revision of that recommendation. (The attribute's "local name" will
	* 	be the prefix, or "xmlns" when defining a default element namespace.)
	* 	For portability, handler code should always resolve that conflict,
	* 	rather than requiring parsers that can change the setting of that
	* 	feature flag.</p>
	* 
	* 	<p>If the namespace-prefixes feature (see above) is false,
	* 	access by qualified name may not be available;
	* 	if the http://xml.org/sax/features/namespaces feature is
	* 	false, access by Namespace-qualified names may not be available.</p>
	* 
	* 	<p>This interface replaces the now-deprecated SAX1 AttributeList
	* 	interface, which does not contain Namespace support. In addition
	* 	to Namespace support, it adds the getIndex methods (below).</p>
	* 
	* 	<p>The order of attributes in the list is unspecified, and will
	* 	vary from implementation to implementation.</p>
	*/
	public interface Attributes
	{
		/**
		* 	Look up the index of an attribute by XML
		* 	qualified (prefixed) name.
		* 
		* 	@param qname The qualified (prefixed) name.
		* 
		* 	@return The index of the attribute, or -1 if it does not
		* 	appear in the list.
		*/
		function getIndex( qname:String ):int;
		
		/**
		* 	Look up the index of an attribute by Namespace name.
		* 
		* 	@param uri The Namespace URI, or the empty string
		* 	if the name has no Namespace URI.
		* 	@param localName The attribute's local name.
		*/
		function getIndexNS( uri:String, localName:String ):int;
		
		/**
		* 	Return the number of attributes in the list.
		* 
		* 	Once you know the number of attributes, you can
		* 	iterate through the list.
		* 
		* 	@return The number of attributes in the list.
		*/
		function getLength():int;
		
		/**
		* 	Look up an attribute's local name by index.
		* 
		* 	@param index The attribute index (zero-based).
		* 
		* 	@return The local name, or the empty string if Namespace
		* 	processing is not being performed, or null if the
		* 	index is out of range.
		*/
		function getLocalName( index:int ):String;
		
		/**
		* 	Look up an attribute's XML qualified (prefixed)
		* 	name by index.
		* 
		* 	@param index The attribute index (zero-based).
		* 
		* 	@return The XML qualified name, or the empty
		* 	string if none is available, or null if the
		* 	index is out of range.
		*/
		function getQName( index:int ):String;
		
		/**
		* 	Look up an attribute's type by index.
		* 
		* 	The attribute type is one of the strings
		* 	"CDATA", "ID", "IDREF", "IDREFS", "NMTOKEN",
		* 	"NMTOKENS", "ENTITY", "ENTITIES", or "NOTATION"
		* 	(always in upper case).
		* 
		* 	If the parser has not read a declaration for the
		* 	attribute, or if the parser does not report attribute types,
		* 	then it must return the value "CDATA" as stated in
		* 	the XML 1.0 Recommendation (clause 3.3.3, "Attribute-Value Normalization").
		* 
		* 	For an enumerated attribute that is not a notation,
		* 	the parser will report the type as "NMTOKEN".
		* 
		* 	@param index The attribute index (zero-based).
		* 
		* 	@return The attribute's type as a string, or null if
		* 	the index is out of range.
		*/
		function getType( index:int ):String;
		
		/**
		* 	Look up an attribute's type by Namespace name.
		* 
		* 	See getType() for a description of the possible types.
		* 
		* 	@param uri The Namespace URI, or the empty String
		* 	if the name has no Namespace URI.
		* 	@param localName The local name of the attribute.
		* 
		* 	@return The attribute type as a string, or null
		* 	if the attribute is not in the list or if Namespace
		* 	processing is not being performed.
		*/
		function getTypeNS( uri:String, localName:String ):String;
		
		/**
		* 	Look up an attribute's Namespace URI by index.
		* 
		* 	@param index The attribute index (zero-based).
		* 
		* 	@return The Namespace URI, or the empty string
		* 	if none is available, or null if the index is
		* 	out of range.
		*/
		function getURI( index:int ):String;
		
		/**
		* 	Look up an attribute's value by index.
		* 
		* 	If the attribute value is a list of tokens
		* 	(IDREFS, ENTITIES, or NMTOKENS), the tokens will be
		* 	concatenated into a single string with each token
		* 	separated by a single space.
		* 
		* 	@param index The attribute index (zero-based).
		* 
		* 	@return The attribute's value as a string,
		* 	or null if the index is out of range.
		*/
		function getValueByIndex( index:int ):String;		
		
		/**
		* 	Look up an attribute's value by XML
		* 	qualified (prefixed) name.
		* 
		* 	@param qname The XML qualified name.
		* 
		* 	@return The attribute value as a string, or null
		* 	if the attribute is not in the list or if qualified
		* 	names are not available.
		*/
		function getValue( qname:String ):String;
		
		/**
		* 	Look up an attribute's value by Namespace name.
		* 
		* 	@param uri The Namespace URI, or the empty String if
		* 	the name has no Namespace URI.
		* 	@param localName The local name of the attribute.
		* 
		* 	@return The attribute value as a string, or null
		* 	if the attribute is not in the list.
		*/
		function getValueNS( uri:String, localName:String ):String;
	}
}