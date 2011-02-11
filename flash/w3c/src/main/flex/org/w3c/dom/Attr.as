package org.w3c.dom
{
	/**
	* 	Represents an attribute.
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
		* 	The element that owns this attribute.
		* 
		* 	The Element node this attribute is attached
		* 	to or null if this attribute is not in use.
		*/
		function get ownerElement():Element;
		
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