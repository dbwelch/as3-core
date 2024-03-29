package org.flashx.ui.drag {

	import flash.display.DisplayObject;	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	
	import org.flashx.ui.core.IInteractiveComponent;
	
	/**
	*	Represents a drag operation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.07.2010
	*/
	public class DragOperation extends Object
		implements IDragOperation {
			
		//approximately 30fps
		private var _delay:Number = 33;
		private var _timer:Timer;
		private var _bounds:Rectangle;
		private var _locked:Boolean;
		private var _source:IInteractiveComponent;
		private var _target:Sprite;
		
		/**
		*	Creates a <code>DragOperation</code> instance.
		*/
		public function DragOperation()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get delay():Number
		{
			return _delay;
		}
		
		public function set delay( delay:Number ):void
		{
			_delay = delay;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get target():Sprite
		{
			return _target;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get source():IInteractiveComponent
		{
			return _source;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		
		public function set bounds( bounds:Rectangle ):void
		{
			_bounds = bounds;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get locked():Boolean
		{
			return _locked;
		}
		
		public function set locked( locked:Boolean ):void
		{
			_locked = locked;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get dragging():Boolean
		{
			return ( _source != null );
		}
		
		/**
		*	@inheritDoc
		*/
		public function start( source:IInteractiveComponent ):void
		{
			if( source )
			{
				_source = source;
				
				if( !DisplayObject( source ).stage )
				{
					throw new Error(
						"Cannot start a drag operation on a component that"
						+ " is not on the display list." );
				}
				
				_target = Sprite( source );
				
				DisplayObject( source ).stage.addEventListener(
					MouseEvent.MOUSE_UP, onMouseUp );
					
				DisplayObject( source ).stage.addEventListener(
					Event.MOUSE_LEAVE, onMouseLeave );
					
				/*
				source.stage.addEventListener(
					MouseEvent.MOUSE_MOVE, onMouseMove );
				*/
				
				target.startDrag( locked, bounds );
				
				startTimer();
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function stop():void
		{
			if( target )
			{
				target.stopDrag();
			
				if( target.parent
					&& target != source )
				{
					target.parent.removeChild( target );
				}
			}
			
			stopTimer();
			_source = null;
			_target = null;
		}
		
		/**
		*	@private	
		*/
		private function stopTimer():void
		{
			if( _timer )
			{
				_timer.removeEventListener( TimerEvent.TIMER, tick );
				_timer.stop();
			}
			
			_timer = null;
		}
		
		/**
		*	@private	
		*/
		private function startTimer():void
		{
			stopTimer();
			_timer = new Timer( delay, 0 );
			_timer.addEventListener( TimerEvent.TIMER, tick );
			_timer.start();
		}
		
		/**
		*	@private
		*	
		*	Invoked while the timer is running.
		*/
		private function tick( event:TimerEvent ):void
		{
			if( source is IDraggable )
			{
				source.dragUpdate( this );
			}
		}
		
		/**
		*	@private	
		*/
		private function onMouseUp( event:MouseEvent ):void
		{
			if( source && DisplayObject( source ).stage )
			{
				DisplayObject( source ).stage.removeEventListener(
					MouseEvent.MOUSE_UP, onMouseUp );
			}
			
			stop();
		}
		
		/**
		*	@private	
		*/
		private function onMouseLeave( event:Event ):void
		{
			if( event && event.target )
			{
				event.target.removeEventListener(
					Event.MOUSE_LEAVE, onMouseLeave );
			}
			
			stop();
		}
		
		/**
		*	@private	
		*/
		private function onMouseMove( event:Event ):void
		{
			if( source )
			{
				//trace("DragOperation::onMouseMove()", source.stage.mouseX, source.stage.mouseY );
			}
		}
	}
}