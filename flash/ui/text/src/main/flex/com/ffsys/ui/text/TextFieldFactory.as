package com.ffsys.ui.text {
	
	import flash.text.*;
	
	/**
	*	Utility class for creating and working with textfields.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class TextFieldFactory extends Object {
		
		/**
		*	Creates a <code>TextFieldFactory<code> instance.	
		*/
		public function TextFieldFactory()
		{
			super();
		}
		
		/**
		*	Creates a single line textfield.
		*	
		*	@param text The text to assign to the textfield.
		*	@param enabled Whether the textfield received mouse events.
		*	
		*	@return The single line textfield.
		*/
		public function single(
			text:String = "",
			enabled:Boolean = false ):SingleLineTextField
		{
			var txt:SingleLineTextField = new SingleLineTextField( text );
			txt.enabled = enabled;
			return txt;
		}
	}
}