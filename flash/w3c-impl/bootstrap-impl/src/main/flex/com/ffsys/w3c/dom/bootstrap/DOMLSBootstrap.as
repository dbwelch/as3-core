package com.ffsys.w3c.dom.bootstrap
{
	import org.flashx.ioc.BeanDescriptor;
	import org.flashx.ioc.IBeanDocument;
	import org.flashx.ioc.IBeanDescriptor;
	import org.flashx.ioc.InjectedBeanDescriptor;
	
	import org.w3c.dom.DOMFeature;
	
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
		* 	@private
		*/
		static protected var __singleton:DOMImplementationLSImpl;
		
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
			output.push( DOMFeature.LS_3_FEATURE );
			return output;
		}
		
		/**
		* 	@private
		*/
		override protected function doWithImplementationFactories(
			factories:IBeanDocument ):void
		{
			super.doWithImplementationFactories( factories );
			if( __singleton == null )
			{
				__singleton = new DOMImplementationLSImpl();
			}
			createImplementationFactory(
				factories,
				DOMImplementationLSImpl.NAME,
				DOMImplementationLSImpl,
				__singleton );
		}
		
		/**
		* 	@private
		*/
		protected function addLoadSaveImplementations( impls:IBeanDocument ):void
		{
			
			var descriptor:IBeanDescriptor = null;
			
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