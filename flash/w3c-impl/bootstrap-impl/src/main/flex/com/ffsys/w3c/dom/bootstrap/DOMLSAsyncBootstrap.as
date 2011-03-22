package com.ffsys.w3c.dom.bootstrap
{
	import org.flashx.ioc.BeanDescriptor;
	import org.flashx.ioc.IBeanDocument;
	import org.flashx.ioc.IBeanDescriptor;
	import org.flashx.ioc.InjectedBeanDescriptor;	
	
	import org.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.ls.DOMImplementationLSImpl;	
	
	/**
	* 	A boostrap document for the DOM LS-Async implementation.
	*/
	public class DOMLSAsyncBootstrap extends DOMLSBootstrap
	{
		/**
		* 	The name for the <code>DOM</code> LS-Async implementation bean document.
		*/
		public static const NAME:String = DOMFeature.LS_ASYNC_MODULE;
		
		/**
		* 	Creates a <code>DOMLSAsyncBootstrap</code> instance.
		* 
		* 	@param identifier An identifier for this document.
		*/
		public function DOMLSAsyncBootstrap( identifier:String = null )
		{
			if( identifier == null )
			{
				identifier = NAME;
			}
			super( identifier );
		}
		
		/**
		* 	@private
		*/
		override protected function doWithImplementationFactories(
			factories:IBeanDocument ):void
		{
			super.doWithImplementationFactories( factories );
			createImplementationFactory(
				factories,
				DOMImplementationLSImpl.ASYNC_NAME, 
				DOMImplementationLSImpl,
				__singleton );
		}
		
		/**
		* 	@private
		*/
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( DOMFeature.LS_ASYNC_3_FEATURE );
			return output;
		}
	}
}