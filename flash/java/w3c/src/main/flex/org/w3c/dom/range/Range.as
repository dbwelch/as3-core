package org.w3c.dom.range
{
	import org.w3c.dom.Node;
	
	/**
	* 	Represents a range of nodes.
	*/
	public interface Range
	{
		/**
		* 	The start container for the range.
		*/
		function get startContainer():Node;
		
		/**
		* 	The start offset for the range.
		*/
		function get startOffset():uint;
		
		/**
		* 	The end container for the range.
		*/
		function get endContainer():Node;
		
		/**
		* 	The end offset for the range.
		*/
		function get endOffset():uint;
		
		/**
		* 	Determines if this range is collapsed.
		*/
		function get collapsed():Boolean;
		
		/**
		* 	A common ancestor container.
		*/
		function get commonAncestorContainer():Node;
		
		/*
		
		The Range object has the following methods:
		
		setStart(refNode, offset)
		This method has no return value.
		The refNode parameter is a Node object.
		The offset parameter is a long object.
		This method can raise a RangeException object or a DOMException object.
		
		setEnd(refNode, offset)
		This method has no return value.
		The refNode parameter is a Node object.
		The offset parameter is a long object.
		This method can raise a RangeException object or a DOMException object.
		
		setStartBefore(refNode)
		This method has no return value.
		The refNode parameter is a Node object.
		This method can raise a RangeException object or a DOMException object.
		
		setStartAfter(refNode)
		This method has no return value.
		The refNode parameter is a Node object.
		This method can raise a RangeException object or a DOMException object.
		
		setEndBefore(refNode)
		This method has no return value.
		The refNode parameter is a Node object.
		This method can raise a RangeException object or a DOMException object.
		
		setEndAfter(refNode)
		This method has no return value.
		The refNode parameter is a Node object.
		This method can raise a RangeException object or a DOMException object.
		
		collapse(toStart)
		This method has no return value.
		The toStart parameter is of type Boolean.
		This method can raise a DOMException object.
		
		selectNode(refNode)
		This method has no return value.
		The refNode parameter is a Node object.
		This method can raise a RangeException object or a DOMException object.
		
		selectNodeContents(refNode)
		This method has no return value.
		The refNode parameter is a Node object.
		This method can raise a RangeException object or a DOMException object.
		
		compareBoundaryPoints(how, sourceRange)
		This method returns a short object.
		The how parameter is of type Number.
		The sourceRange parameter is a Range object.
		This method can raise a DOMException object.
		
		deleteContents()
		This method has no return value.
		This method can raise a DOMException object.
		
		extractContents()
		This method returns a DocumentFragment object.
		This method can raise a DOMException object.
		
		cloneContents()
		This method returns a DocumentFragment object.
		This method can raise a DOMException object.
		
		insertNode(newNode)
		This method has no return value.
		The newNode parameter is a Node object.
		This method can raise a DOMException object or a RangeException object.
		
		surroundContents(newParent)
		This method has no return value.
		The newParent parameter is a Node object.
		This method can raise a DOMException object or a RangeException object.
		
		cloneRange()
		This method returns a Range object.
		This method can raise a DOMException object.
		
		toString()
		This method returns a String.
		This method can raise a DOMException object.
		
		detach()
		This method has no return value.
		This method can raise a DOMException object.
		
		*/
		
		
		/*
		
		The Range object has the following properties:
		startContainer
		This read-only property is a Node object and can raise a DOMException object on retrieval.
		startOffset
		This read-only property is a long object and can raise a DOMException object on retrieval.
		endContainer
		This read-only property is a Node object and can raise a DOMException object on retrieval.
		endOffset
		This read-only property is a long object and can raise a DOMException object on retrieval.
		collapsed
		This read-only property is of type Boolean and can raise a DOMException object on retrieval.
		commonAncestorContainer
		This read-only property is a Node object and can raise a DOMException object on retrieval.		
		*/
	}
}