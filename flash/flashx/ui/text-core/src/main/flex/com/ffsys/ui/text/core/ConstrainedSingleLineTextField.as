package com.ffsys.ui.text.core {
	
	import flash.text.*;
	
	/**
	*	Represents a non-interactive single line of text
	*	that wraps to a multiline textfield if the textfield
	* 	width is more than a maximum limit.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class ConstrainedSingleLineTextField extends SingleLineTextField {
		
		/**
		*	Creates a <code>ConstrainedSingleLineTextField</code> instance.
		*	
		*	@param text The text for the textfield.
		*	@param properties An object containing properties to
		*	set on this instance.
		*	@param textformat An object containing textformat properties
		*	to apply to the default text format.
		*/
		public function ConstrainedSingleLineTextField(
			text:String = "",
			properties:Object = null,
			textformat:Object = null )
		{
			super( text, properties, textformat );
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function beforeSetText( text:String ):void
		{
			//make single line
			convertToSingleLine();
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function afterSetText( text:String ):void
		{
			//if we're too wide convert to multiline
			if( this.width > maximumWidth )
			{
				convertToMultiLine();
				this.width = maximumWidth;
				
				if( this.height > maximumHeight )
				{
					autoSize = TextFieldAutoSize.NONE;
					this.height = maximumHeight;
				}
			}
		}
	}
}