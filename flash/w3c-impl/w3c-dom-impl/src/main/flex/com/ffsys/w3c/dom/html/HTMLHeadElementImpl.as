package com.ffsys.w3c.dom.html
{
	import org.w3c.dom.html.HTMLHeadElement;	
	
	/**
	* 	Represents the head of an HTML document.
	*/
	public class HTMLHeadElementImpl extends HTMLElementImpl
		implements HTMLHeadElement
	{
		/**
		* 	The name for this element.
		*/
		public static const NAME:String = "head";
		
		/**
		* 	The <code>profile</code> attribute name.
		*/
		public static const PROFILE_ATTR_NAME:String = "profile";
		
		/**
		* 	Creates an <code>HTMLHeadElementImpl</code> instance.
		* 
		* 	@param owner The owner document.
		* 	@param name The element name.
		*/
		public function HTMLHeadElementImpl(
			owner:HTMLDocumentImpl = null,
			name:String = NAME )
		{
			super( owner, name );
		}
		
		/**
		* 	@inheritDoc
		*/
	    public function get profile():String
	    {
	        return getAttribute( PROFILE_ATTR_NAME );
	    }
		
		/**
		* 	@inheritDoc
		*/
	    public function set profile( profile:String ):void
	    {
	        setAttribute( PROFILE_ATTR_NAME, profile );
	    }
	}
}