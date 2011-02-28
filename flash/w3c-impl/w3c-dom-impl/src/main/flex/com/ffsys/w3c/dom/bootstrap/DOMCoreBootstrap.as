package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;
	
	import com.ffsys.w3c.dom.DOMFeature;

	import com.ffsys.w3c.dom.AttrImpl;
	import com.ffsys.w3c.dom.ElementImpl;
	import com.ffsys.w3c.dom.TextImpl;
	import com.ffsys.w3c.dom.DocumentFragmentImpl;
	import com.ffsys.w3c.dom.ProcessingInstructionImpl;
	import com.ffsys.w3c.dom.CommentImpl;
	import com.ffsys.w3c.dom.CDATASectionImpl;
	import com.ffsys.w3c.dom.EntityImpl;
	import com.ffsys.w3c.dom.EntityReferenceImpl;
	
	/**
	* 	A boostrap document for the DOM Core implementation.
	*/
	public class DOMCoreBootstrap extends DOMBootstrap
	{
		/**
		* 	The name for the <code>DOM</code> Core implementation bean document.
		*/
		public static const NAME:String = DOMFeature.CORE_MODULE;
		
		/**
		* 	Creates a <code>DOMCoreBootstrap</code> instance.
		* 
		* 	@param identifier An identifier for this document.
		*/
		public function DOMCoreBootstrap( identifier:String = null )
		{
			if( identifier == null )
			{
				identifier = NAME;
			}
			super( identifier );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			addDOMNodes( beans );		
		}
		
		/**
		* 	@private
		*/
		protected function addDOMNodes( impls:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;

			descriptor = new BeanDescriptor(
				ElementImpl.NAME );
			descriptor.instanceClass = ElementImpl;
			impls.addBeanDescriptor( descriptor );			
			descriptor = new BeanDescriptor(
				AttrImpl.NAME );
			descriptor.instanceClass = AttrImpl;
			impls.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				TextImpl.NAME );
			descriptor.instanceClass = TextImpl;
			impls.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				DocumentFragmentImpl.NAME );
			descriptor.instanceClass = DocumentFragmentImpl;
			impls.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				ProcessingInstructionImpl.NAME );
			descriptor.instanceClass = ProcessingInstructionImpl;
			impls.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				CommentImpl.NAME );
			descriptor.instanceClass = CommentImpl;
			impls.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				CDATASectionImpl.NAME );
			descriptor.instanceClass = CDATASectionImpl;
			impls.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				EntityImpl.NAME );
			descriptor.instanceClass = EntityImpl;
			impls.addBeanDescriptor( descriptor );
			descriptor = new BeanDescriptor(
				EntityReferenceImpl.NAME );
			descriptor.instanceClass = EntityReferenceImpl;
			impls.addBeanDescriptor( descriptor );		
		}
		
		/**
		* 	@private
		*/
		protected function addCommonEventAliases( names:Vector.<String> ):void
		{
			names.push( DOMFeature.MUTATION_EVENTS_MODULE );
			names.push( DOMFeature.MUTATION_NAME_EVENTS_MODULE );
		}
		
		/**
		* 	@private
		*/
		protected function addCommonEvents( impls:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;
						
			//DOM Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.EVENT_INTERFACE );
			descriptor.instanceClass = EventImpl;
			impls.addBeanDescriptor( descriptor );
			
			//DOM Mutation Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.MUTATION_EVENT_INTERFACE );
			descriptor.instanceClass = MutationEventImpl;
			impls.addBeanDescriptor( descriptor );
		}
		
		/**
		* 	@private
		*/
		protected function addCommonFeatures( impls:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;

			descriptor = new BeanDescriptor(
				DOMFeature.RANGE_MODULE );
			descriptor.instanceClass = DocumentRangeImpl;
			descriptor.singleton = true;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				RangeImpl.NAME );
			descriptor.instanceClass = RangeImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				DOMFeature.TRAVERSAL_MODULE );
			descriptor.instanceClass = DocumentTraversalImpl;
			descriptor.singleton = true;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				NodeIteratorImpl.NAME );
			descriptor.instanceClass = NodeIteratorImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				TreeWalkerImpl.NAME );
			descriptor.instanceClass = TreeWalkerImpl;
			impls.addBeanDescriptor( descriptor );							
		}		
	}
}