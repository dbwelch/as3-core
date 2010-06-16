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
		*	@param properties An object containing properties to
		*	set on the textfield.
		*	@param textformat An object containing textformat properties
		*	to set on the default text format.
		*	@param enabled Whether the textfield receives mouse events.
		*	
		*	@return The single line textfield.
		*/
		public function single(
			text:String = "",
			properties:Object = null,
			textformat:Object = null,
			enabled:Boolean = false ):SingleLineTextField
		{
			var txt:SingleLineTextField = new SingleLineTextField(
				text, properties, textformat );
			txt.enabled = enabled;
			return txt;
		}
		
		/**
		*	Creates a constrained single line textfield.
		*	
		*	@param text The text to assign to the textfield.
		*	@param properties An object containing properties to
		*	set on the textfield.
		*	@param textformat An object containing textformat properties
		*	to set on the default text format.
		*	@param enabled Whether the textfield receives mouse events.
		*	
		*	@return The single line textfield.
		*/
		public function constrained(
			text:String = "",
			properties:Object = null,
			textformat:Object = null,
			enabled:Boolean = false ):ConstrainedSingleLineTextField
		{
			var txt:ConstrainedSingleLineTextField = new ConstrainedSingleLineTextField(
				text, properties, textformat );
			txt.enabled = enabled;
			return txt;
		}
	}
}