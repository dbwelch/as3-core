package org.w3c.dom.xpath
{
	import org.w3c.dom.Node;
	
	/**
	* 	Represents an xpath expression.
	*/
	public interface XPathExpression
	{
		
		/**
		* 	Evaluate an xpath expression.
		* 
		* 	@param contextNode The context node.
		* 	@param type 
		* 	@param result
		* 
		* 	@return
		*/
		function evaluate(
			contextNode:Node, type:Number, result:Object ):Object;
		
		/*
		
		Objects that implement the XPathExpression interface:
		Functions of objects that implement the XPathExpression interface:
		
		evaluate(contextNode, type, result)
		
		This function returns an object that implements the Object interface.
		The contextNode parameter is an object that implements the Node interface. 
		The type parameter is a Number. 
		The result parameter is an object that implements the Object interface. 
		
		
		This function can raise an object that implements the XPathException interface or the DOMException interface.		
		
		*/
	}
}