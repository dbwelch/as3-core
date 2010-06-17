package com.ffsys.ui.text
{
	import flash.text.*;	
	
	/**
	*	Represents a single line textfield that has
	* 	a fixed width.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class FixedSingleLineTextField extends SingleLineTextField
	{
		private var _measuredHeight:Number;
		
		/**
		* 	Creates a <code>FixedSingleLineTextField</code> instance.
		* 
		*	@param text The text for the textfield.
		*	@param properties An object containing properties to
		*	set on this instance.
		*	@param textformat An object containing textformat properties
		*	to apply to the default text format.
		*/
		public function FixedSingleLineTextField(
			text:String = "",
			properties:Object = null,
			textformat:Object = null )
		{
			super( text, properties, textformat );
			this.width = 120;
		}
	
		/**
		* 	@inheritDoc
		*/
		override protected function beforeSetText( text:String ):void
		{
			//make single line so we can automatically measure the height
			convertToSingleLine();
			_measuredHeight = this.height;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function afterSetText( text:String ):void
		{
			//switch off autoSize
			autoSize = TextFieldAutoSize.NONE;
			this.height = _measuredHeight;
		}
	}
}