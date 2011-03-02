package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSStyleSheet;	
	
	import com.ffsys.w3c.dom.CoreDocumentImpl;		
	import com.ffsys.w3c.dom.ElementImpl;	
	
	/**
	* 	The top-level document element for a CSS DOM
	* 	representation.
	*/
	public class CSSDocumentElementImpl extends ElementImpl
	{
		
		/**
		* 	The bean name for the CSS document element implementation
		*/
		public static const NAME:String = "css";	
		
		/**
		* 	Creates a <code>CSSDocumentElementImpl</code> instance.
		* 
		* 	@param sheet The style sheet document.
		* 	@param name The element name.
		*/
		public function CSSDocumentElementImpl(
			sheet:CSSStyleSheet = null,
			name:String = NAME )
		{
			super( CoreDocumentImpl( sheet ), name );
		}
	}
}