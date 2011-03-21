package org.flashx.ui.scrollbars {
	
	import flash.display.DisplayObject;
	
	import org.flashx.ui.core.IComponent;
	import org.flashx.ui.scrollbars.IScrollBar;
	import org.flashx.ui.core.IScrollTarget;
	
	/**
	*	Describes the contract for a component
	*	that encapsulates a vertical and horizontal
	*	scroll bar pair.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.07.2010
	*/
	public interface IScroller extends IComponent {
		
		/**
		*	Proxies the scroll target to the scroll target
		*	implementation encapsulated by this scroller.
		*/
		function get target():DisplayObject;
		function set target( target:DisplayObject ):void;
		
		/**
		*	Gets the scroll target implementation that wraps
		*	the target display object.
		*/
		function get scrollTarget():IScrollTarget;
		
		/**
		*	The vertical scroll bar encapsulated by this scroller.
		*/
		function get verticalScrollBar():IScrollBar;
		
		/**
		*	The horizontal scroll bar encapsulated by this scroller.
		*/
		function get horizontalScrollBar():IScrollBar;
		
		/**
		*	Determines whether vertical scrolling is enabled.
		*	
		*	When this value is false no vertical scroll bar is shown.
		*/
		function get verticalScrollEnabled():Boolean;
		function set verticalScrollEnabled( enabled:Boolean ):void;
		
		/**
		*	Determines whether horizontal scrolling is enabled.
		*	
		*	When this value is false no horizontal scroll bar is shown.
		*/
		function get horizontalScrollEnabled():Boolean;
		function set horizontalScrollEnabled( enabled:Boolean ):void;
		
		/**
		*	Determines whether the vertical scroll bar should
		*	still be visible when there is no vertical scroll.
		*/
		function get alwaysShowVerticalScrollBar():Boolean;
		function set alwaysShowVerticalScrollBar( value:Boolean ):void;
		
		/**
		*	Determines whether the horizontal scroll bar should
		*	still be visible when there is no horizontal scroll.
		*/
		function get alwaysShowHorizontalScrollBar():Boolean;
		function set alwaysShowHorizontalScrollBar( value:Boolean ):void;
	}
}