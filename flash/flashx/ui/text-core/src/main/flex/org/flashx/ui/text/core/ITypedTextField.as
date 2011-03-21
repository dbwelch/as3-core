package org.flashx.ui.text.core
{
	import org.flashx.core.IBitmapGrab;
	import org.flashx.core.IEnabled;
	
	import org.flashx.ui.common.flash.ITextField;
	
	/**
	*	Describes the contract for textfield sub classes.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public interface ITypedTextField
		extends ITextField,
				IBitmapGrab,
				IEnabled
	{
		/**
		* 	Whether this textfield is being treated as html.
		*/
		function get html():Boolean;
		function set html( html:Boolean ):void;
		
		/**
		* 	The maximum number of pixels wide this textfield
		* 	can be before it is converted to a multiline textfield.
		*/
		function get maximumWidth():Number;
		function set maximumWidth( maximumWidth:Number ):void;
		
		/**
		* 	The maximum number of pixels high this textfield
		* 	can be before it stops automatically resizing vertically.
		* 
		* 	This only applies after the maximum width has been reached
		* 	and the textfield has been converted to multiline.
		*/
		function get maximumHeight():Number;
		function set maximumHeight( maximumHeight:Number ):void;
		
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
			
		/**
		*	The measured width of the textfield.	
		*/
		function get measuredWidth():Number;
		
		/**
		*	The measured height of the textfield.	
		*/
		function get measuredHeight():Number;			
	}
}