package org.flashx.ui.scrollbars {
	
	import org.flashx.ui.buttons.IButton;
	
	/**
	*	Describes the contract for scroll bar scroll tracks.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public interface IScrollDrag extends IButton {
		
		/**
		*	The scroll bar that owns this scroll drag.
		*/
		function get scrollBar():IScrollBar;
		function set scrollBar( scroller:IScrollBar ):void;
	}
}