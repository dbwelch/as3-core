package org.flashx.ui.scrollbars {
	
	import org.flashx.ui.buttons.GraphicButton;
	import org.flashx.ui.graphics.*;
	import org.flashx.ui.core.State;
	
	import org.flashx.ui.drag.DragOperation;
	import org.flashx.ui.drag.IDragOperation;
	
	/**
	*	Represents the draggable scroll thumb
	*	for a scroll bar.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public class ScrollDrag extends GraphicButton
		implements IScrollDrag {
			
		private var _scrollBar:IScrollBar;
		
		/**
		*	Creates a <code>ScrollDrag</code> instance.
		*	
		*	@param width The preferred width for the scroll track.
		*	@param height The preferred height for the scroll track.
		*/
		public function ScrollDrag(
			width:Number = 10,
			height:Number = 10 )
		{
			super();
			this.preferredWidth = width;
			this.preferredHeight = height;
			this.interactive = true;
			this.drag = new DragOperation();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get scrollBar():IScrollBar
		{
			return _scrollBar;
		}
		
		public function set scrollBar( scroller:IScrollBar ):void
		{
			_scrollBar = scroller;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function dragUpdate( drag:IDragOperation ):void
		{
			if( scrollBar )
			{
				AbstractScrollBar( scrollBar ).dragged( this );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function set interactive(
			value:Boolean ):void
		{
			super.interactive = value;
			useHandCursor = false;
			buttonMode = false;
		}
	}
}