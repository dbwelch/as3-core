package com.ffsys.ui.text
{
	import com.ffsys.ui.text.core.ConstrainedSingleLineTextField;

	/**
	*	Represents a textual label.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class Label extends TextComponent
	{		
		/**
		* 	Creates a <code>Label</code> instance.
		* 
		* 	@param text The text for the textfield.
		* 	@param maximumWidth The maximum width for the textfield.
		* 	@param maximumHeight The maximum height for the textfield.
		*/
		public function Label(
			text:String = "",
			maximumWidth:Number = NaN,
			maximumHeight:Number = NaN )
		{
			super( text, maximumWidth, maximumHeight );
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function getTextFieldClass():Class
		{
			return ConstrainedSingleLineTextField;
		}
	}
}