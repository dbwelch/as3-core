package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;
	
	import org.w3c.dom.DOMImplementation;
	
	import org.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.css.CSSDocumentElementImpl;
	
	import com.ffsys.w3c.dom.css.CSSStyleSheetImpl;	
	import com.ffsys.w3c.dom.css.CSSCharsetRuleImpl;
	import com.ffsys.w3c.dom.css.CSSFontFaceRuleImpl;
	import com.ffsys.w3c.dom.css.CSSImportRuleImpl;
	import com.ffsys.w3c.dom.css.CSSMediaRuleImpl;
	import com.ffsys.w3c.dom.css.CSSPageRuleImpl;
	import com.ffsys.w3c.dom.css.CSSStyleRuleImpl;
	import com.ffsys.w3c.dom.css.CSSUnknownRuleImpl;
	import com.ffsys.w3c.dom.css.DOMImplementationCSSImpl;	
	
	
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
			
			var descriptor:IBeanDescriptor =
				new BeanDescriptor( CSSStyleSheetImpl.NAME );
			descriptor.instanceClass = CSSStyleSheetImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				CSSDocumentElementImpl.NAME );
			descriptor.instanceClass = CSSDocumentElementImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				CSSCharsetRuleImpl.NAME );
			descriptor.instanceClass = CSSCharsetRuleImpl;
			beans.addBeanDescriptor( descriptor );		
			
			descriptor = new BeanDescriptor(
				CSSFontFaceRuleImpl.NAME );
			descriptor.instanceClass = CSSFontFaceRuleImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				CSSImportRuleImpl.NAME );
			descriptor.instanceClass = CSSImportRuleImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				CSSMediaRuleImpl.NAME );
			descriptor.instanceClass = CSSMediaRuleImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				CSSPageRuleImpl.NAME );
			descriptor.instanceClass = CSSPageRuleImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				CSSStyleRuleImpl.NAME );
			descriptor.instanceClass = CSSStyleRuleImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				CSSUnknownRuleImpl.NAME );
			descriptor.instanceClass = CSSUnknownRuleImpl;
			beans.addBeanDescriptor( descriptor );
		}
		
		/**
		* 	@private
		*/
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( DOMFeature.CSS_2_FEATURE );
			output.push( DOMFeature.CSS2_2_FEATURE );
			return output;
		}
	}
}