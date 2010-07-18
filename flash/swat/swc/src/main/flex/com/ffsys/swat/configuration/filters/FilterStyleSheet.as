package com.ffsys.swat.configuration.filters {
	
	import flash.text.StyleSheet;
	
	/**
	*	Represents a style sheet that defines
	*	filter configurations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.07.2010
	*/
	public class FilterStyleSheet extends StyleSheet {
		
		/**
		*	Creates a <code>FilterStyleSheet</code> instance.
		*/
		public function FilterStyleSheet()
		{
			super();
		}
		
		/**
		*	Custom parsing routine.
		*	
		*	@param text The css text to parse.	
		*/
		override public function parseCSS( text:String ):void
		{
			super.parseCSS( text );
			
			trace("FilterStyleSheet::parseCSS(), ", styleNames );
		}
	}
	
}
