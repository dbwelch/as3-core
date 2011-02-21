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
	*/
	public interface Attributes
	{
		//
		
		/*
		
			int	getIndex(String qName) 
		          Look up the index of an attribute by XML qualified (prefixed) name.
		 int	getIndex(String uri, String localName) 
		          Look up the index of an attribute by Namespace name.
		 int	getLength() 
		          Return the number of attributes in the list.
		 String	getLocalName(int index) 
		          Look up an attribute's local name by index.
		 String	getQName(int index) 
		          Look up an attribute's XML qualified (prefixed) name by index.
		 String	getType(int index) 
		          Look up an attribute's type by index.
		 String	getType(String qName) 
		          Look up an attribute's type by XML qualified (prefixed) name.
		 String	getType(String uri, String localName) 
		          Look up an attribute's type by Namespace name.
		 String	getURI(int index) 
		          Look up an attribute's Namespace URI by index.
		 String	getValue(int index) 
		          Look up an attribute's value by index.
		 String	getValue(String qName) 
		          Look up an attribute's value by XML qualified (prefixed) name.
		 String	getValue(String uri, String localName)		
		
		*/
	}
}