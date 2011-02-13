package org.w3c.xml.sax
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
	}
}