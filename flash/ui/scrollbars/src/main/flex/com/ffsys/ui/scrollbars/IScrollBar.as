package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.buttons.IButton;
	import com.ffsys.ui.core.IComponent;
	
	/**
	*	Describes the contract for scroll bar implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public interface IScrollBar extends IComponent {
		
		/**
		*	The size of the visible display area for the
		*	scroll target.
		*/
		function get size():Number;	
		function set size( size:Number ):void;	
		
		/**
		*	The amount to scroll the target when the scroll
		*	buttons are used.
		*/
		function get scrollAmount():Number;
		function set scrollAmount( amount:Number ):void;
		
		/**
		*	The button that scrolls the target in a negative direction.
		*	
		*	For a horizontal scroll bar this is the right scroll button and
		*	for a vertical scroll bar this is the down scroll button.
		*/
		function get negativeScrollButton():IButton;
		function set negativeScrollButton( button:IButton ):void;
		
		/**
		*	The button that scrolls the target in a positive direction.
		*	
		*	For a horizontal scroll bar this is the left scroll button and
		*	for a vertical scroll bar this is the up scroll button.
		*/		
		function get positiveScrollButton():IButton;
		function set positiveScrollButton( button:IButton ):void;
		
		/**
		*	A scroll track for the scroll bar.	
		*/
		function get scrollTrack():IScrollTrack;
		function set scrollTrack( value:IScrollTrack ):void;
		
		/**
		*	The target being scrolled.	
		*/
		function get target():DisplayObject;
		function set target( target:DisplayObject ):void;
		
		/**
		*	Inspects the scroll target and updates the distance
		*	and minimum scroll positions.
		*	
		*	Note that the maximmum scroll position is determined when
		*	the scroll target is assigned and equates to the measured
		*	position at the time the scroll target is assigned.
		*	
		*	Invoke this method after the size of the target has
		*	changed so that the scroll bar scrolls correctly.
		*/
		function updateScrollProperties():void;
		
		/**
		*	The direction this scroll bar is operating in.	
		*/
		function get direction():String;
		
		/**
		*	Gets the measured position of the target.
		*/
		function get measuredPosition():Number;
		
		/**
		*	Gets the measured size of the target.
		*/
		function get measuredSize():Number;
		
		/**
		*	Gets the distance that the target will be scrolled.	
		*/
		function get scrollDistance():Number;
	
		/**
		*	Determines whether the target needs scrolling.	
		*/
		function isScrollable():Boolean;
		
		/**
		*	Gets the minimum scroll position.
		*	
		*	This is calculated when the scroll properties
		*	are updated.
		*/
		function get minimumScrollPosition():Number;
	
		/**
		*	Gets the maximum scroll position.
		*	
		*	This is calculated when the scroll target
		*	is assigned and corresponds to the measured
		*	position of the scroll target when it is assigned
		*	to this component.
		*/
		function get maximumScrollPosition():Number;
		
		/**
		*	The current scroll position of the target.
		*/
		function get scrollPosition():Number;
		function set scrollPosition( position:Number ):void;
	}
}