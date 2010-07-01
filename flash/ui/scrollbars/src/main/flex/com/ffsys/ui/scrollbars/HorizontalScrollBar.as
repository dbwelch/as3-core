package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import com.ffsys.ui.common.Direction;
	import com.ffsys.ui.buttons.ButtonLoopMode;
	import com.ffsys.ui.buttons.BackButton;
	import com.ffsys.ui.buttons.ForwardButton;
	
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
			height:Number = 14 )
		{
			_direction = Direction.HORIZONTAL;
			super( target, width );
			this.preferredWidth = width;
			this.preferredHeight = height;		
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
			scrollTrack = new ScrollTrack(
				preferredWidth, preferredHeight );
				
			var buttonSize:Number = preferredHeight;
			
			//set up the scroll buttons
			negativeScrollButton = new BackButton(
				null, null, buttonSize, buttonSize );
			
			positiveScrollButton = new ForwardButton(
				null, null, buttonSize, buttonSize );
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChildren(
			width:Number, height:Number ):void
		{
			super.layoutChildren( width, height );
			if( positiveScrollButton )
			{
				positiveScrollButton.x =
					size - positiveScrollButton.preferredWidth;
			}
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
	}
}