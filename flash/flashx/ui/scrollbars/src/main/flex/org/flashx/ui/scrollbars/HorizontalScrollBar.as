package org.flashx.ui.scrollbars {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import org.flashx.ui.buttons.IButton;	
	import org.flashx.ui.common.Direction;
	
	import org.flashx.ui.graphics.RectangleGraphic;
	import org.flashx.ui.graphics.SolidFill;
	
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
			super( target, width );
			this.preferredWidth = width;
			this.preferredHeight = height;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function setTargetScrollRect( target:DisplayObject ):void
		{
			var r:Rectangle = new Rectangle(
				0, 0, preferredWidth, measuredSize );
			this.target.scrollRect = r;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function set preferredWidth( width:Number ):void
		{
			super.preferredWidth = width;
			_size = width;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function set scrollDrag( value:IScrollDrag ):void
		{
			super.scrollDrag = value;

			if( scrollDrag )
			{
				scrollDrag.minWidth = minimumScrollDragSize;
			}
		}
		
		/**
		* 	The scroll left button.
		*/
		public function get scrollLeftButton():IButton
		{
			return this.negativeScrollButton;
		}		
		
		public function set scrollLeftButton( value:IButton ):void
		{
			this.negativeScrollButton = value;
		}
		
		/**
		* 	The scroll right button.
		*/
		public function get scrollRightButton():IButton
		{
			return this.positiveScrollButton;
		}
		
		public function set scrollRightButton( value:IButton ):void
		{
			this.positiveScrollButton = value;
		}
		
		/**
		*	Scrolls the target left by the current scroll amount.
		*/
		public function scrollLeft():void
		{
			var position:Number = scrollPosition;
			scrollPosition = position + Math.abs( scrollAmount );
		}
		
		/**
		*	Scrolls the target right by the current scroll amount.
		*/
		public function scrollRight():void
		{
			var position:Number = scrollPosition;
			scrollPosition = position + -Math.abs( scrollAmount );
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChildren(
			width:Number, height:Number ):void
		{
			//trace("HorizontalScrollBar::layoutChildren()", target, negativeScrollButton, positiveScrollButton, scrollDrag, scrollTrack );			
			
			if( negativeScrollButton )
			{
				negativeScrollButton.x = paddings.left;
				negativeScrollButton.y = paddings.top;
				
				//trace("HorizontalScrollBar::layoutChildren()", "SETTING SCROLL BUTTON SIZE", fixedSize );
				
				negativeScrollButton.setSize( fixedSize, fixedSize );
			}
			
			if( positiveScrollButton )
			{
				positiveScrollButton.x =
					size - ( fixedSize + paddings.right );
				positiveScrollButton.y = paddings.top;
				
				positiveScrollButton.setSize( fixedSize, fixedSize );
			}
			
			if( scrollDrag )
			{
				scrollDrag.y = paddings.top;
				
				//scrollDrag.preferredWidth = fixedSize;
				//scrollDrag.preferredHeight = fixedSize;
			}
			
			measure();
			
			if( scrollDrag )
			{
				scrollDrag.x = scrollTrackPosition;
			}
			
			super.layoutChildren( width, height );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function negativeScroll( event:Event ):void
		{
			scrollLeft();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function positiveScroll( event:Event ):void
		{
			scrollRight();
		}
		
		/**
		*	Handles the scroll track click and updates
		*	the scroll position.
		*	
		*	@param event The mouse event.	
		*/
		override internal function scrollTrackJump(
			event:MouseEvent ):void
		{
			setScrollByRange(
				event.localX, 0, scrollTrack.preferredWidth );
		}
		
		/**
		*	@inheritDoc	
		*/
		override internal function scrollTrackLoopStart(
			event:MouseEvent ):void
		{
			_scrollTrackLoopComparePosition = scrollTrackSize / 2;
			
			if( scrollDrag )
			{
				_scrollTrackLoopComparePosition = scrollDrag.x - scrollTrackPosition;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override internal function scrollTrackLoop(
			event:MouseEvent ):void
		{	
			event.localX < _scrollTrackLoopComparePosition ? scrollLeft() : scrollRight();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function afterScroll():void
		{
			//scroll was triggered from something
			//other than the scroll drag so set the
			//drag position
			if( scrollDrag
			 	&& scrollDrag.drag
				&& !scrollDrag.drag.dragging )
			{
				updateScrollDragPosition();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function updateScrollDragPosition():void
		{
			if( scrollDrag )
			{
				scrollDrag.x = scrollTrackPosition
					+ ( normalizedPosition * _scrollDragDistance );				
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function updateScrollDragSize():void
		{
			if( scrollDrag )
			{
				scrollDrag.setSize( scrollDragSize, fixedSize );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function updateScrollDragBounds():void
		{
  			if( scrollDrag )
			{
				_scrollDragBounds = new Rectangle(
					scrollTrackPosition, scrollDrag.y,
					scrollTrackSize - scrollDrag.preferredWidth, 0 );
			
				_scrollDragDistance =
					( scrollTrackSize - scrollDrag.preferredWidth );
					
				scrollDrag.drag.bounds = _scrollDragBounds;
			}
		}		
		
		/**
		* 	@inheritDoc
		*/
		override protected function get fixedSize():Number
		{
			return preferredHeight - paddings.top - paddings.bottom;
		}
		
		/**
		*	@inheritDoc
		*/
		override internal function dragged( scrollDrag:IScrollDrag ):void
		{
			var position:Number = ( scrollDrag.x - scrollTrackPosition ) / _scrollDragDistance;
			normalizedPosition = position;
		}
	}
}