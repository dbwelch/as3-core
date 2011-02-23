package org.w3c.dom.xpath
{
	
	/**
	* 	Defines the contract for an xpath result.
	*/
	public interface XPathResult
	{
		
		
		
		/*
		
		Objects that implement the XPathResult interface:
		Properties of objects that implement the XPathResult interface:
		resultType
		This read-only property is a Number.
		numberValue
		This read-only property is a Number and can raise an object that implements the XPathException interface on retrieval.
		stringValue
		This read-only property is a String and can raise an object that implements the XPathException interface on retrieval.
		booleanValue
		This read-only property is a Boolean and can raise an object that implements the XPathException interface on retrieval.
		singleNodeValue
		This read-only property is an object that implements the Node interface and can raise an object that implements the XPathException interface on retrieval.
		invalidIteratorState
		This read-only property is a Boolean.
		snapshotLength
		This read-only property is a Number and can raise an object that implements the XPathException interface on retrieval.
		Functions of objects that implement the XPathResult interface:
		iterateNext()
		This function returns an object that implements the Node interface.
		This function can raise an object that implements the XPathException interface or the DOMException interface.
		snapshotItem(index)
		This function returns an object that implements the Node interface.
		The index parameter is a Number. 
		This function can raise an object that implements the XPathException interface.
		
		*/
	}

}

