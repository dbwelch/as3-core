package com.ffsys.ui.buttons {
	
	/**
	*	Encapsulates constants that represent the loop
	*	modes for buttons.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.06.2010
	*/
	public class ButtonLoopMode extends Object {
		
		/**
		*	Represents a loop mode for a button which
		*	forces the button to dispatch mouse over
		*	events continuously while the mouse is over
		*	the button.
		*/
		public static const OVER:String = "mouseOver";
		
		/**
		*	Represents a loop mode for a button which
		*	forces the button to dispatch mouse down
		*	events continuously while the mouse is pressed
		*	on the button.
		*/
		public static const DOWN:String = "mouseDown";
	}
}