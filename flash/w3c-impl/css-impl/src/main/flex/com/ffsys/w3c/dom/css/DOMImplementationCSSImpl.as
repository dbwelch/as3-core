package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.DOMImplementationCSS;
	
	import com.ffsys.w3c.dom.ls.DOMImplementationLSImpl;
	
	import org.w3c.dom.DOMFeature;
	
	/**
	* 	Represents a CSS DOM implementation.
	*/
	public class DOMImplementationCSSImpl extends DOMImplementationLSImpl
		implements DOMImplementationCSS
	{
		/**
		* 	The bean name for the implementation of the "StyleSheets" feature.
		*/
		public static const NAME:String = DOMFeature.STYLESHEETS_MODULE;
		
		/**
		* 	The bean name for the implementation of the "CSS" feature.
		*/
		public static const CSS_NAME:String = DOMFeature.CSS_MODULE;	
		
		/**
		* 	The bean name for the implementation of the "CSS2" feature.
		*/
		public static const CSS2_NAME:String = DOMFeature.CSS2_MODULE;
		
		/**
		* 	Creates a <code>DOMImplementationCSSImpl</code> instance.
		*/
		public function DOMImplementationCSSImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function createCSSStyleSheet(
			title:String, media:String ):CSSStyleSheet
		{
			var styles:CSSStyleSheetImpl =
				CSSStyleSheetImpl( getDomBean( CSSStyleSheetImpl.NAME ) );
				
			//append the document element property to
			//instantiate the default top-level element
			styles.appendChild( styles.documentElement );
			
			return styles;
		}
	}
}