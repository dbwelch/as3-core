package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import com.ffsys.ui.common.Direction;
	import com.ffsys.ui.buttons.ButtonLoopMode;
	import com.ffsys.ui.buttons.DownButton;
	import com.ffsys.ui.buttons.UpButton;
	
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
			width:Number = 14,
			height:Number = 100 )
		{
			_direction = Direction.VERTICAL;
			super( target, height );
			this.preferredWidth = width;
			this.preferredHeight = height;
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
		*	@inheritDoc
		*/
		override protected function createChildren():void
		{
			super.createChildren();
			
			//set up the scroll track
			this.scrollTrack = new ScrollTrack(
				preferredWidth, preferredHeight );
				
			var buttonSize:Number = preferredWidth;
			
			negativeScrollButton = new DownButton(
				null, null, buttonSize, buttonSize );
			
			positiveScrollButton = new UpButton(
				null, null, buttonSize, buttonSize );
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function layoutChildren(
			width:Number, height:Number ):void
		{
			if( negativeScrollButton )
			{
				negativeScrollButton.y =
					size - negativeScrollButton.preferredHeight;
			}
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
	}
}