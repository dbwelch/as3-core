package com.ffsys.w3c.dom.traversal
{
	import org.w3c.dom.Node;
	
	import org.w3c.dom.traversal.DocumentTraversal;
	import org.w3c.dom.traversal.NodeFilter;
	import org.w3c.dom.traversal.NodeIterator;
	import org.w3c.dom.traversal.TreeWalker;
	
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.DOMImplementationImpl;
	
	/**
	* 	An implementation for document traversal.
	*/
	public class DocumentTraversalImpl extends DOMImplementationImpl
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
		* 	@private
		*/
		override protected function get supported():Vector.<DOMFeature>
		{
			if( _supported == null )
			{
				_supported = super.supported;
				_supported.push( DOMFeature.TRAVERSAL_FEATURE );
			}
			return _supported;
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