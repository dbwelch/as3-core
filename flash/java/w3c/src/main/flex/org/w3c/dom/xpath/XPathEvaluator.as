package org.w3c.dom.xpath
{

	public interface XPathEvaluator
	{
		
		/*
		
		Objects that implement the XPathEvaluator interface:
		Functions of objects that implement the XPathEvaluator interface:
		
		createExpression(expression, resolver)
		This function returns an object that implements the XPathExpression interface.
		The expression parameter is a String. 
		The resolver parameter is an object that implements the XPathNSResolver interface. 
		This function can raise an object that implements the XPathException interface or the DOMException interface.
		
		createNSResolver(nodeResolver)
		This function returns an object that implements the XPathNSResolver interface.
		The nodeResolver parameter is an object that implements the Node interface.
		
		evaluate(expression, contextNode, resolver, type, result)
		This function returns an object that implements the Object interface.
		The expression parameter is a String. 
		The contextNode parameter is an object that implements the Node interface. 
		The resolver parameter is an object that implements the XPathNSResolver interface. 
		The type parameter is a Number. 
		The result parameter is an object that implements the Object interface. 
		This function can raise an object that implements the XPathException interface or the DOMException interface.
		
		*/
	}

}

