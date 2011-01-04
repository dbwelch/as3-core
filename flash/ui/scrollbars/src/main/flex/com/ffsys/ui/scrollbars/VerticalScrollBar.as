package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	import com.ffsys.ui.buttons.IButton;	
	import com.ffsys.ui.common.Direction;
	
	import com.ffsys.ui.graphics.RectangleGraphic;
	import com.ffsys.ui.graphics.SolidFill;
	
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
			super( target, height );
			this.preferredWidth = width;
			this.preferredHeight = height;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function setTargetScrollRect( target:DisplayObject ):void
		{
			var r:Rectangle = new Rectangle(
				0, 0, measuredSize, preferredHeight );
			this.target.scrollRect = r;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function set preferredHeight( height:Number ):void
		{
			super.preferredHeight = height;
			_size = height;
		}		
		
		/**
		*	@inheritDoc	
		*/
		override public function set scrollDrag( value:IScrollDrag ):void
		{
			super.scrollDrag = value;

			if( scrollDrag )
			{
				scrollDrag.minimumHeight = minimumScrollDragSize;
			}
		}
		
		/**
		*	Scrolls the target up by the current scroll amount.
		*/
		public function scrollUp():void
		{
			var position:Number = scrollPosition;
			scrollPosition = position + Math.abs( scrollAmount );
		}
		
		/**
		*	Scrolls the target down by the current scroll amount.
		*/
		public function scrollDown():void
		{
			var position:Number = scrollPosition;
			scrollPosition = position + -Math.abs( scrollAmount );
		}
		
		/**
		* 	The scroll up button.
		*/
		public function get scrollUpButton():IButton
		{
			return this.positiveScrollButton;
		}		
		
		public function set scrollUpButton( value:IButton ):void
		{
			this.positiveScrollButton = value;
		}
		
		/**
		* 	The scroll down button.
		*/
		public function get scrollDownButton():IButton
		{
			return this.negativeScrollButton;
		}
		
		public function set scrollDownButton( value:IButton ):void
		{
			this.negativeScrollButton = value;
		}		

		/**
		*	@inheritDoc	
		*/
		override protected function layoutChildren(
			width:Number, height:Number ):void
		{	
			
			//trace("VerticalScrollBar::layoutChildren()", negativeScrollButton, positiveScrollButton, scrollDrag, scrollTrack );
			
			if( negativeScrollButton )
			{
				negativeScrollButton.x = paddings.left;
				negativeScrollButton.y =
					size - ( fixedSize + paddings.bottom );
					
				
				//trace("VerticalScrollBar::layoutChildren()", "SETTING SCROLL BUTTON SIZE", fixedSize );					
					
				negativeScrollButton.setSize( fixedSize, fixedSize );
			}			
			
			if( positiveScrollButton )
			{
				positiveScrollButton.x = paddings.left;
				positiveScrollButton.y = paddings.top;
				
				positiveScrollButton.setSize( fixedSize, fixedSize );
			}
			
			if( scrollDrag )
			{
				scrollDrag.x = paddings.left;
			}
			
			measure();
			
			if( scrollDrag )
			{
				scrollDrag.y = scrollTrackPosition;
			}
			
			super.layoutChildren( width, height );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function negativeScroll( event:Event ):void
		{
			scrollDown();
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function positiveScroll( event:Event ):void
		{
			scrollUp();
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
				event.localY, 0, scrollTrack.preferredHeight );
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
				_scrollTrackLoopComparePosition = scrollDrag.y - scrollTrackPosition;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override internal function scrollTrackLoop(
			event:MouseEvent ):void
		{	
			event.localY < _scrollTrackLoopComparePosition ? scrollUp() : scrollDown();
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
				scrollDrag.y = scrollTrackPosition
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
				scrollDrag.setSize( fixedSize, scrollDragSize );
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
					scrollDrag.x, scrollTrackPosition,
					0, scrollTrackSize - scrollDrag.preferredHeight );
				
				_scrollDragDistance =
					( scrollTrackSize - scrollDrag.preferredHeight );

				scrollDrag.drag.bounds = _scrollDragBounds;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function get fixedSize():Number
		{
			return preferredWidth - paddings.left - paddings.right;
		}
		
		/**
		*	@inheritDoc
		*/
		override internal function dragged( scrollDrag:IScrollDrag ):void
		{
			var position:Number = ( scrollDrag.y - scrollTrackPosition ) / _scrollDragDistance;
			normalizedPosition = position;
		}
	}
}