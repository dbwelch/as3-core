package org.w3c.dom
{
	/**
	* 	Defines the contract for the <code>Selectors-API</code>
	* 	feature, this interface should be implemented by:
	* 
	* 	<ol>
	* 		<li><code>Document</code></li>
	* 		<li><code>DocumentFragment</code></li>
	* 		<li><code>Element</code></li>
	* 	</ol>
	* 
	* 	@see http://www.w3.org/TR/2010/WD-selectors-api2-20100119/index.html
	*/
	public interface NodeSelector
	{
		/**
		* 	Retrieves the first matching Element node within the
		* 	subtrees of the context node. If there is no such node,
		* 	the method will return null.
		* 
		* 	@param selectors The selectors.
		* 	@param referenceNodes An optional collection of reference nodes.
		* 
		* 	@return The first matching Element or null if no nodes
		* 	were matched.
		*/
		function querySelector(
			selectors:String, ...referenceNodes ):Element;
			
		/**
		* 	Retrieves a NodeList containing all of the matching Element
		* 	nodes within the subtrees of the context node, in document order.
		* 	If there are no such nodes, the method will return an empty NodeList.
		* 
		* 	@param selectors The selectors.
		* 	@param referenceNodes An optional collection of reference nodes.
		* 
		* 	@return A list of all matching nodes or an empty list.
		*/
		function querySelectorAll(
			selectors:String, ...referenceNodes ):NodeList;
			
		/**
		* 	Retrieves the first matching Element node within the entire DOM
		* 	tree in which the context node is located. If there is no such node,
		* 	the method must return null.
		* 
		* 	@param selectors The selectors.
		* 
		* 	@return The first matching Element or null if no nodes
		* 	were matched.
		*/
		function queryScopedSelector(
			selectors:String ):Element;
			
		/**
		* 	Retrieves a NodeList containing all of the matching Element nodes
		* 	within the entire DOM tree in which the context node is located,
		* 	in document order. If there are no such nodes, the method will
		* 	return an empty NodeList.
		* 
		* 	@param selectors The selectors.
		* 
		* 	@return A list of all matching nodes or an empty list.
		*/
		function queryScopedSelectorAll(
			selectors:String ):NodeList;
	}
}