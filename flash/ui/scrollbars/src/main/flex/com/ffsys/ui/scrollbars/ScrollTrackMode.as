package com.ffsys.ui.scrollbars
{
	/**
	*	Encapsulates constants that represent the modes that a scroll
	* 	track can operate in.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.07.2010
	*/
	public class ScrollTrackMode extends Object
	{
		/**
		* 	Represents the default scroll track mode.
		* 
		* 	In this mode the scroll track is not interactive
		* 	and no scrolling is performed when the user interacts
		* 	with the scroll track.
		*/
		public static const NONE:String = "noneScrollTrackMode";
		
		/**
		* 	Represents the jump scroll track mode.
		* 
		* 	When this mode is active the scroll position will
		* 	be set immediately to the position the mouse was clicked
		* 	on the scroll track.
		*/
		public static const JUMP_SCROLL:String = "jumpScrollTrackMode";
		
		
		/**
		* 	Represents the loop scroll track mode.
		* 
		* 	This scroll track mode sets the scroll position
		* 	continuously in a loop while the mouse is pressed
		* 	on the scroll track.
		*/
		public static const LOOP_SCROLL:String = "loopScrollTrackMode";
	}
}