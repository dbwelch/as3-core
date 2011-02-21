package org.w3c.dom.ls
{
	/**
	* 	LSSerializerFilters provide applications the ability to examine
	* 	nodes as they are being serialized and decide what nodes should
	* 	be serialized or not.
	* 	
	* 	<p>The LSSerializerFilter interface is based on the
	* 	NodeFilter interface defined in [DOM Level 2 Traversal and Range].</p>
	* 
	* 	<p>Document, DocumentType, DocumentFragment, Notation, Entity,
	* 	and children of Attr nodes are not passed to the filter. The child
	* 	nodes of an EntityReference node are only passed to the filter if
	* 	the EntityReference node is skipped by the method LSParserFilter.acceptNode().</p>
	* 
	* 	<p>When serializing an Element, the element is passed to the
	* 	filter before any of its attributes are passed to the filter.
	* 	Namespace declaration attributes, and default attributes
	* 	(except in the case when "discard-default-content" is set to false),
	* 	are never passed to the filter.</p>
	* 
	* 	<p>The result of any attempt to modify a node passed to a
	* 	LSSerializerFilter is implementation dependent.</p>
	* 
	* 	<p>DOM applications must not raise exceptions in a filter.
	* 	The effect of throwing exceptions from a filter is DOM
	* 	implementation dependent.</p>
	* 
	* 	<p>For efficiency, a node passed to the filter may not be
	* 	the same as the one that is actually in the tree. And the
	* 	actual node (node object identity) may be reused during the
	* 	process of filtering and serializing a document.</p>
	* 
	* 	<p>See also the Document Object Model (DOM) Level 3 Load and Save Specification.</p>
	*/
	public interface LSSerializerFilter
	{
		/**
		* 	Tells the LSSerializer what types of nodes to show to the filter.
		* 	If a node is not shown to the filter using this attribute,
		* 	it is automatically serialized. See NodeFilter for
		* 	definition of the constants. The constants SHOW_DOCUMENT,
		* 	SHOW_DOCUMENT_TYPE, SHOW_DOCUMENT_FRAGMENT, SHOW_NOTATION,
		* 	and SHOW_ENTITY are meaningless here, such nodes will never
		* 	be passed to a LSSerializerFilter. 
		*	Unlike [DOM Level 2 Traversal and Range], the
		* 	SHOW_ATTRIBUTE constant indicates that the Attr nodes are
		* 	shown and passed to the filter.
		* 
		*	The constants used here are defined in [DOM Level 2 Traversal and Range].
		*/
		function getWhatToShow():int;
	}
}