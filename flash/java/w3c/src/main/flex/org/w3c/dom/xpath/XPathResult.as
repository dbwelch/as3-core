package org.w3c.dom.xpath
{
	import org.w3c.dom.Node;
	
	/**
	* 	Defines the contract for an xpath result.
	*/
	public interface XPathResult
	{
		
		/**
		* 	The result type.
		*/
		function get resultType():uint;
		
		/**
		* 	A numeric value.
		*/
		function get numberValue():Number;
		
		/**
		* 	A string value.
		*/
		function get stringValue():String;
		
		/**
		* 	A boolean value.
		*/
		function get booleanValue():Boolean;
		
		/**
		* 	A single node value.
		*/
		function get singleNodeValue():Node;
		
		/**
		* 	The invalid iterator state.
		*/
		function get invalidIteratorState():Boolean;
		
		/**
		* 	The length of a snapshot.
		*/
		function get snapshotLength():Number;
		
		/**
		* 	Retrieve the next matched node.
		* 
		* 	@return The next available matched node.
		*/
		function iterateNext():Node;
		
		/**
		* 	Retrieve a snapshot item at the specified
		* 	index.
		* 
		* 	@param index The index for the snapshot.
		* 
		* 	@return The node at the specified index.
		*/
		function snapshotItem( index:uint ):Node;
		
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

