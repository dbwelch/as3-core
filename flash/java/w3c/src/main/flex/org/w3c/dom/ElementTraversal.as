package org.w3c.dom
{
	/**
	* 	Defines the contract for element traversal.	
	* 
	* 	The DOM Level 1 Node interface defines 11 node types,
	* 	but most commonly authors wish to operate solely on nodeType
	* 	1, the Element node.
	* 
	* 	Other node types include the Document element and Text nodes,
	* 	which include whitespace and line breaks. DOM 1 node traversal
	* 	includes all of these node types, which is often a source of
	* 	confusion for authors and which requires an extra step for
	* 	authors to confirm that the expected Element node interfaces
	* 	are available. This introduces an additional performance constraint.
	* 
	* 	ElementTraversal is an interface which allows the author to
	* 	restrict navigation to Element nodes. It permits navigation
	* 	from an element to its first element child, its last element
	* 	child, and to its next or previous element siblings. Because
	* 	the implementation exposes only the element nodes, the memory
	* 	and computational footprint of the DOM representation can be
	* 	optimized for constrained devices.
	* 
	* 	The DOM Level 1 Node interface also defines the childNodes attribute,
	* 	which is a live list of all child nodes of the node; the childNodes
	* 	list has a length attribute to expose the total number of child
	* 	nodes of all nodeTypes, useful for preprocessing operations and
	* 	calculations before, or instead of, looping through the child nodes.
	* 	The ElementTraversal interface has a similar attribute, childElementCount,
	* 	that reports only the number of Element nodes, which is often what
	* 	is desired for such operations.
	*/
	public interface ElementTraversal
	{
		/**
		* 	The first child that is an element.
		*/
		function get firstElementChild():Element;
		
		/**
		* 	The last child that is an element.
		*/
		function get lastElementChild():Element;
		
		/**
		* 	The previous sibling that is an element.
		*/
		function get previousElementSibling():Element;
		
		/**
		* 	The next sibling that is an element.
		*/
		function get nextElementSibling():Element;
		
		/**
		* 	The number of child nodes that are elements.
		*/
		function get childElementCount():uint;
	}
}