package org.w3c.dom.traversal
{
	import org.w3c.dom.Node;
	
	/**
	* 	Defines the contract for implementations
	* 	that can create DOM traversal implementations.
	*/
	public interface DocumentTraversal
	{
		//This method can raise a DOMException object.
				
		/**
		* 	Creates a node iterator.
		* 
		* 	@param root The root node for the iteration.
		* 	@param whatToShow The type of node to show.
		* 	@param filter A node filter.
		* 	@param entityReferenceExpansion Whether
		* 	entity references should be expanded.
		* 	
		* 	@return A node iterator.
		*/
		function createNodeIterator(
			root:Node,
			whatToShow:uint,
			filter:NodeFilter,
			entityReferenceExpansion:Boolean ):NodeIterator;
		
		//This method can raise a DOMException object.
		
		/**
		* 	Creates a tree walker.
		* 
		* 	@param root The root node for the tree walk.
		* 	@param whatToShow The type of node to show.
		* 	@param filter A node filter.
		* 	@param entityReferenceExpansion Whether
		* 	entity references should be expanded.
		* 	
		* 	@return A node iterator.
		*/
		function createTreeWaker(
			root:Node,
			whatToShow:uint,
			filter:NodeFilter,
			entityReferenceExpansion:Boolean ):TreeWalker;
	}
}