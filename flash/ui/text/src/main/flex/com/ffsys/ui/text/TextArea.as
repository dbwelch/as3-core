package com.ffsys.ui.text
{
	import flash.text.*;
	
	import com.ffsys.ui.text.core.*;

	/**
	*	A multuline text input component.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class TextArea extends TextInput
	{	
		/**
		* 	Creates a <code>TextArea</code> instance.
		* 
		* 	@param text The text for the textfield.
		* 	@param width The preferred width for this component.
		* 	@param height The preferred height for this component.
		*/
		public function TextArea(
			text:String = "",
			width:Number = 220,
			height:Number = 120 )
		{
			super( text, width, height );
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