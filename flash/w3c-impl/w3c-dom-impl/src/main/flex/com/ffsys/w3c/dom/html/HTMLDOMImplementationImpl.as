package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.Element;	
	import org.w3c.dom.html.HTMLDOMImplementation;
	import org.w3c.dom.html.HTMLDocument;
	
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.DOMImplementationImpl;
	import com.ffsys.w3c.dom.bootstrap.DOMBootstrap;
	
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
			var document:HTMLDocumentImpl = HTMLDocumentImpl(
				this.document.getBean( DOMBootstrap.HTML_DOCUMENT ) );
			
			//TODO: change to head
			//var e:Element = document.createElement( "html" );
			//document.setDocumentElement( e );
			
			//TOOD: handle inspecting the doctype and 
			//retrieving more specialized implementations where appropriate
			
			//create the html element
			var html:HTMLHtmlElementImpl =
				HTMLHtmlElementImpl(
					document.createElement( HTMLHtmlElementImpl.NAME ) );
			document.appendChild( html );
			
			var head:HTMLHeadElementImpl =
				HTMLHeadElementImpl(
					document.createElement( HTMLHeadElementImpl.NAME ) );
			html.appendChild( head );
			
			//TODO: set the title and assign references
			
			var body:HTMLBodyElementImpl =
				HTMLBodyElementImpl(
					document.createElement( HTMLBodyElementImpl.NAME ) );
			html.appendChild( body );
					
			trace("[CREATE HTML ELEMENT] HTMLDOMImplementationImpl::createHTMLDocument()",
				html, head, body );
			
			setImplementation( document, null );
			
			return document;
		}
	}
}