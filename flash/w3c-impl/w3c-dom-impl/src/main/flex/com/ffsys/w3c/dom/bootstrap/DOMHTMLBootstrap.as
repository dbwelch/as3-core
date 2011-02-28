package com.ffsys.w3c.dom.bootstrap
{
	import com.ffsys.ioc.BeanDescriptor;
	import com.ffsys.ioc.IBeanDocument;
	import com.ffsys.ioc.IBeanDescriptor;	
	
	import com.ffsys.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.events.FocusEventImpl;
	import com.ffsys.w3c.dom.events.UIEventImpl;	
	
	import com.ffsys.w3c.dom.html.HTMLDocumentImpl;
	import com.ffsys.w3c.dom.html.HTMLDOMImplementationImpl;
	
	import com.ffsys.w3c.dom.html.HTMLHtmlElementImpl;
	import com.ffsys.w3c.dom.html.HTMLHeadElementImpl;
	import com.ffsys.w3c.dom.html.HTMLBodyElementImpl;
	import com.ffsys.w3c.dom.html.HTMLTitleElementImpl;
	
	//
	import com.ffsys.w3c.dom.events.DocumentEventImpl;
	
	/**
	* 	A boostrap document for the DOM HTML implementation.
	*/
	public class DOMHTMLBootstrap extends DOMCoreBootstrap
	{
		/**
		* 	The name for the <code>DOM</code> HTML implementation bean document.
		*/
		public static const NAME:String = DOMFeature.HTML_MODULE;
		
		/**
		* 	Creates a <code>DOMHTMLBootstrap</code> instance.
		* 
		* 	@param identifier An identifier for this document.
		*/
		public function DOMHTMLBootstrap( identifier:String = null )
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
			
			var descriptor:IBeanDescriptor = null;
			
			descriptor = new BeanDescriptor(
				HTMLDOMImplementationImpl.NAME );
			descriptor.instanceClass = HTMLDOMImplementationImpl;
			beans.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				HTMLDocumentImpl.NAME );
			descriptor.instanceClass = HTMLDocumentImpl;
			beans.addBeanDescriptor( descriptor );
			
			addLoadSaveImplementations( beans );					
			
			descriptor = new BeanDescriptor(
				DOMFeature.EVENTS_MODULE );
			descriptor.instanceClass = DocumentEventImpl;
			descriptor.singleton = true;
			descriptor.names = new Vector.<String>();
			addCommonEventAliases( descriptor.names );	
			
			descriptor.names.push( DOMFeature.UI_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.MOUSE_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.TEXT_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.KEYBOARD_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.WHEEL_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.COMPOSITION_EVENTS_MODULE );
			descriptor.names.push( DOMFeature.CUSTOM_EVENTS_MODULE );
			beans.addBeanDescriptor( descriptor );
			
			addCommonEvents( beans );
			
			//DOM UI Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.UI_EVENT_INTERFACE );
			descriptor.instanceClass = UIEventImpl;
			beans.addBeanDescriptor( descriptor );
			
			//DOM Focus Event
			descriptor = new BeanDescriptor(
				DocumentEventImpl.FOCUS_EVENT_INTERFACE );
			descriptor.instanceClass = FocusEventImpl;
			beans.addBeanDescriptor( descriptor );

			addCommonFeatures( beans );
			
			addHTMLElements( beans );		
		}
		
		/**
		* 	@private
		*/
		protected function addHTMLElements( impls:IBeanDocument ):void
		{
			var descriptor:IBeanDescriptor = null;
			
			descriptor = new BeanDescriptor(
				 HTMLHtmlElementImpl.NAME );
			descriptor.instanceClass = HTMLHtmlElementImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				 HTMLHeadElementImpl.NAME );
			descriptor.instanceClass = HTMLHeadElementImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				 HTMLBodyElementImpl.NAME );
			descriptor.instanceClass = HTMLBodyElementImpl;
			impls.addBeanDescriptor( descriptor );
			
			descriptor = new BeanDescriptor(
				 HTMLTitleElementImpl.NAME );
			descriptor.instanceClass = HTMLTitleElementImpl;
			impls.addBeanDescriptor( descriptor );		
		}
	}
}