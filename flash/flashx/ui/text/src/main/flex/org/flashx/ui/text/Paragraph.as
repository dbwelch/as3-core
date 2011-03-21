package org.flashx.ui.text
{
	import org.flashx.ui.text.core.MultiLineTextField;

	/**
	*	Represents a paragraph of text.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.06.2010
	*/
	dynamic public class Paragraph extends TextComponent
	{		
		/**
		* 	Creates a <code>Paragraph</code> instance.
		* 
		* 	@param text The text for the textfield.
		* 	@param maximumWidth The maximum width for the textfield.
		* 	@param maximumHeight The maximum height for the textfield.
		*/
		public function Paragraph(
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
			return MultiLineTextField;
		}
	}
}