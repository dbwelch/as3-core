package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.Element;	
	import org.w3c.dom.html.HTMLDOMImplementation;
	import org.w3c.dom.html.HTMLDocument;
	
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.bootstrap.DOMBootstrap;
	
	import com.ffsys.w3c.dom.ls.DOMImplementationLSImpl;	
	
	/**
	* 	Represents a HTML DOM implementation.
	*/
	public class HTMLDOMImplementationImpl extends DOMImplementationLSImpl
		implements HTMLDOMImplementation
	{
		/**
		* 	The bean name for the implementation of the "HTML" feature.
		*/
		public static const NAME:String = DOMFeature.HTML_MODULE;
		
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
		* 	@private
		*/
		override protected function get supported():Vector.<DOMFeature>
		{
			if( _supported == null )
			{
				_supported = super.supported;
				
				//xml+html should be supported by an XHTML implementation
				//_supported.push( DOMFeature.XML_FEATURE );
				
				_supported.push( DOMFeature.HTML_FEATURE );
				_supported.push( DOMFeature.VIEWS_FEATURE );
				_supported.push( DOMFeature.UI_EVENTS_FEATURE );
				_supported.push( DOMFeature.MOUSE_EVENTS_FEATURE );
				_supported.push( DOMFeature.TEXT_EVENTS_FEATURE );
				_supported.push( DOMFeature.KEYBOARD_EVENTS_FEATURE );				
			}
			return _supported;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function createHTMLDocument( title:String ):HTMLDocument
		{
			//null titles become the empty string
			if( title == null )
			{
				title = "";
			}
			
			var document:HTMLDocumentImpl = HTMLDocumentImpl(
				this.document.getBean( HTMLDocumentImpl.NAME ) );
			
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
			
			/*	
			trace("[CREATE HTML ELEMENT] HTMLDOMImplementationImpl::createHTMLDocument()",
				html, head, body );
			*/
			
			setImplementation( document, null );
			
			//assign a reference to the head and body
			document.head = head;
			document.body = body;

			document.title = title;			
			
			return document;
		}
	}
}