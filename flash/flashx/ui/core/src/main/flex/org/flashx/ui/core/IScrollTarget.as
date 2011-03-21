package org.flashx.ui.core {
	
	import flash.display.DisplayObject;
	
	import org.flashx.ui.core.IMaskComponent;
	import org.flashx.ui.core.IInteractiveComponent;
	
	/**
	*	Describes the contract for scroll targets that
	*	add masking ability to the underlying display object
	*	being scrolled.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2010
	*/
	public interface IScrollTarget extends IInteractiveComponent {
		
		/**
		*	The component used to mask the scroll target.
		*/
		function get masker():IMaskComponent;
		
		/**
		*	The underlying display object being scrolled.
		*/
		function get target():DisplayObject;
		function set target( target:DisplayObject ):void;
	}
}