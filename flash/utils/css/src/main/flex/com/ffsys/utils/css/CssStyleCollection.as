package com.ffsys.utils.css {
	
	import flash.text.StyleSheet;
	
	/**
	*	Represents a collection of CSS styles.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.10.2010
	*/
	public class CssStyleCollection extends StyleSheet {
		
		/**
		*	Creates a <code>CssStyleCollection</code> instance.
		*/
		public function CssStyleCollection()
		{
			super();
		}
		
		
		override public function parseCSS( text:String ):void
		{
			super.parseCSS( text );
			
			trace("CssStyleCollection::parseCss(), ", styleNames );
		}
	}
	
}
