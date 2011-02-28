package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;
	
	import com.ffsys.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.ls.DOMImplementationLSImpl;
	import com.ffsys.w3c.dom.ls.LSInputImpl;
	import com.ffsys.w3c.dom.ls.LSOutputImpl;
	import com.ffsys.w3c.dom.ls.serialize.DOMSerializerImpl;
	import com.ffsys.w3c.dom.ls.parser.DOMParserImpl;	
	
	/**
	* 	A boostrap document for the DOM LS implementation.
	*/
	public class DOMLSBootstrap extends DOMEventsBootstrap
	{
		/**
		* 	The name for the <code>DOM</code> LS implementation bean document.
		*/
		public static const NAME:String = DOMFeature.LS_MODULE;
		
		/**
		* 	Creates a <code>DOMLSBootstrap</code> instance.
		* 
		* 	@param identifier An identifier for this document.
		*/
		public function DOMLSBootstrap( identifier:String = null )
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
			addLoadSaveImplementations( beans );
		}
		
		/**
		* 	@private
		*/
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( DOMFeature.LS_FEATURE );
			output.push( DOMFeature.LS_3_FEATURE );
			return output;
		}
		
		/**
		* 	@private
		*/
		protected function getLSImplementationBeanDescriptor():IBeanDescriptor
		{
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				DOMImplementationLSImpl.NAME );
			return descriptor;
		}
		
		/**
		* 	@private
		*/
		protected function addLoadSaveImplementations( impls:IBeanDocument ):void
		{
			
			var descriptor:IBeanDescriptor = getLSImplementationBeanDescriptor();
			descriptor.instanceClass = DOMImplementationLSImpl;
			descriptor.singleton = true;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				LSInputImpl.NAME );
			descriptor.instanceClass = LSInputImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				LSOutputImpl.NAME );
			descriptor.instanceClass = LSOutputImpl;
			impls.addBeanDescriptor( descriptor );	
			
			descriptor = new BeanDescriptor(
				DOMSerializerImpl.NAME );
			descriptor.instanceClass = DOMSerializerImpl;
			impls.addBeanDescriptor( descriptor );		
			
			descriptor = new BeanDescriptor(
				DOMParserImpl.NAME );
			descriptor.instanceClass = DOMParserImpl;
			impls.addBeanDescriptor( descriptor );
		}
	}
}