package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	
	import com.ffsys.ui.common.Direction;
	
	/**
	*	A scroll bar for scrolling a target in a vertical direction.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.06.2010
	*/
	public class VerticalScrollBar extends AbstractScrollBar {
		
		/**
		*	Creates a <code>VerticalScrollBar</code> instance.
		*	
		*	@param target The target to be scrolled.
		*	@param width The width of the scroll bar.
		*	@param height The height of the scroll bar.
		*/
		public function VerticalScrollBar(
			target:DisplayObject = null,
			width:Number = 12,
			height:Number = 100 )
		{
			_direction = Direction.VERTICAL;
			this.preferredWidth = width;
			this.preferredHeight = height;
			super( target, height );
		}
	}
}