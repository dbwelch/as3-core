package org.w3c.dom.xpath
{
	import org.w3c.dom.Element;
	
	/**
	* 	Represents an xpath namespace.
	*/
	public interface XPathNamespace
	{
		/**
		* 	The element that owns this xpath namespace.
		*/
		function get ownerElement():Element;
		
		/*
		Properties of the XPathNamespace Constructor function:
		XPathNamespace.XPATH_NAMESPACE_NODE
		The value of the constant XPathNamespace.XPATH_NAMESPACE_NODE is 13.
		*/
	}
}