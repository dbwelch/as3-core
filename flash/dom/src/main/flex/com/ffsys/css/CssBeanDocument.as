package com.ffsys.css
{
	import com.ffsys.dom.DomCoreBeanDocument;
	
	import com.ffsys.ioc.*;
	
	//
	import com.ffsys.css.*;	
	
	/**
	* 	Defines the bean descriptors for css documents.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class CssBeanDocument extends DomCoreBeanDocument
	{
		/**
		* 	The default name for css bean documents.
		*/
		public static const NAME:String = "css";
		
		/**
		* 	Creates a CssBeanDocument instance.
		*/
		public function CssBeanDocument()
		{
			this.id = NAME;
			super();
		}
		
		/**
		* 	Initialies the css beans on
		* 	the specified document.
		* 
		* 	@param beans The document to initialize
		* 	with the bean definitions.
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );
			
			var data:Object = null;
			
			//CORE CSS ELEMENTS
			var descriptor:IBeanDescriptor = new BeanDescriptor(
				CssIdentifiers.STYLE_SHEET );
			descriptor.instanceClass = CssStyleSheet;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			
			//style sheet type injector
			beans.types.push( new BeanTypeInjector(
				CssIdentifiers.STYLE_SHEET,
				CssIdentifiers.STYLE_SHEET,
				StyleSheetAware,
				descriptor ) );		
			
			data = new Object();
			data.stylesheet = new BeanReference(
				CssIdentifiers.DOCUMENT,
				null,
				CssIdentifiers.STYLE_SHEET );
			
			descriptor = new BeanDescriptor(
				CssIdentifiers.DOCUMENT, data );
			descriptor.instanceClass = CssDocument;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				CssIdentifiers.SELECTOR );
			descriptor.instanceClass = Selector;
			beans.addBeanDescriptor( descriptor );
			
			//hook in the style manager
			
			/*
			descriptor = new BeanDescriptor( 
				CssIdentifiers.STYLE_MANAGER );
			descriptor.instanceClass = StyleManager;
			descriptor.singleton = true;
			beans.addBeanDescriptor( descriptor );
			

			*/		
				
			descriptor = new BeanDescriptor(
				CssIdentifiers.AT_RULE );
			descriptor.instanceClass = AtRule;
			beans.addBeanDescriptor( descriptor );				
			
			descriptor = new BeanDescriptor(
				CssIdentifiers.STYLE_RULE );
			descriptor.instanceClass = StyleRule;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				CssIdentifiers.STYLE_PROPERTY );
			descriptor.instanceClass = StyleProperty;
			beans.addBeanDescriptor( descriptor );
		}
	}
}