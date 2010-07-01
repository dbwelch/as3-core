package com.ffsys.ui.core {
	
	/**
	*	Describes the contract for interactive components.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public interface IInteractiveComponent
		extends IComponent {
		
		/**
		* 	Extends the enabled functionality to switch the hand cursor
		* 	and button mode on when interactive is <code>true</code>.
		*/
		function get interactive():Boolean;
		function set interactive( interactive:Boolean ):void;
	}
}