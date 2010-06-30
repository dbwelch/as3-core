package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	import flash.text.TextField;
	
	import com.ffsys.ui.common.Direction;
	import com.ffsys.ui.buttons.IButton;
	import com.ffsys.ui.containers.Container;
	
	/**
	*	Abstract super class for scroll bar implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.06.2010
	*/
	public class AbstractScrollBar extends Container {
		
		/**
		*	@private
		*/
		protected var _direction:String;
		
		/**
		*	@private	
		*/
		protected var _size:Number;
		
		private var _target:DisplayObject;
		private var _scrollTrack:ScrollTrack;
		private var _negativeScrollButton:IButton;
		private var _positiveScrollButton:IButton;
		private var _scrollAmount:Number = 5;
		private var _scrollPosition:Number = 0;
		
		private var _minimumScrollPosition:Number;
		private var _maximumScrollPosition:Number;
		private var _scrollDistance:Number = 0;
		
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
		*	The size of the visible display area for the
		*	scroll target.	
		*/
		public function get size():Number
		{
			return _size;
		}
		
		/**
		*	The amount to scroll the target when the scroll
		*	buttons are used.
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
		*	The button that scrolls the target in a negative direction.
		*	
		*	For a horizontal scroll bar this is the left scroll button and
		*	for a vertical scroll bar this is the up scroll button.
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
				removeChild( DisplayObject( negativeScrollButton ) );
			}
			
			_negativeScrollButton = button;
			
			if( negativeScrollButton )
			{
				addChild( DisplayObject( negativeScrollButton ) );
			}
		}
		
		/**
		*	The button that scrolls the target in a positive direction.
		*	
		*	For a horizontal scroll bar this is the right scroll button and
		*	for a vertical scroll bar this is the bottom scroll button.
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
				removeChild( DisplayObject( positiveScrollButton ) );
			}
			
			_positiveScrollButton = button;
			
			if( positiveScrollButton )
			{
				addChild( DisplayObject( positiveScrollButton ) );
			}			
		}
		
		/**
		*	A scroll track for the scroll bar.	
		*/
		public function get scrollTrack():ScrollTrack
		{
			return _scrollTrack;
		}
		
		public function set scrollTrack( value:ScrollTrack ):void
		{
			if( scrollTrack
			 	&& contains( scrollTrack ) )
			{
				removeChild( scrollTrack );
			}
			
			_scrollTrack = value;
			
			if( scrollTrack )
			{
				scrollTrack.preferredWidth = preferredWidth;
				scrollTrack.preferredHeight = preferredHeight;
				addChild( scrollTrack );
			}
		}
		
		/**
		*	The target being scrolled.	
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
		*	Inspects the scroll target and updates the distance
		*	and minimum and maximum scroll positions.	
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
		*	The direction this scroll bar is operating in.	
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
		*	Gets the measured position of the target.
		*/
		public function get measuredPosition():Number
		{
			return target[ targetScrollProperty ];
		}		
		
		/**
		*	Gets the measured size of the target.
		*/
		public function get measuredSize():Number
		{
			return target[ targetMeasureProperty ];
		}
		
		/**
		*	Gets the distance that the target will be scrolled.	
		*/
		public function get scrollDistance():Number
		{
			return _scrollDistance;
		}
		
		/**
		*	Determines whether the target needs scrolling.	
		*/
		public function isScrollable():Boolean
		{
			return _scrollDistance > 0;
		}
		
		/**
		*	Gets the minimum scroll position.
		*/
		public function get minimumScrollPosition():Number
		{
			return _minimumScrollPosition;
		}
		
		/**
		*	Gets the maximum scroll position.
		*/
		public function get maximumScrollPosition():Number
		{
			return _maximumScrollPosition;
		}
		
		/**
		*	Determines the scroll position for this scroll bar.	
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
	}
}