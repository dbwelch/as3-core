package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;
	
	import org.w3c.dom.DOMImplementation;
	
	import com.ffsys.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.DOMImplementationImpl;
	import com.ffsys.w3c.dom.DocumentImpl;
	import com.ffsys.w3c.dom.AttrImpl;
	import com.ffsys.w3c.dom.ElementImpl;
	import com.ffsys.w3c.dom.TextImpl;
	import com.ffsys.w3c.dom.DocumentFragmentImpl;
	import com.ffsys.w3c.dom.ProcessingInstructionImpl;
	import com.ffsys.w3c.dom.CommentImpl;
	import com.ffsys.w3c.dom.CDATASectionImpl;
	import com.ffsys.w3c.dom.EntityImpl;
	import com.ffsys.w3c.dom.EntityReferenceImpl;
	
	import com.ffsys.w3c.dom.range.RangeImpl;

	import com.ffsys.w3c.dom.traversal.NodeIteratorImpl;
	import com.ffsys.w3c.dom.traversal.TreeWalkerImpl;
	
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
			super.doWithBeans( beans );
			addDOMNodes( beans );
			addCommonFeatures( beans );
		}
		
		/**
		* 	@private
		*/
		protected function addDOMNodes( impls:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;

			descriptor = new BeanDescriptor(
				DocumentImpl.NAME );
			descriptor.instanceClass = DocumentImpl;
			impls.addBeanDescriptor( descriptor );
			
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
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( DOMFeature.CORE_3_FEATURE );
			output.push( DOMFeature.RANGE_3_FEATURE );
			output.push( DOMFeature.TRAVERSAL_3_FEATURE );
			return output;
		}
		
		/**
		* 	@private
		*/
		override protected function doWithImplementationFactories(
			factories:IBeanDocument ):void
		{
			super.doWithImplementationFactories( factories );
			
			var impl:DOMImplementation =
				new DOMImplementationImpl();
			createImplementationFactory(
				factories,
				DOMImplementationImpl.NAME,
				DOMImplementationImpl,
				impl );
		}
		
		/**
		* 	@private
		*/
		protected function addCommonFeatures( impls:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;
			
			descriptor = new BeanDescriptor(
				RangeImpl.NAME );
			descriptor.instanceClass = RangeImpl;
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