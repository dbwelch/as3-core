package org.flashx.ui.buttons {
	
	import org.flashx.ui.common.ISelectable;
	import org.flashx.ui.core.IInteractiveComponent;
	
	/**
	*	Describes the contract for button components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.06.2010
	*/
	public interface IButton 
		extends IInteractiveComponent,
		 		ISelectable {
		
		/**
		*	Determines whether this button dispatches
		*	mouse events in a loop either while the mouse
		*	is over this button or while the mouse is pressed
		*	on this button.
		*	
		*	Acceptable values are <code>ButtonLoopMode.OVER</code>
		*	or <code>ButtonLoopMode.DOWN</code>.
		*/
		function get loop():String;
		function set loop( value:String ):void;
		
		/**
		*	Determines whether this button is selectable.
		*	
		*	When a button is selected it behaves as a toggle button.
		*	Changing between a main and selected state depending upon
		*	it's selected value.
		*/
		function get selectable():Boolean;
		function set selectable( selectable:Boolean ):void;	
	}
}