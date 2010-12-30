package com.ffsys.ui.text
{
	import com.ffsys.ui.text.core.ConstrainedSingleLineTextField;

	/**
	*	Represents the sub heading for a section.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.12.2010
	*/
	public class SubHeading extends Label
	{
		/**
		* 	Creates a <code>SubHeading</code> instance.
		* 
		* 	@param text The text for the textfield.
		* 	@param maximumWidth The maximum width for the textfield.
		* 	@param maximumHeight The maximum height for the textfield.
		*/
		public function SubHeading(
			text:String = "",
			maximumWidth:Number = NaN,
			maximumHeight:Number = NaN )
		{
			super( text, maximumWidth, maximumHeight );
		}
	}
}