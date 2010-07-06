package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import com.ffsys.ui.common.Direction;
	import com.ffsys.ui.buttons.ButtonLoopMode;
	import com.ffsys.ui.buttons.BackButton;
	import com.ffsys.ui.buttons.ForwardButton;
	
	import com.ffsys.ui.graphics.RectangleGraphic;
	import com.ffsys.ui.graphics.SolidFill;
	
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
			this.paddings.padding = 1;
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
				scrollDrag.minimumWidth = minimumScrollDragSize;
			}
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
		override protected function createChildren():void
		{
			super.createChildren();
			
			//set up the scroll track
			scrollTrack = new ScrollTrack();
				
			//set up the scroll buttons
			negativeScrollButton = new BackButton(
				null, null, fixedSize, fixedSize );
			
			positiveScrollButton = new ForwardButton(
				null, null, fixedSize, fixedSize );
				
			scrollDrag = new ScrollDrag(
				fixedSize, fixedSize );
				
			background = new RectangleGraphic(
				preferredWidth,
				preferredHeight,
				null,
				new SolidFill( 0x3d3c3c, 1 ) );				
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChildren(
			width:Number, height:Number ):void
		{			
			measure();
			
			if( negativeScrollButton )
			{
				negativeScrollButton.x = paddings.left;
				negativeScrollButton.y = paddings.top;
				
				negativeScrollButton.setSize( fixedSize, fixedSize );
			}
			
			if( positiveScrollButton )
			{
				positiveScrollButton.x =
					size - ( fixedSize + paddings.right );
				positiveScrollButton.y = paddings.top;
				
				positiveScrollButton.setSize( fixedSize, fixedSize );
			}
			
			if( scrollDrag && scrollDrag.drag )
			{
				scrollDrag.x = scrollTrackPosition;
				scrollDrag.y = paddings.top;
				
				_scrollDragBounds = new Rectangle(
					scrollTrackPosition, scrollDrag.y,
					scrollTrackSize - scrollDrag.preferredWidth, 0 );
					
				//trace("HorizontalScrollBar::layoutChildren(), ", _scrollDragBounds );
			
				_scrollDragDistance =
					( scrollTrackSize - scrollDrag.preferredWidth );
					
				scrollDrag.drag.bounds = _scrollDragBounds;
				
				//scrollDrag.setSize( fixedSize, fixedSize );
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
		override protected function afterScroll():void
		{
			//scroll was triggered from something
			//other than the scroll drag so set the
			//drag position
			if( scrollDrag
			 	&& scrollDrag.drag
				&& !scrollDrag.drag.dragging )
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
				scrollDrag.setSize( scrollDragSize, scrollDrag.preferredHeight );
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