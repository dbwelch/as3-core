package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.Element;	
	import org.w3c.dom.html.HTMLDOMImplementation;
	import org.w3c.dom.html.HTMLDocument;
	
	import org.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.bootstrap.DOMBootstrap;
	
	import com.ffsys.w3c.dom.css.DOMImplementationCSSImpl;
	
	/**
	* 	Extends the load and save features support with the "HTML" feature.
	* 
	* 	<ol>
	* 		<li><code>Core</code></li>
	* 		<li><code>ElementTraversal</code></li>
	* 		<li><code>Range</code></li>
	* 		<li><code>Traversal</code></li>
	* 		<li><code>Events</code></li>
	* 		<li><code>MutationEvents</code></li>
	* 		<li><code>MutationNameEvents</code></li>
	* 		<li><code>LS</code></li>
	* 		<li><code>LS-Async</code></li>
	* 		<li><code>Views</code></li>
	* 		<li><code>StyleSheets</code></li>
	* 		<li><code>CSS</code></li>
	* 		<li><code>CSS2</code></li>
	* 	
	* 		<li><code>UIEvents</code></li>
	* 		<li><code>MouseEvents</code></li>
	* 		<li><code>TextEvents</code></li>
	* 		<li><code>KeyboardEvents</code></li>
	* 
	* 		<li><code>HTML</code></li>
	* 	</ol>
	*/
	public class HTMLDOMImplementationImpl extends DOMImplementationCSSImpl
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
				
				_supported.push( DOMFeature.UI_EVENTS_3_FEATURE );
				_supported.push( DOMFeature.MOUSE_EVENTS_3_FEATURE );
				_supported.push( DOMFeature.TEXT_EVENTS_3_FEATURE );
				_supported.push( DOMFeature.KEYBOARD_EVENTS_3_FEATURE );
							
				_supported.push( DOMFeature.VIEWS_2_FEATURE );
				_supported.push( DOMFeature.STYLESHEETS_2_FEATURE );				
				_supported.push( DOMFeature.CSS_2_FEATURE );
				_supported.push( DOMFeature.CSS2_2_FEATURE );
				
				_supported.push( DOMFeature.HTML_2_FEATURE );
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