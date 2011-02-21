package org.w3c.dom
{
	/**
	* 	Represents an attribute.
	* 
	* 	<p>The Attr interface represents an attribute
	* 	in an Element object. Typically the allowable
	* 	values for the attribute are defined in a
	* 	schema associated with the document.</p>
	* 
	* 	<p>Attr objects inherit the Node interface,
	* 	but since they are not actually child nodes
	* 	of the element they describe, the DOM does
	* 	not consider them part of the document tree.
	* 	Thus, the Node attributes parentNode,
	* 	previousSibling, and nextSibling have a
	* 	null value for Attr objects. The DOM takes
	* 	the view that attributes are properties of
	* 	elements rather than having a separate identity
	* 	from the elements they are associated with; this
	* 	should make it more efficient to implement such
	* 	features as default attributes associated with all
	* 	elements of a given type. Furthermore, Attr nodes
	* 	may not be immediate children of a DocumentFragment.
	* 	However, they can be associated with Element nodes
	* 	contained within a DocumentFragment. In short
	* 	users and implementors of the DOM need to be
	* 	aware that Attr nodes have some things in common
	* 	with other objects inheriting the Node interface,
	* 	but they also are quite distinct.</p>
	* 
	* 	<p>The attribute's effective value is determined
	* 	as follows: if this attribute has been explicitly
	* 	assigned any value, that value is the attribute's
	* 	effective value; otherwise, if there is a declaration
	* 	for this attribute, and that declaration includes a
	* 	default value, then that default value is the attribute's
	* 	effective value; otherwise, the attribute does not exist
	* 	on this element in the structure model until it has
	* 	been explicitly added. Note that the Node.nodeValue
	* 	attribute on the Attr instance can also be used to
	* 	retrieve the string version of the attribute's value(s).</p>
	* 
	* 	<p>If the attribute was not explicitly given a value
	* 	in the instance document but has a default value provided
	* 	by the schema associated with the document, an attribute
	* 	node will be created with specified set to false.
	* 	Removing attribute nodes for which a default value is
	* 	defined in the schema generates a new attribute node
	* 	with the default value and specified set to false.
	* 	If validation occurred while invoking
	* 	Document.normalizeDocument(), attribute nodes with
	* 	specified equals to false are recomputed according to
	* 	the default attribute values provided by the schema.
	* 	If no default value is associate with this attribute
	* 	in the schema, the attribute node is discarded.</p>
	* 
	* 	<p>In XML, where the value of an attribute can contain
	* 	entity references, the child nodes of the Attr node
	* 	may be either Text or EntityReference nodes (when these
	* 	are in use; see the description of EntityReference for discussion).</p>
	* 
	* 	<p>The DOM Core represents all attribute values as
	* 	simple strings, even if the DTD or schema associated
	* 	with the document declares them of some specific
	* 	type such as tokenized.</p>
	* 
	* 	<p>The way attribute value normalization is performed
	* 	by the DOM implementation depends on how much the
	* 	implementation knows about the schema in use. Typically,
	* 	the value and nodeValue attributes of an Attr node
	* 	initially returns the normalized value given by the parser.
	* 	It is also the case after Document.normalizeDocument()
	* 	is called (assuming the right options have been set).
	* 	But this may not be the case after mutation, independently
	* 	of whether the mutation is performed by setting the
	* 	string value directly or by changing the Attr child nodes.
	* 	In particular, this is true when character references
	* 	are involved, given that they are not represented in
	* 	the DOM and they impact attribute value normalization.
	* 	On the other hand, if the implementation knows about the
	* 	schema in use when the attribute value is changed,
	* 	and it is of a different type than CDATA,
	* 	it may normalize it again at that time.
	* 	This is especially true of specialized DOM implementations,
	* 	such as SVG DOM implementations, which store attribute
	* 	values in an internal form different from a string.</p>
	* 
	* 	<p>The following examples illustrate
	* 	the relationship between the attribute value in
	* 	the original document (parsed attribute), the value as
	* 	exposed in the DOM, and the serialization of the value:</p>
	* 	
	* 	<ul>
	* 		<li><p>Character reference</p></li>
	* 
	* 	<li><ul>
	* 		<li><em>Parsed attribute value</em>: <code>"x&amp;#178;=5"</code></li>
	* 		<li><em>Initial Attr.value</em>: <code>"x²=5"</code></li>
	* 		<li><em>Serialized attribute value</em>: <code>"x&amp;#178;=5"</code></li>
	*	</ul></li>
	* 
	* 		<li><p>Built-in character entity</p></li>
	* 
	* 	<li><ul>
	* 		<li><em>Parsed attribute value</em>: <code>"y&amp;lt;6"</code></li>
	* 		<li><em>Initial Attr.value</em>: <code>"y&lt;6"</code></li>
	* 		<li><em>Serialized attribute value</em>: <code>"y&amp;lt;6"</code></li>
	*	</ul></li>
	* 
	* 		<li><p>Literal newline between</p></li>
	* 
	* 	<li><ul>
	* 		<li><em>Parsed attribute value</em>: <code>"x=5&amp;#10;y=6"</code></li>
	* 		<li><em>Initial Attr.value</em>: <code>"x=5 y=6"</code></li>
	* 		<li><em>Serialized attribute value</em>: <code>"x=5&amp;#10;y=6"</code></li>
	*	</ul></li>
	* 
	* 		<li><p>Normalized newline between</p></li>
	* 
	* 	<li><ul>
	* 		<li><em>Parsed attribute value</em>: <pre>"x=5
	* 		 y=6"</pre></li>
	* 		<li><em>Initial Attr.value</em>: <code>"x=5 y=6"</code></li>
	* 		<li><em>Serialized attribute value</em>: <code>"x=5 y=6"</code></li>
	*	</ul></li>
	* 
	* 		<li><p>Entity e with literal newline</p></li>
	* 
	* 	<li><ul>
	* 		<li><em>Parsed attribute value</em>: <code>&lt;!ENTITY e '...&amp;#10;...'&gt; [...]&gt; "x=5&amp;e;y=6"</code></li>
	* 		<li><em>Initial Attr.value</em>: <em>Dependent on Implementation and Load Options</em></li>
	* 		<li><em>Serialized attribute value</em>: <em>Dependent on Implementation and Load/Save Options</em></li>
	*	</ul></li>
	* 
	* 	</ul>
	*/
	public interface Attr extends Node
	{
		/**
		* 	The name of this attribute.
		* 
		* 	Returns the name of this attribute.
		* 	If Node.localName is different
		* 	from null, this attribute is a
		* 	qualified name.
		*/
		function get name():String;
		
		/**
		* 	Whether the attribute was specified.
		* 	
		* 	Will be true if this attribute was
		* 	explicitly given a value in the instance document,
		* 	false otherwise. If the application changed
		* 	the value of this attribute node (even if it
		* 	ends up having the same value as the default value)
		* 	then it is set to true. The implementation may handle
		* 	attributes with default values from other schemas
		* 	similarly but applications should use
		* 	Document.normalizeDocument() to guarantee this
		* 	information is up-to-date.
		*/
		function get specified():Boolean;
		
		/**
		* 	The value for the attribute.
		* 
		* 	On retrieval, the value of the attribute
		* 	is returned as a string. Character and
		* 	general entity references are replaced
		* 	with their values. See also the method
		* 	getAttribute on the Element interface.
		* 
		*	On setting, this creates a Text node with the
		* 	unparsed contents of the string, i.e. any
		* 	characters that an XML processor would recognize
		* 	as markup are instead treated as literal text.
		* 	See also the method Element.setAttribute(). 
		*	Some specialized implementations, such as
		* 	some [SVG 1.1] implementations, may do
		* 	normalization automatically, even after
		* 	mutation; in such case, the value on retrieval
		* 	may differ from the value on setting.
		*/
		function get value():String;
		function set value( value:String ):void;
		
		/**
		* 	The element that owns this attribute.
		* 
		* 	The Element node this attribute is attached
		* 	to or null if this attribute is not in use.
		*/
		function get ownerElement():Element;
		
		/**
		* 	The type information associated with this attribute.
		* 	While the type information contained in this
		* 	attribute is guarantee to be correct after loading
		* 	the document or invoking Document.normalizeDocument(),
		* 	schemaTypeInfo may not be reliable if the node was moved.
		*/
		function get schemaTypeInfo():TypeInfo;
		
		/**
		* 	<p>Determines whether this attribute represents an
		* 	identifier.</p>
		* 	
		* 	<p>Returns whether this attribute is known to
		* 	be of type ID (i.e. to contain an identifier
		* 	for its owner element) or not. When it is
		* 	and its value is unique, the ownerElement
		* 	of this attribute can be retrieved using the
		* 	method Document.getElementById . The implementation
		* 	could use several ways to determine if
		* 	an attribute node is known to contain an identifier:</p>
		* 
		* 	<ul>
		* 		<li>If validation occurred using an XML Schema
		* 			[XML Schema Part 1] while loading the document
		* 			or while invoking Document.normalizeDocument(),
		* 			the post-schema-validation infoset contributions
		* 			(PSVI contributions) values are used to determine
		* 			if this attribute is a schema-determined ID attribute
		* 			using the schema-determined ID definition in [XPointer].</li>
		*		<li>If validation occurred using a DTD while loading the document or while invoking Document.normalizeDocument(), the infoset [type definition] value is used to determine if this attribute is a DTD-determined ID attribute using the DTD-determined ID definition in [XPointer].</li>
		* 		<li>from the use of the methods Element.setIdAttribute(),
		* 			Element.setIdAttributeNS(), or Element.setIdAttributeNode(),
		* 			i.e. it is an user-determined ID attribute;
		*			Note: XPointer framework (see section 3.2 in [XPointer] )
		* 			consider the DOM user-determined ID attribute as being
		* 			part of the XPointer externally-determined ID definition.</li>
		* 		<li>using mechanisms that are outside the scope of
		* 			this specification, it is then an externally-determined
		* 			ID attribute. This includes using schema languages different
		* 			from XML schema and DTD.</li>
		* 	</ul>
		*/
		function get isId():Boolean;
	}
}