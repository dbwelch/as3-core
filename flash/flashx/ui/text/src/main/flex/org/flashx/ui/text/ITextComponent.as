package org.flashx.ui.text
{
	import flash.text.*;
	
	import org.flashx.ui.core.IComponent;

	public interface ITextComponent
		extends IComponent
	{
		/**
		* 	Whether this text component is being treated as html.
		*/
		function get html():Boolean;
		function set html( html:Boolean ):void;
		
		/**
		* 	Determines whether this component uses the flash
		* 	text engine to render text.
		* 
		* 	The default value is <code>true</code>.
		*/
		function get fte():Boolean;
		function set fte( value:Boolean ):void;
		
		/**
		* 	The textfield used to render the text
		* 	when flash text engine is disabled for this
		* 	text component.
		*/
		function get textfield():TextField;
		
		/**
		* 	A plain text string with no embedded markup
		* 	to assign to the component <code>text</code>
		* 	when it is finalized.
		*/
		function get contentText():String;
		function set contentText( value:String ):void;
		
		/**
		* 	The text to display in this component.
		*/
		function get text():String;
		function set text( text:String ):void;
	}
}