package com.ffsys.ui.text
{
	import com.ffsys.ui.text.core.MultiLineTextField;

	/**
	*	Represents a paragraph of text.
	* 
	* 	This component will render at slightly smaller
	* 	text size than a normal paragraph.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.12.2010
	*/
	public class SubParagraph extends Paragraph
	{		
		/**
		* 	Creates a <code>SubParagraph</code> instance.
		* 
		* 	@param text The text for the textfield.
		* 	@param maximumWidth The maximum width for the textfield.
		* 	@param maximumHeight The maximum height for the textfield.
		*/
		public function SubParagraph(
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