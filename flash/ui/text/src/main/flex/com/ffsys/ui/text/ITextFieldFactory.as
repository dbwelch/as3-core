package com.ffsys.ui.text
{
	
	/**
	*	Describes the contract for textfield factory implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public interface ITextFieldFactory
	{
		
		/**
		*	The default properties to apply to the textfield.	
		*/
		function get defaultTextFieldProperties():Object;
		function set defaultTextFieldProperties( properties:Object ):void;
		
		/**
		*	The default properties to apply to the textformat.	
		*/
		function get defaultTextFormatProperties():Object;
		function set defaultTextFormatProperties( properties:Object ):void;		
		
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
		function single(
			text:String = "",
			properties:Object = null,
			textformat:Object = null,
			enabled:Boolean = false ):SingleLineTextField;
			
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
		function constrained(
			text:String = "",
			properties:Object = null,
			textformat:Object = null,
			enabled:Boolean = false ):ConstrainedSingleLineTextField;
		
		/**
		*	Creates a multi line textfield.
		*	
		*	@param text The text to assign to the textfield.
		*	@param properties An object containing properties to
		*	set on the textfield.
		*	@param textformat An object containing textformat properties
		*	to set on the default text format.
		*	@param enabled Whether the textfield receives mouse events.
		*	
		*	@return The multi line textfield.
		*/
		function multi(
			text:String = "",
			properties:Object = null,
			textformat:Object = null,
			enabled:Boolean = false ):MultiLineTextField;		
	}
}