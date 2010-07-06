package com.ffsys.ui.containers {
	
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.scrollbars.IScrollBar;
	
	/**
	*	Encapsulates the scroll bar settings for a container.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  06.07.2010
	*/
	public class Scroller extends UIComponent
		implements IScroller {
		
		private var _alwaysShowVerticalScrollBar:Boolean;
		private var _alwaysShowHorizontalScrollBar:Boolean;
		
		private var _verticalScrollBarEnabled:Boolean;
		private var _horizontalScrollBarEnabled:Boolean;
		
		private var _verticalScrollBar:IScrollBar;
		private var _horizontalScrollBar:IScrollBar;
		
		/**
		*	Creates a <code>Scroller</code> instance.
		*	
		*	@param width The width of the scroller.
		*	@param height The height of the scroller.
		*/
		public function Scroller(
			width:Number = NaN,
			height:Number = NaN )
		{
			super();
			preferredWidth = width;
			preferredHeight = height;
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChildren(
			width:Number,
			height:Number ):void
		{
			trace("Scroller::layoutChildren(), ", width, height );
		}
	}
}