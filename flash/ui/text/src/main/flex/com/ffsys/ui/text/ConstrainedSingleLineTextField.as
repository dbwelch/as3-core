package com.ffsys.ui.text {
	
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
		
		private var _maximumWidth:Number;
		private var _maximumHeight:Number;
		
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
		* 	The maximum number of pixels wide this textfield
		* 	can be before it is converted to a multiline textfield.
		*/
		public function get maximumWidth():Number
		{
			return _maximumWidth;
		}
		
		public function set maximumWidth( maximumWidth:Number ):void
		{
			_maximumWidth = maximumWidth;
		}
		
		/**
		* 	The maximum number of pixels high this textfield
		* 	can be before it stops automatically resizing vertically.
		* 
		* 	This only applies after the maximum width has been reached
		* 	and the textfield has been converted to multiline.
		*/
		public function get maximumHeight():Number
		{
			return _maximumHeight;
		}
		
		public function set maximumHeight( maximumHeight:Number ):void
		{
			_maximumHeight = maximumHeight;
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