package com.ffsys.ui.buttons {
	
	/**
	*	Represents a standard button.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.06.2010
	*/
	public class Button extends TextButton {
		
		/**
		*	Creates a <code>Button</code> instance.
		*	
		*	@param text The text for the button label.
		*/
		public function Button(
			text:String = "" )
		{
			super( text );
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function createChildren():void
		{
			//
		}
	}
}