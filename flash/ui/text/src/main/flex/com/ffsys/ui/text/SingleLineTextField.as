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
		*/
		public function SingleLineTextField( text:String = "" )
		{
			super();
			this.wordWrap = false;
			this.enabled = false;
			this.selectable = false;
			this.autoSize = TextFieldAutoSize.LEFT;
			this.text = text;
		}
	}
}