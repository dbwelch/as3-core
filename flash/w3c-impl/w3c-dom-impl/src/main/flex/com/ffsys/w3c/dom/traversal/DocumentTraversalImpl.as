package com.ffsys.w3c.dom.traversal
{
	import org.w3c.dom.Node;
	
	import org.w3c.dom.traversal.DocumentTraversal;
	import org.w3c.dom.traversal.NodeFilter;
	import org.w3c.dom.traversal.NodeIterator;
	import org.w3c.dom.traversal.TreeWalker;
	
	import com.ffsys.w3c.dom.range.DocumentRangeImpl;
	
	/**
	* 	An implementation for document traversal.
	*/
	public class DocumentTraversalImpl extends DocumentRangeImpl
		implements DocumentTraversal
	{
		/**
		* 	@private
		* 	
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
			var bean:Object = null;
			try
			{
				bean = this.document.getBean(
					NodeIteratorImpl.NAME );
			}catch( e:Error )
			{
				//no bean document assigned most likely
				//not instantiated via IoC
				bean = new NodeIteratorImpl();
			}
			
			var iterator:NodeIterator = NodeIterator( bean );
			
			//TODO: set all the iterator properties
			
			return iterator;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createTreeWalker(
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