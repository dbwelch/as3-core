package org.w3c.dom.xpath
{
	/**
	* 	Defines the contract for implementations
	* 	that resolve an xpath namespace.
	*/
	public interface XPathNSResolver
	{
		/**
		* 	Retrieves a namespace URI based using
		* 	the specified prefix.
		* 
		* 	@param prefix The namespace prefix.
		* 
		* 	@return The namespace URI or null if the prefix
		* 	is not bound.
		*/
		function lookupNamespaceURI( prefix:String ):String;
	}
}