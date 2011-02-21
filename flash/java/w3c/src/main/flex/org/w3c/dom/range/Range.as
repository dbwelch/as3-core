package org.w3c.dom.range
{

	public interface Range
	{
		/*
		
		The Range class has the following constants:
		Range.START_TO_START
		This constant is of type Number and its value is 0.
		Range.START_TO_END
		This constant is of type Number and its value is 1.
		Range.END_TO_END
		This constant is of type Number and its value is 2.
		Range.END_TO_START
		This constant is of type Number and its value is 3.
		
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
	}
}