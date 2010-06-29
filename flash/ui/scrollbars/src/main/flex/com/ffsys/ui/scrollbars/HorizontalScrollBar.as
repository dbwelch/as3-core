package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.common.Direction;
	
	/**
	*	A scroll bar for scrolling a target in a horizontal direction.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.06.2010
	*/
	public class HorizontalScrollBar extends AbstractScrollBar {
		
		/**
		*	Creates a <code>HorizontalScrollBar</code> instance.
		*	
		*	@param target The target to be scrolled.
		*	@param width The width of the scroll bar.
		*	@param height The height of the scroll bar.
		*/
		public function HorizontalScrollBar(
			target:DisplayObject = null,
			width:Number = 100,
			height:Number = 12 )
		{
			_direction = Direction.HORIZONTAL;
			this.preferredWidth = width;
			this.preferredHeight = height;		
			super( target, width );
		}
	}
}