package com.ffsys.ui.scrollbars {
	
	import flash.events.MouseEvent;
	
	import com.ffsys.ui.buttons.ButtonLoopMode;
	import com.ffsys.ui.buttons.GraphicButton;
	import com.ffsys.ui.graphics.*;
	import com.ffsys.ui.core.State;	
	
	/**
	*	Represents the scroll track for a scroll bar.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.06.2010
	*/
	public class ScrollTrack extends GraphicButton
		implements IScrollTrack {
			
		private var _scrollBar:IScrollBar;
		private var _mode:String = ScrollTrackMode.NONE;
		
		/**
		*	Creates a <code>ScrollTrack</code> instance.
		*	
		*	@param width The preferred width for the scroll track.
		*	@param height The preferred height for the scroll track.
		*/
		public function ScrollTrack(
			width:Number = 10,
			height:Number = 10 )
		{
			super();
			margins.margin = 1;
			this.preferredWidth = width;
			this.preferredHeight = height;
			this.interactive = true;
		}
	
		/**
		* 	@inheritDoc
		*/
		public function get mode():String
		{
			return _mode;
		}
		
		public function set mode( mode:String ):void
		{
			if( !mode || mode == ScrollTrackMode.NONE )
			{
				removeEventListener(
					MouseEvent.CLICK, onScrollTrackClick );				
				
				//clear any loop
				loop = null;
			}
			
			_mode = mode;	
			
			if( this.mode && this.scrollBar )
			{
				if( this.mode == ScrollTrackMode.JUMP_SCROLL )
				{
					addEventListener(
						MouseEvent.CLICK, onScrollTrackClick );
				}else if( this.mode == ScrollTrackMode.LOOP_SCROLL )
				{
					loop = ButtonLoopMode.DOWN;
				}
			}
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function loopStarted( event:MouseEvent ):void
		{
			AbstractScrollBar( scrollBar ).scrollTrackLoopStart( event );
		}		
		
		/**
		*	@inheritDoc
		*/
		override protected function looping( event:MouseEvent ):void
		{
			AbstractScrollBar( scrollBar ).scrollTrackLoop( event );
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
			if( this.scrollBar && !scroller )
			{
				removeEventListener(
					MouseEvent.CLICK, onScrollTrackClick );	
			}
			
			_scrollBar = scroller;
			
			if( this.scrollBar )
			{
				addEventListener(
					MouseEvent.CLICK, onScrollTrackClick );
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
		
		/**
		*	@private
		*/
		protected function onScrollTrackClick(
			event:MouseEvent ):void
		{
			if( scrollBar )
			{
				if( mode == ScrollTrackMode.JUMP_SCROLL )
				{
					AbstractScrollBar( scrollBar ).scrollTrackJump( event );
				}
			}
		}		
	}
}