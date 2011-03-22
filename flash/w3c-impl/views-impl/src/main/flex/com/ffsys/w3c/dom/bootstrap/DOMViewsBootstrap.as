package com.ffsys.w3c.dom.bootstrap
{
	import org.flashx.ioc.BeanDescriptor;
	import org.flashx.ioc.IBeanDocument;
	import org.flashx.ioc.IBeanDescriptor;
	
	import org.w3c.dom.DOMImplementation;
	
	import org.w3c.dom.DOMFeature;
	
	import com.ffsys.w3c.dom.events.DocumentEventImpl;
	import com.ffsys.w3c.dom.events.FocusEventImpl;
	import com.ffsys.w3c.dom.events.UIEventImpl;
	
	import com.ffsys.w3c.dom.bootstrap.DOMLSAsyncBootstrap;
	
	
	/**
	* 	A boostrap document for the DOM Views implementation.
	*/
	public class DOMViewsBootstrap extends DOMLSAsyncBootstrap
	{
		/**
		* 	The name for the <code>DOM</code> Views implementation bean document.
		*/
		public static const NAME:String = DOMFeature.VIEWS_MODULE;
		
		/**
		* 	Creates a <code>DOMViewsBootstrap</code> instance.
		* 
		* 	@param identifier An identifier for this document.
		*/
		public function DOMViewsBootstrap( identifier:String = null )
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
			
			/*
			var impl:DOMImplementation =
				new HTMLDOMImplementationImpl();
			createImplementationFactory(
				factories,
				HTMLDOMImplementationImpl.NAME,
				HTMLDOMImplementationImpl,
				impl );
				
			*/
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function doWithBeans(
			beans:IBeanDocument ):void
		{
			super.doWithBeans( beans );			
			
			var descriptor:IBeanDescriptor = null;
			
			/*
			descriptor = new BeanDescriptor(
				HTMLDocumentImpl.NAME );
			descriptor.instanceClass = HTMLDocumentImpl;
			beans.addBeanDescriptor( descriptor );
			*/
			
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
		}
		
		/**
		* 	@private
		*/
		override protected function getSupportedFeatures():Vector.<DOMFeature>
		{
			var output:Vector.<DOMFeature> = super.getSupportedFeatures();
			output.push( DOMFeature.VIEWS_2_FEATURE );
			return output;
		}
		
		/**
		* 	@private
		*/
		override protected function addCommonEventAliases( names:Vector.<String> ):void
		{
			super.addCommonEventAliases( names );
			names.push( DOMFeature.UI_EVENTS_MODULE );
			names.push( DOMFeature.MOUSE_EVENTS_MODULE );
			names.push( DOMFeature.TEXT_EVENTS_MODULE );
			names.push( DOMFeature.KEYBOARD_EVENTS_MODULE );
			names.push( DOMFeature.WHEEL_EVENTS_MODULE );
			names.push( DOMFeature.COMPOSITION_EVENTS_MODULE );
		}
	}
}