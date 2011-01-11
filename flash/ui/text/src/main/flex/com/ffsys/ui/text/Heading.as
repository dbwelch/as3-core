package com.ffsys.ui.text
{
	import com.ffsys.ui.text.core.ConstrainedSingleLineTextField;

	/**
	*	Represents the heading for a section.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	dynamic public class Heading extends Label
	{
		/**
		* 	Creates a <code>Heading</code> instance.
		* 
		* 	@param text The text for the textfield.
		* 	@param maximumWidth The maximum width for the textfield.
		* 	@param maximumHeight The maximum height for the textfield.
		*/
		public function Heading(
			text:String = "",
			maximumWidth:Number = NaN,
			maximumHeight:Number = NaN )
		{
			super( text, maximumWidth, maximumHeight );
		}
	}
}