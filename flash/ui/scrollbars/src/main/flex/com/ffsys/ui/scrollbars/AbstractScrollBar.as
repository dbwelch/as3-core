package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import com.ffsys.ui.common.Direction;
	import com.ffsys.ui.buttons.IButton;
	import com.ffsys.ui.buttons.ButtonLoopMode;
	import com.ffsys.ui.core.UIComponent;
	
	/**
	*	Abstract super class for scroll bar implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.06.2010
	*/
	public class AbstractScrollBar extends UIComponent
		implements IScrollBar {
		
		/**
		*	@private
		*/
		protected var _direction:String;
		
		/**
		*	@private	
		*/
		protected var _size:Number;
		
		private var _target:DisplayObject;
		private var _scrollTrack:IScrollTrack;
		private var _negativeScrollButton:IButton;
		private var _positiveScrollButton:IButton;
		private var _scrollAmount:Number = 5;
		private var _scrollPosition:Number = 0;
		
		private var _minimumScrollPosition:Number;
		private var _maximumScrollPosition:Number;
		private var _scrollDistance:Number = 0;
		
		private var _loop:String = ButtonLoopMode.DOWN;
		
		/**
		*	Creates an <code>AbstractScrollBar</code> instance.
		*	
		*	@param target The target to be scrolled.
		*	@param size The size of the scroll area.
		*/
		public function AbstractScrollBar(
			target:DisplayObject = null,
			size:Number = 100 )
		{
			super();
			_size = size;
			if( target )
			{
				this.target = target;
			}			
		}
		
		/**
		*	@inheritDoc
		*/
		public function get loop():String
		{
			return _loop;
		}
		
		public function set loop( value:String ):void
		{
			if( value
			 	&& ( value != ButtonLoopMode.OVER && value != ButtonLoopMode.DOWN ) )
			{
				throw new Error(
					"Invalid button loop mode '" + value + "'." );
			}
			
			_loop = value;
			
			if( negativeScrollButton )
			{
				negativeScrollButton.loop = value;
			}
			
			if( positiveScrollButton )
			{
				positiveScrollButton.loop = value;
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function get size():Number
		{
			return _size;
		}
		
		public function set size( size:Number ):void
		{
			_size = size;
			updateScrollProperties();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get scrollAmount():Number
		{
			return _scrollAmount;
		}
		
		public function set scrollAmount( amount:Number ):void
		{
			_scrollAmount = amount;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get negativeScrollButton():IButton
		{
			return _negativeScrollButton;
		}
		
		public function set negativeScrollButton( button:IButton ):void
		{
			if( negativeScrollButton
				&& contains( DisplayObject( negativeScrollButton ) ) )
			{
				negativeScrollButton.removeEventListener(
					MouseEvent.MOUSE_DOWN, negativeScroll );
				
				removeChild( DisplayObject( negativeScrollButton ) );
			}
			
			_negativeScrollButton = button;
			
			if( negativeScrollButton )
			{
				negativeScrollButton.loop = this.loop;
				
				negativeScrollButton.addEventListener(
					MouseEvent.MOUSE_DOWN, negativeScroll );				
				
				addChild( DisplayObject( negativeScrollButton ) );
			}
		}
		
		/**
		*	@inheritDoc
		*/		
		public function get positiveScrollButton():IButton
		{
			return _positiveScrollButton;
		}
		
		public function set positiveScrollButton( button:IButton ):void
		{
			if( positiveScrollButton
				&& contains( DisplayObject( positiveScrollButton ) ) )
			{
				positiveScrollButton.removeEventListener(
					MouseEvent.MOUSE_DOWN, positiveScroll );
				
				removeChild( DisplayObject( positiveScrollButton ) );
			}
			
			_positiveScrollButton = button;
			
			if( positiveScrollButton )
			{
				positiveScrollButton.loop = this.loop;
				
				positiveScrollButton.addEventListener(
					MouseEvent.MOUSE_DOWN, positiveScroll );
				
				addChild( DisplayObject( positiveScrollButton ) );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function get scrollTrack():IScrollTrack
		{
			return _scrollTrack;
		}
		
		public function set scrollTrack( value:IScrollTrack ):void
		{
			if( scrollTrack
			 	&& contains( DisplayObject( scrollTrack ) ) )
			{
				removeChild( DisplayObject( scrollTrack ) );
			}
			
			_scrollTrack = value;
			
			if( scrollTrack )
			{
				//TOOD: assign preferred size in concrete implementations
				
				scrollTrack.preferredWidth = preferredWidth;
				scrollTrack.preferredHeight = preferredHeight;
				
				addChild( DisplayObject( scrollTrack ) );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function get target():DisplayObject
		{
			return _target;
		}
		
		public function set target( target:DisplayObject ):void
		{
			_target = target;
			if( this.target )
			{
				_maximumScrollPosition = measuredPosition;
			}
			updateScrollProperties();
		}
		
		/**
		*	@inheritDoc
		*/
		public function updateScrollProperties():void
		{
			if( this.target )
			{
				_scrollDistance = measuredSize - size;
				_minimumScrollPosition = -Math.abs( _scrollDistance );
				
				/*
				trace("AbstractScrollBar::updateScrollProperties(), ",
					measuredSize, size, _scrollDistance,
					_minimumScrollPosition, _maximumScrollPosition );
				*/
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function get direction():String
		{
			return _direction;
		}
		
		/**
		*	@private
		*	
		*	Gets the property that will set the scroll
		*	for the target.	This value depends upon whether
		*	the target is a textfield and the direction of this
		*	scroll bar.
		*/
		protected function get targetScrollProperty():String
		{
			var output:String = null;
			if( target is TextField )
			{
				output = ( direction == Direction.HORIZONTAL )
					? "scrollH" : "scrollV";
			}else{
				output = ( direction == Direction.HORIZONTAL )
					? "x" : "y";
			}
			return output;
		}
		
		/**
		*	@private
		*	
		*	Gets the property that measures the size of the
		*	target being scrolled.
		*/
		protected function get targetMeasureProperty():String
		{
			var output:String = null;
			if( target is TextField )
			{
				output = ( direction == Direction.HORIZONTAL )
					? "maxScrollH" : "maxScrollV";
			}else{
				output = ( direction == Direction.HORIZONTAL )
					? "width" : "height";
			}
			return output;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get measuredPosition():Number
		{
			return target[ targetScrollProperty ];
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get measuredSize():Number
		{
			return target[ targetMeasureProperty ];
		}
		
		/**
		*	@inheritDoc
		*/
		public function get scrollDistance():Number
		{
			return _scrollDistance;
		}
		
		/**
		*	@inheritDoc
		*/
		public function isScrollable():Boolean
		{
			return _scrollDistance > 0;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get minimumScrollPosition():Number
		{
			return _minimumScrollPosition;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get maximumScrollPosition():Number
		{
			return _maximumScrollPosition;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get scrollPosition():Number
		{
			var property:String = targetScrollProperty;
			if( target && target.hasOwnProperty( property ) )
			{
				return target[ property ];
			}
			
			return NaN;
		}
		
		public function set scrollPosition( position:Number ):void
		{
			var property:String = targetScrollProperty;
			if( target && target.hasOwnProperty( property ) )
			{
				
				/*
				trace("AbstractScrollBar::scrollPosition(), ",
					position, minimumScrollPosition, maximumScrollPosition );
				*/
				
				//constrain to the scroll limits
				position = Math.max( minimumScrollPosition, position );
				position = Math.min( maximumScrollPosition, position );
				
				//trace("AbstractScrollBar::scrollPosition(), after constrain ", position );
				
				target[ property ] = position;
			}
		}
		
		/**
		*	@private
		*	
		*	Performs scrolling in a negative direction.
		*/
		protected function negativeScroll( event:Event ):void
		{
			//
		}
		
		/**
		*	@private
		*	
		*	Performs scrolling in a positive direction.
		*/
		protected function positiveScroll( event:Event ):void
		{
			//
		}
	}
}