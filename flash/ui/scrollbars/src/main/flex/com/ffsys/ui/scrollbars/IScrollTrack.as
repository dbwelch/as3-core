package com.ffsys.ui.scrollbars {
	
	import com.ffsys.ui.buttons.IButton;
	
	/**
	*	Describes the contract for scroll bar scroll tracks.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public interface IScrollTrack extends IButton {
		
		/**
		* 	The mode that this scroll track is operating in.
		*/
		function get mode():String;
		function set mode( mode:String ):void;
		
		/**
		*	The scroll bar that owns this scroll track.
		*/
		function get scrollBar():IScrollBar;
		function set scrollBar( scroller:IScrollBar ):void;
	}
}