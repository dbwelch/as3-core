package com.ffsys.css
{
	public interface StyleSheetAware
	{
		/**
		* 	A style sheet.
		*/
		function get stylesheet():CssStyleSheet;
		function set stylesheet( value:CssStyleSheet ):void;	
	}
}