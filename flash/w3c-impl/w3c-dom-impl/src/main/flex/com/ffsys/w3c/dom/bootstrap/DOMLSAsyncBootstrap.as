package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;
	
	import com.ffsys.w3c.dom.DOMFeature;
	
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
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( DOMFeature.LS_ASYNC_FEATURE );
			output.push( DOMFeature.LS_ASYNC_3_FEATURE );
			return output;
		}		
		
		/**
		* 	@private
		*/
		override protected function getLSImplementationBeanDescriptor():IBeanDescriptor
		{
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				DOMImplementationLSImpl.ASYNC_NAME );
			return descriptor;
		}
	}
}