package org.w3c.dom.ls
{
	/**
	* 	A LSSerializer provides an API for serializing (writing)
	* 	a DOM document out into XML.
	* 
	* 	<p>The XML data is written to a string or an output stream.
	* 	Any changes or fixups made during the serialization affect
	* 	only the serialized data. The Document object and its children
	* 	are never altered by the serialization operation.</p>
	* 
	* 	<p>During serialization of XML data, namespace fixup is
	* 	done as defined in [DOM Level 3 Core] , Appendix B.
	* 	[DOM Level 2 Core] allows empty strings as a real
	* 	namespace URI. If the namespaceURI of a Node is empty
	* 	string, the serialization will treat them as null,
	* 	ignoring the prefix if any.</p>
	* 
	* 	<p>LSSerializer accepts any node type for serialization.
	* 	For nodes of type Document or Entity, well-formed XML will
	* 	be created when possible (well-formedness is guaranteed if
	* 	the document or entity comes from a parse operation and is
	* 	unchanged since it was created). The serialized output for
	* 	these node types is either as a XML document or an External
	* 	XML Entity, respectively, and is acceptable input for an
	* 	XML parser. For all other types of nodes the serialized
	* 	form is implementation dependent.</p>
	* 
	* 	<p>Within a Document, DocumentFragment, or Entity being
	* 	serialized, Nodes are processed as follows:</p>
	* 
	* 	<ul>
	* 		<li>Document nodes are written, including the XML
	* 		declaration (unless the parameter "xml-declaration"
	* 		is set to false) and a DTD subset, if one exists in the
	* 		DOM. Writing a Document node serializes the entire document.</li>
	* 		<li>Entity nodes, when written directly by LSSerializer.write,
	* 		outputs the entity expansion but no namespace fixup is done.
	* 		The resulting output will be valid as an external entity.</li>
	* 		<li>If the parameter " entities" is set to true, EntityReference
	* 		nodes are serialized as an entity reference of the form "&amp;entityName;"
	* 		in the output. Child nodes (the expansion) of the entity reference
	* 		are ignored. If the parameter "entities" is set to false, only
	* 		the children of the entity reference are serialized. EntityReference
	* 		nodes with no children (no corresponding Entity node or the
	* 		corresponding Entity nodes have no children) are always serialized.</li>
	* 		<li>CDATAsections containing content characters that cannot be
	* 		represented in the specified output encoding are handled according
	* 		to the "split-cdata-sections" parameter. If the parameter is set to true,
	* 		CDATAsections are split, and the unrepresentable characters are serialized
	* 		as numeric character references in ordinary content. The exact position
	* 		and number of splits is not specified. If the parameter is set to false,
	* 		unrepresentable characters in a CDATAsection are reported as "wf-invalid-character"
	* 		errors if the parameter "well-formed" is set to true. The error is not recoverable
	* 		-- there is no mechanism for supplying alternative characters and
	* 		continuing with the serialization.</li>
	* 		<li>DocumentFragment nodes are serialized by serializing the
	* 		children of the document fragment in the order they appear in
	* 		the document fragment.</li>
	* 		<li>All other node types (Element, Text, etc.) are serialized
	* 		to their corresponding XML source form.</li>
	* 	</ul>
	* 
	* 	<p><strong>Note:</strong> The serialization of a Node does
	* 	not always generate a well-formed XML document, i.e. a LSParser
	* 	might throw fatal errors when parsing the resulting serialization.</p>
	* 
	* 	<p>Within the character data of a document (outside of markup),
	* 	any characters that cannot be represented directly are replaced
	* 	with character references. Occurrences of '&lt;' and '&amp;' are
	* 	replaced by the predefined entities &lt;lt; and &amp;amp;. The
	* 	other predefined entities (&amp;gt;, &amp;apos;, and &amp;quot;)
	* 	might not be used, except where needed (e.g. using &gt;gt; in cases
	* 	such as ']]&gt;'). Any characters that cannot be represented
	* 	directly in the output character encoding are serialized as
	* 	numeric character references (and since character encoding
	* 	standards commonly use hexadecimal representations of characters,
	* 	using the hexadecimal representation when serializing character
	* 	references is encouraged).</p>
	* 
	* 	<p>To allow attribute values to contain both single and double quotes,
	* 	the apostrophe or single-quote character (') may be represented as
	* 	"&amp;apos;", and the double-quote character (") as "&amp;quot;".
	* 	New line characters and other characters that cannot be represented
	* 	directly in attribute values in the output character encoding are
	* 	serialized as a numeric character reference.</p>
	* 
	* 	<p>Within markup, but outside of attributes, any occurrence
	* 	of a character that cannot be represented in the output character
	* 	encoding is reported as a DOMError fatal error. An example would be
	* 	serializing the element <code>&lt;LaCañada/&gt;</code> with encoding="us-ascii".
	* 	This will result with a generation of a DOMError "wf-invalid-character-in-node-name"
	* 	(as proposed in "well-formed").</p>
	* 
	* 	<p>When requested by setting the parameter "normalize-characters"
	* 	on LSSerializer to true, character normalization is performed
	* 	according to the definition of fully normalized characters
	* 	included in appendix E of [XML 1.1] on all data to be serialized,
	* 	both markup and character data. The character normalization process
	* 	affects only the data as it is being written; it does not alter the
	* 	DOM's view of the document after serialization has completed.</p>
	* 
	* 	<p>Implementations are required to support the encodings
	* 	"UTF-8", "UTF-16", "UTF-16BE", and "UTF-16LE" to guarantee
	* 	that data is serializable in all encodings that are required
	* 	to be supported by all XML parsers. When the encoding is UTF-8,
	* 	whether or not a byte order mark is serialized, or if the output
	* 	is big-endian or little-endian, is implementation dependent. When
	* 	the encoding is UTF-16, whether or not the output is big-endian
	* 	or little-endian is implementation dependent, but a Byte Order Mark
	* 	must be generated for non-character outputs, such as
	* 	LSOutput.byteStream or LSOutput.systemId. If the Byte Order Mark
	* 	is not generated, a "byte-order-mark-needed" warning is reported.
	* 	When the encoding is UTF-16LE or UTF-16BE, the output is big-endian
	* 	(UTF-16BE) or little-endian (UTF-16LE) and the Byte Order Mark is
	* 	not be generated. In all cases, the encoding declaration, if
	* 	generated, will correspond to the encoding used during the
	* 	serialization (e.g. encoding="UTF-16" will appear if
	* 	UTF-16 was requested).</p>
	* 
	* 	<p>Namespaces are fixed up during serialization, the serialization
	* 	process will verify that namespace declarations, namespace prefixes
	* 	and the namespace URI associated with elements and attributes are
	* 	consistent. If inconsistencies are found, the serialized form of
	* 	the document will be altered to remove them. The method used for
	* 	doing the namespace fixup while serializing a document is the
	* 	algorithm defined in Appendix B.1, "Namespace normalization",
	* 	of [DOM Level 3 Core].</p>
	* 
	* 	<p>While serializing a document, the parameter
	* 	"discard-default-content" controls whether or not non-specified
	* 	data is serialized.</p>
	* 
	* 	<p>While serializing, errors and warnings are reported to
	* 	the application through the error handler (LSSerializer.domConfig's
	* 	"error-handler" parameter). This specification does in no way try to
	* 	define all possible errors and warnings that can occur while
	* 	serializing a DOM node, but some common error and warning cases
	* 	are defined. The types ( DOMError.type) of errors and warnings
	* 	defined by this specification are:</p>
	* 
	* 	<ul>
	* 		<li><code>"no-output-specified" [fatal]</code> -- 
	* 		Raised when writing to a LSOutput if no output is specified in the LSOutput.</li>
	* 		<li><code>"unbound-prefix-in-entity-reference" [fatal]</code> --
	* 		Raised if the configuration parameter "namespaces" is set to true
	* 		and an entity whose replacement text contains unbound namespace
	* 		prefixes is referenced in a location where there are no bindings for
	* 		the namespace prefixes.</li>
	* 		<li><code>"unsupported-encoding" [fatal]</code> --
	* 		Raised if an unsupported encoding is encountered.</li>
	* 	</ul>
	* 
	* 	<p>In addition to raising the defined errors and warnings,
	* 	implementations are expected to raise implementation specific errors
	* 	and warnings for any other error and warning cases such as IO errors
	* 	(file not found, permission denied,...) and so on.</p>
	* 
	* 	<p>See also the Document Object Model (DOM) Level 3 Load and Save Specification.</p>
	*/
	public interface LSSerializer
	{
		/*
		
	 DOMConfiguration	getDomConfig() 
	          The DOMConfiguration object used by the LSSerializer when serializing a DOM node.
	 LSSerializerFilter	getFilter() 
	          When the application provides a filter, the serializer will call out to the filter before serializing each Node.
	 String	getNewLine() 
	          The end-of-line sequence of characters to be used in the XML being written out.
	 void	setFilter(LSSerializerFilter filter) 
	          When the application provides a filter, the serializer will call out to the filter before serializing each Node.
	 void	setNewLine(String newLine) 
	          The end-of-line sequence of characters to be used in the XML being written out.
	 boolean	write(Node nodeArg, LSOutput destination) 
	          Serialize the specified node as described above in the general description of the LSSerializer interface.
	 String	writeToString(Node nodeArg) 
	          Serialize the specified node as described above in the general description of the LSSerializer interface.
	 boolean	writeToURI(Node nodeArg, String uri) 
	          A convenience method that acts as if LSSerializer.write was called with a LSOutput with no encoding specified and LSOutput.systemId set to the uri argument.		
		
		*/
	}
}