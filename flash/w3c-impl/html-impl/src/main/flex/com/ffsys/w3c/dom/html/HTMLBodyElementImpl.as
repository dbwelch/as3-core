package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.html.HTMLBodyElement;

	public class HTMLBodyElementImpl extends HTMLElementImpl
		implements HTMLBodyElement
	{
		/**
		* 	The name for this element.
		*/
		public static const NAME:String = "body";
		
		/**
		* 	The <code>alink</code> attribute name.
		*/
		public static const ALINK_ATTR_NAME:String = "alink";
		
		/**
		* 	The <code>link</code> attribute name.
		*/
		public static const LINK_ATTR_NAME:String = "link";
		
		/**
		* 	The <code>vlink</code> attribute name.
		*/
		public static const VLINK_ATTR_NAME:String = "vlink";
		
		/**
		* 	The <code>text</code> attribute name.
		*/
		public static const TEXT_ATTR_NAME:String = "text";
		
		/**
		* 	The <code>background</code> attribute name.
		*/
		public static const BACKGROUND_ATTR_NAME:String = "background";
		
		/**
		* 	The <code>bgcolor</code> attribute name.
		*/
		public static const BG_COLOR_ATTR_NAME:String = "bgcolor";
		
		/**
		* 	Creates an <code>HTMLBodyElementImpl</code> instance.
		* 
		* 	@param owner The owner document.
		* 	@param name The element name.
		*/
		public function HTMLBodyElementImpl(
			owner:HTMLDocumentImpl = null,
			name:String = NAME )
		{
			super( owner, name );
		}
		
		
		/**
		* 	Color of active links (after mouse-button down, but before mouse-button up).
		* 
		* 	This attribute is deprecated in HTML 4.01.
		*/
		public function get aLink():String
		{
	        return getAttribute( ALINK_ATTR_NAME );			
		}
		
		public function set aLink( link:String ):void
		{
	        setAttribute( ALINK_ATTR_NAME, link );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get link():String
		{
	        return getAttribute( LINK_ATTR_NAME );
		}
		
		public function set link( link:String ):void
		{
	        setAttribute( LINK_ATTR_NAME, link );				
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get vLink():String
		{
	        return getAttribute( VLINK_ATTR_NAME );				
		}
		
		public function set vLink( link:String ):void
		{
	        setAttribute( VLINK_ATTR_NAME, link );				
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get text():String
		{
	        return getAttribute( TEXT_ATTR_NAME );
		}
		
		public function set text( text:String ):void
		{
	        setAttribute( TEXT_ATTR_NAME, text );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get background():String
		{
	        return getAttribute( BACKGROUND_ATTR_NAME );
		}
		
		public function set background( background:String ):void
		{
	        setAttribute( BACKGROUND_ATTR_NAME, background );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get bgColor():String
		{
	        return getAttribute( BG_COLOR_ATTR_NAME );
		}
		
		public function set bgColor( bgColor:String ):void
		{
	        setAttribute( BG_COLOR_ATTR_NAME, bgColor );
		}		
	}
}