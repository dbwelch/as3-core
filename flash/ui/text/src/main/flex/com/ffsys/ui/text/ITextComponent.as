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
	}
}