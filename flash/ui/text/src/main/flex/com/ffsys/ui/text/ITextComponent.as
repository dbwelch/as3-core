package com.ffsys.ui.text
{
	import com.ffsys.ui.core.IComponent;

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
	}
}