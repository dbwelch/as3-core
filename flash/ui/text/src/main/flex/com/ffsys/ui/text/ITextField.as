package com.ffsys.ui.text
{
	
	import com.ffsys.core.IBitmapGrab;
	import com.ffsys.core.IEnabled;
	
	/**
	*	Describes the contract for textfield sub classes.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface ITextField
		extends IBitmapGrab,
				IEnabled
	{
		/**
		* 	Whether this textfield is being treated as html.
		*/
		function get html():Boolean;
		function set html( html:Boolean ):void;
		
		/**
		* 	Sets the text of this textfield.
		* 
		* 	@param text The text to set.
		*/
		function setText( text:String ):void;
		
		/**
		* 	Gets the text associated with this textfield.
		*/
		function getText():String;
	
		/**
		* 	Applies source properties to this text field.
		*	
		*	@param txt The target text field.
		*	@param properties The properties to set on this textfield.
		*/
		function applyTextFieldProperties(
			properties:Object ):void;
	
		/**
		* 	Applies text format properties to a text field.
		*	
		*	This operates on the <code>defaultTextFormat</code>
		*	associated with the text field.
		*	
		*	@param properties The properties to set on the default
		*	text format of this textfield.
		*/
		function applyTextFormatProperties(
			properties:Object ):void;
	}
}