package com.ffsys.w3c.dom.html
{
	import com.ffsys.w3c.dom.DocumentImpl;
	
	import org.w3c.dom.Element;
	import org.w3c.dom.NodeList;
	import org.w3c.dom.html.HTMLDocument;
	import org.w3c.dom.html.HTMLBodyElement;
	import org.w3c.dom.html.HTMLHeadElement;
	import org.w3c.dom.html.HTMLCollection;
	
	dynamic public class HTMLDocumentImpl extends DocumentImpl
		implements HTMLDocument
	{
		private var _title:String;
		private var _referrer:String;
		private var _domain:String;
		private var _url:String;
		private var _cookie:String;

		private var _head:HTMLHeadElement;
		private var _body:HTMLBodyElement;
		
		private var _images:HTMLCollection;
		private var _applets:HTMLCollection;
		private var _links:HTMLCollection;
		private var _forms:HTMLCollection;
		private var _anchors:HTMLCollection;
		
		/**
		* 	@private
		* 
		* 	Creates an <code>HTMLDocumentImpl</code> instance.
		*/
		public function HTMLDocumentImpl()
		{
			super();
		}
		
		/**
		* 	The document head.
		*/
		public function get head():HTMLHeadElement
		{
			return _head;
		}
		
		public function set head( head:HTMLHeadElement ):void
		{
			_head = head;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get body():HTMLBodyElement
		{
			return _body;
		}
		
		public function set body( body:HTMLBodyElement ):void
		{
			_body = body;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get title():String
		{
			return _title;
		}
		
		public function set title( title:String ):void
		{
			if( title == null )
			{
				//TODO : remove the title element from the document head
			}else
			{
				//TODO: check that a head exists
				//TODO: check if a title element exists and just update the text
			
				var el:HTMLTitleElementImpl = 
					HTMLTitleElementImpl(
						createElement( HTMLTitleElementImpl.NAME ) );
					
				this.head.appendChild( el );
			
				el.text = title;
			}
			
			_title = title;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get referrer():String
		{
			return _referrer;
		}
		
		/**
		* 	The domain of this document.
		*/
		public function get domain():String
		{
			return _domain;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get url():String
		{
			return _url;
		}
		
		//This property is a String and can raise an object that implements DOMException interface on setting.
		/**
		* 	@inheritDoc
		*/
		public function get cookie():String
		{
			return _cookie;
		}
		
		public function set cookie( cookie:String ):void
		{
			_cookie = cookie;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get images():HTMLCollection
		{
			return _images;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get applets():HTMLCollection
		{
			return _applets;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get links():HTMLCollection
		{
			return _links;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get forms():HTMLCollection
		{
			return _forms;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get anchors():HTMLCollection
		{
			return _anchors;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function open():void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function close():void
		{
			//TODO			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function write( text:String ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function writeln( text:String ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getElementsByName( elementName:String ):NodeList
		{
			//TODO
			return null;
		}		
		
		/**
		* 	@private
		*/
		internal function setDocumentElement( element:Element ):void
		{
			_documentElement = element;
		}
	}
}