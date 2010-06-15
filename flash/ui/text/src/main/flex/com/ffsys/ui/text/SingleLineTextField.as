package com.ffsys.ui.text {
	
	import flash.text.*;
	
	/**
	*	Represents a single line of text
	*	that does not have mouse interaction and
	*	expands to fit the width of it's text.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class SingleLineTextField extends AbstractTextField {
		
		/**
		*	Creates a <code>SingleLineTextField</code> instance.
		*	
		*	@param text The text for the textfield.
		*	@param properties An object containing properties to
		*	set on this instance.
		*	@param textformat An object containing textformat properties
		*	to apply to the default text format.
		*/
		public function SingleLineTextField(
			text:String = "",
			properties:Object = null,
			textformat:Object = null )
		{
			this.wordWrap = false;
			this.enabled = false;
			this.selectable = false;
			this.autoSize = TextFieldAutoSize.LEFT;
			super( text, properties, textformat );
		}
	}
}