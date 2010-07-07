package com.ffsys.ui.scrollbars {
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
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
		
		/**
		*	@private	
		*/
		protected var _scrollDragBounds:Rectangle;
		
		/**
		*	@private
		*/
		protected var _scrollDragDistance:Number;
		
		/**
		*	@private
		*/
		protected var _scrollTrackLoopComparePosition:Number;
		
		private var _target:DisplayObject;
		private var _scrollTrack:IScrollTrack;
		private var _scrollDrag:IScrollDrag;
		private var _negativeScrollButton:IButton;
		private var _positiveScrollButton:IButton;
		private var _scrollAmount:Number = 5;
		private var _scrollPosition:Number = 0;
		
		private var _minimumScrollPosition:Number;
		private var _maximumScrollPosition:Number;
		private var _scrollDistance:Number = 0;
		
		private var _loop:String = ButtonLoopMode.DOWN;
		private var _minimumScrollDragSize:Number = 5;
		
		private var _scrollTrackMode:String = ScrollTrackMode.LOOP_SCROLL;
		
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
		*	The mode the scroll track should operate in.	
		*/
		public function get scrollTrackMode():String
		{
			return _scrollTrackMode;
		}
		
		public function set scrollTrackMode( value:String ):void
		{
			_scrollTrackMode = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function set enabled( enabled:Boolean ):void
		{
			super.enabled = enabled;
			
			//proxy the enabled setting to child components
			//so that they can update their state
			if( positiveScrollButton )
			{
				positiveScrollButton.enabled = enabled;
			}
			
			if( negativeScrollButton )
			{
				negativeScrollButton.enabled = enabled;
			}
			
			if( scrollDrag )
			{
				scrollDrag.enabled = enabled;
				
				//the scroll drag is hidden when disabled
				scrollDrag.visible = enabled;
			}
			
			if( scrollTrack )
			{
				scrollTrack.enabled = enabled;
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function get minimumScrollDragSize():Number
		{
			return _minimumScrollDragSize;
		}
		
		public function set minimumScrollDragSize( value:Number ):void
		{
			_minimumScrollDragSize = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function scrollTo( child:DisplayObject ):Boolean
		{
			if( child == null )
			{
				throw new Error( "Cannot scroll to a null target display object." );
			}
			
			if( !this.target )
			{
				throw new Error( "Cannot scroll to when the scroll target is null." );
			}
			
			var container:DisplayObjectContainer = this.target as DisplayObjectContainer;
			
			if( !container )
			{
				throw new Error( "The scroll target must be a display object container to scroll to a child." );
			}
			
			if( !container.contains( child ) )
			{
				throw new Error( "The scroll to target must be a child of the scroll target." );
			}
			
			//TODO: allow targeting of nested child display objects
			//and to the co-ordinate space conversion
			//requires testing the target is in the parent hierarchy of the
			//child
			
			if( isScrollable() )
			{
				//get the position of the child and invert the sign to negative to get
				//the scroll position
				var position:Number = -Math.abs( child[ targetScrollProperty ] );
				scrollPosition = position;
				return true;
			}
			
			return false;
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
				scrollTrack.scrollBar = null;
				removeChild( DisplayObject( scrollTrack ) );
			}
			
			_scrollTrack = value;
			
			if( scrollTrack )
			{
				scrollTrack.scrollBar = this;
				scrollTrack.mode = scrollTrackMode;
				addChild( DisplayObject( scrollTrack ) );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function get scrollDrag():IScrollDrag
		{
			return _scrollDrag;
		}

		public function set scrollDrag( value:IScrollDrag ):void
		{
			if( scrollDrag
			 	&& contains( DisplayObject( scrollDrag ) ) )
			{
				
				/*
				scrollDrag.removeEventListener(
					MouseEvent.CLICK, onScrollDragClick );
				*/
				
				scrollDrag.scrollBar = null;
				removeChild( DisplayObject( scrollDrag ) );
			}

			_scrollDrag = value;

			if( scrollDrag )
			{
				/*
				scrollDrag.addEventListener(
					MouseEvent.CLICK, onScrollDragClick );
				*/
				
				scrollDrag.scrollBar = this;
				addChild( DisplayObject( scrollDrag ) );
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
		}
		
		/**
		*	@inheritDoc
		*/
		protected function updateScrollProperties():void
		{

			//trace("AbstractScrollBar::updateScrollProperties()", target );			
			
			if( target )
			{
				_scrollDistance = measuredSize - size;
				_minimumScrollPosition = -Math.abs( _scrollDistance );
				
				/*
				trace("AbstractScrollBar::updateScrollProperties()",
					_maximumScrollPosition, _scrollDistance, _minimumScrollPosition );
				*/
			}
			
			//update whether we are enabled
			enabled = isScrollable();
			
			//ensure that when we're disabled the scroll position
			//is reset so that content is not cut off and unreachable
			//if the content is masked
			if( !isScrollable() )
			{
				scrollPosition = _maximumScrollPosition;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function measure():void
		{
			updateScrollProperties();
			updateScrollDragSize();
			updateScrollDragPosition();
			updateScrollDragBounds();
		}
		
		/**
		* 	Gets the size for the scroll drag based on the scroll
		* 	distance.
		*/
		protected function get scrollDragSize():Number
		{
			var ratio:Number = Math.abs( measuredSize / size );
			
			if( measuredSize == 0 )
			{
				return minimumScrollDragSize;
			}
			
			if( ratio <= 1 )
			{
				return scrollTrackSize;
			}
			
			var dragSize:Number = Math.round( scrollTrackSize / ratio );
			return Math.max( minimumScrollDragSize, dragSize );
		}
		
		/**
		* 	Updates the size of the scroll drag to reflect the scroll
		* 	distance.
		*/
		protected function updateScrollDragSize():void
		{
			//
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
			if( target )
			{
				return target[ targetScrollProperty ];
			}
			
			return 0;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get measuredSize():Number
		{
			if( target )
			{
				return target[ targetMeasureProperty ];
			}
			
			return 0;
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
		* 	@inheritDoc
		*/
		public function scrollToStart():void
		{
			scrollPosition = maximumScrollPosition;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function scrollToEnd():void
		{
			scrollPosition = minimumScrollPosition;
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
			
			afterScroll();
		}
		
		/**
		*	The normalized scroll position between zero and one.
		*	
		*	A zero value indicates the minimum scroll position
		*	(no scroll) while a value of one indicates the
		*	maximum scroll position.
		*/
		public function get normalizedPosition():Number
		{
			return Math.abs( scrollPosition ) / Math.abs( scrollDistance );
		}
		
		public function set normalizedPosition( value:Number ):void
		{
			if( value < 0 || value > 1 )
			{
				throw new Error(
					"The normalized scroll postion must be between zero and one." );
			}
			
			var scaled:Number = value * Math.abs( scrollDistance );
			scrollPosition = maximumScrollPosition - scaled;
		}
		
		/**
		*	Converts a numeric value that falls between a given
		*	range into a valid scroll position.
		*	
		*	@param value The value that falls within the start and
		*	end range.
		*	@param start The start value for the range.
		*	@param end The end value for the range.
		*/
		public function setScrollByRange(
			value:Number, start:Number, end:Number ):void
		{
			//constrain value to range
			value = Math.max( value, start );
			value = Math.min( value, end );
			
			//convert to a normalized value and
			//set the scroll position
			var diff:Number = end - start;
			var normalized:Number = value / diff;
			normalizedPosition = normalized;
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
		
		/**
		*	@private
		*	
		*	Gets the size of the scroll track.
		*/
		protected function get scrollTrackSize():Number
		{
			var size:Number = this.size;
			
			if( negativeScrollButton )
			{
				size -=
					( direction == Direction.HORIZONTAL )
					? negativeScrollButton.layoutWidth + paddings.left
					: negativeScrollButton.layoutHeight + paddings.top;
			}
			
			if( positiveScrollButton )
			{
				size -=
					( direction == Direction.HORIZONTAL )
					? positiveScrollButton.layoutWidth + paddings.right
					: positiveScrollButton.layoutHeight + paddings.bottom;
			}
			
			//trace("AbstractScrollBar::scrollTrackSize(), ", this, size );
			
			if( scrollTrack )
			{
				size -= ( direction == Direction.HORIZONTAL )
				? scrollTrack.margins.left + scrollTrack.margins.right
				: scrollTrack.margins.top + scrollTrack.margins.bottom;
			}
			
			return size;
		}
		
		/**
		*	@private
		*	
		*	Gets the position of the scroll track.
		*/
		protected function get scrollTrackPosition():Number
		{
			var position:Number = 0;

			if( positiveScrollButton )
			{
				position +=
					( direction == Direction.HORIZONTAL )
					? paddings.left + positiveScrollButton.layoutWidth
					: paddings.top + positiveScrollButton.layoutHeight;
			}
			
			if( scrollTrack )
			{
				position += ( direction == Direction.HORIZONTAL )
				? scrollTrack.margins.left
				: scrollTrack.margins.top;
			}
			
			return position;
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function layoutChildren(
			width:Number, height:Number ):void
		{
			super.layoutChildren( width, height );
			
			if( scrollTrack )
			{
				scrollTrack.preferredWidth =
					( direction == Direction.HORIZONTAL )
					? scrollTrackSize
					: preferredWidth - ( paddings.left + paddings.right );
				scrollTrack.preferredHeight = 
					( direction == Direction.HORIZONTAL )
					? preferredHeight - ( paddings.top + paddings.bottom )
					: scrollTrackSize;
					
				//force a redraw of the scroll track
				if( scrollTrack.preferredWidth > 0
					&& scrollTrack.preferredHeight > 0 )
				{
					scrollTrack.setSize(
						scrollTrack.preferredWidth,
						scrollTrack.preferredHeight );
				}
					
				if( direction == Direction.HORIZONTAL )
				{
					scrollTrack.x = scrollTrackPosition;
					scrollTrack.y = paddings.top;
				}else{
					scrollTrack.x = paddings.left;
					scrollTrack.y = scrollTrackPosition;
				}
			}
		}
		
		/**
		*	Handles the scroll track jump click and updates
		*	the scroll position.
		*	
		*	@param event The mouse event.	
		*/
		internal function scrollTrackJump(
			event:MouseEvent ):void
		{	
			//
		}
		
		/**
		*	Invoked when the scroll track starts looping.
		*/
		internal function scrollTrackLoopStart(
			event:MouseEvent ):void
		{
			//
		}
		
		/**
		*	Handles the scroll track loop and updates
		*	the scroll position.
		*	
		*	@param event The mouse event.	
		*/
		internal function scrollTrackLoop(
			event:MouseEvent ):void
		{	
			//
		}		
		
		/**
		*	Invoked after a scroll operation has taken place.	
		*/
		protected function afterScroll():void
		{
			//
		}
		
		/**
		* 	Invoked to update the position of the scroll drag.
		*/
		protected function updateScrollDragPosition():void
		{
			
		}
		
		/**
		* 	Invoked to update the drag bounds of the scroll drag.
		*/
		protected function updateScrollDragBounds():void
		{
			
		}		
		
		/**
		* 	Gets the fixed size for scroll bar component elements.
		*/
		protected function get fixedSize():Number
		{
			return NaN;
		}
		
		/**
		*	Invoked while the scroll drag is being dragged.
		*	
		*	@param scrollDrag The scroll drag that triggered the
		*	drag operation.
		*/
		internal function dragged( scrollDrag:IScrollDrag ):void
		{
			//
		}
	}
}