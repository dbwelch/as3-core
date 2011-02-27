package com.ffsys.w3c.dom.traversal
{
	import org.w3c.dom.Node;
	import org.w3c.dom.traversal.NodeIterator;
	import org.w3c.dom.traversal.NodeFilter;	
	
	import com.ffsys.w3c.dom.DocumentImpl;
	
	/**
	*	Implementation of a NodeIterator, which iterates a 
	*	DOM tree in the expected depth first way.
	*	
	*	<p>The whatToShow and filter functionality is implemented as expected.</p>
	*	
	*	<p>This class also has method removeNode to enable iterator "fix-up"
	*	on DOM remove. It is expected that the DOM implementation call removeNode
	*	right before the actual DOM transformation. If not called by the DOM,
	*	the client could call it before doing the removal.</p>
	* 
	*	<p><strong>Note:</strong> documentation reproduced from xerces-j.</p>
	*/
	public class NodeIteratorImpl extends Object
		implements NodeIterator
	{	
		
		
	    private var fDocument:DocumentImpl;
	    private var fRoot:Node;
	    private var fWhatToShow:uint = NodeFilterImpl.SHOW_ALL;
	    private var fNodeFilter:NodeFilter;
	    private var fDetach:Boolean = false;
	    private var fCurrentNode:Node;
	    private var fForward:Boolean = true;
	    private var fEntityReferenceExpansion:Boolean;
		
		/**
		* 	Creates a <code>NodeIteratorImpl</code> instance.
		* 
		* 	@param document The document implementation.
		* 	@param root The root node to iterate from.
		* 	@param whatToShow The type of nodes to show.
		* 	@param nodeFilter A node filter.
		* 	@param entityReferenceExpansion Whether
		* 	entity references should be expanded.
		*/
		public function NodeIteratorImpl(
			document:DocumentImpl = null,
			root:Node = null,
			whatToShow:int = 0, 
			nodeFilter:NodeFilter = null,
			entityReferenceExpansion:Boolean = false )
		{
			super();
			
	        fDocument = document;
	        fRoot = root;
	        fCurrentNode = null;
	        fWhatToShow = whatToShow;
	        fNodeFilter = nodeFilter;
	        fEntityReferenceExpansion = entityReferenceExpansion;			
		}
	}
}