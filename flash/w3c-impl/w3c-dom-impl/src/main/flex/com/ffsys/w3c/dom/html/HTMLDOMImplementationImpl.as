package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.html.HTMLDOMImplementation;
	import org.w3c.dom.html.HTMLDocument;
	
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.DOMImplementationImpl;

	
	public class HTMLDOMImplementationImpl extends DOMImplementationImpl
		implements HTMLDOMImplementation
	{
		/**
		* 	@private
		* 	
		* 	Creates an <code>HTMLDOMImplementationImpl</code> instance.
		*/
		public function HTMLDOMImplementationImpl()
		{
			super();
		}
		
		/**
		* 	Configures the supported features for this implementation.
		*/
		override protected function configureSupportedFeatures():void
		{
			this.supported.push( DOMFeature.HTML_FEATURE );
			this.supported.push( DOMFeature.VIEWS_FEATURE );
			
			this.supported.push( DOMFeature.UI_EVENTS_FEATURE );
			this.supported.push( DOMFeature.MOUSE_EVENTS_FEATURE );
			this.supported.push( DOMFeature.TEXT_EVENTS_FEATURE );
			this.supported.push( DOMFeature.KEYBOARD_EVENTS_FEATURE );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createHTMLDocument( title:String ):HTMLDocument
		{
			//TODO
			return null;
		}
	}
}