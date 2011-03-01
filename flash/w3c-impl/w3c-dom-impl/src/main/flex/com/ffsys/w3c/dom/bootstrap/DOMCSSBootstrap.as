package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;
	
	import org.w3c.dom.DOMImplementation;
	
	import com.ffsys.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.css.DOMImplementationCSSImpl;
	import com.ffsys.w3c.dom.css.CSSStyleSheetImpl;
	
	/**
	* 	A boostrap document for the DOM CSS implementation.
	*/
	public class DOMCSSBootstrap extends DOMViewsBootstrap
	{
		/**
		* 	The name for the <code>DOM</code> CSS implementation bean document.
		*/
		public static const NAME:String = DOMFeature.CSS_MODULE;
		
		/**
		* 	Creates a <code>DOMCSSBootstrap</code> instance.
		* 
		* 	@param identifier An identifier for this document.
		*/
		public function DOMCSSBootstrap( identifier:String = null )
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
			
			var impl:DOMImplementation =
				new DOMImplementationCSSImpl();
			
			createImplementationFactory(
				factories,
				DOMImplementationCSSImpl.NAME,
				DOMImplementationCSSImpl,
				impl );
				
			createImplementationFactory(
				factories,
				DOMImplementationCSSImpl.CSS_NAME,
				DOMImplementationCSSImpl,
				impl );	
				
			createImplementationFactory(
				factories,
				DOMImplementationCSSImpl.CSS2_NAME,
				DOMImplementationCSSImpl,
				impl );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );
			var descriptor:IBeanDescriptor = null;
			descriptor = new BeanDescriptor(
				CSSStyleSheetImpl.NAME );
			descriptor.instanceClass = CSSStyleSheetImpl;
			beans.addBeanDescriptor( descriptor );
		}
		
		/**
		* 	@private
		*/
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( DOMFeature.CSS_3_FEATURE );
			output.push( DOMFeature.CSS2_3_FEATURE );
			return output;
		}
	}
}