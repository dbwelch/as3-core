package org.w3c.dom.traversal
{
	import org.w3c.dom.Node;
	
	/**
	*	Describes the contract for implementations
	* 	that can filter nodes.
	*/
	public interface NodeFilter
	{
		/**
		* 	Determines the filter action to perform
		* 	for a given node.
		* 
		* 	@param n The node.
		* 
		* 	@return Either <code>FILTER_ACCEPT</code>,
		* 	<code>FILTER_REJECT</code> or <code>FILTER_SKIP</code>.
		*/
		function acceptNode( n:Node ):uint;
	}
}