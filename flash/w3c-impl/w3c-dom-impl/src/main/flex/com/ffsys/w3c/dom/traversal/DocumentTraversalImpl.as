package com.ffsys.w3c.dom.traversal
{
	import org.w3c.dom.Node;
	
	import org.w3c.dom.traversal.DocumentTraversal;
	import org.w3c.dom.traversal.NodeFilter;
	import org.w3c.dom.traversal.NodeIterator;
	import org.w3c.dom.traversal.TreeWalker;
	
	/**
	* 	An implementation for document traversal.
	*/
	public class DocumentTraversalImpl extends Object
		implements DocumentTraversal
	{
		/**
		* 	Creates a <code>DocumentTraversalImpl</code> instance.
		*/
		public function DocumentTraversalImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createNodeIterator(
			root:Node,
			whatToShow:uint,
			filter:NodeFilter,
			entityReferenceExpansion:Boolean ):NodeIterator
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createTreeWaker(
			root:Node,
			whatToShow:uint,
			filter:NodeFilter,
			entityReferenceExpansion:Boolean ):TreeWalker
		{
			//TODO
			return null;
		}
	}
}