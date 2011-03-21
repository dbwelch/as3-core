package org.flashx.ui.display
{
	import flash.display.DisplayObject;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	/**
	*	Encapsulates the logic for waiting a specified number
	* 	of milliseconds before removing a display object from
	* 	the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2010
	*/
	public class DisplayObjectTimeout extends Object
		implements IDisplayObjectTimeout
	{
		private var _target:DisplayObject;
		private var _timeout:Number;
		private var _timer:Timer;
		
		/**
		* 	Creates a <code>DisplayObjectTimeout</code> instance.
		* 
		* 	@param target The target display object.
		* 	@param timeout The timeout in milliseconds before the display object
		* 	is removed.
		*/
		public function DisplayObjectTimeout(
			target:DisplayObject = null,
			timeout:Number = 5000 )
		{
			super();
			this.target = target;
			this.timeout = timeout;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get target():DisplayObject
		{
			return _target;
		}
		
		public function set target( target:DisplayObject ):void
		{
			_target = target;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get timeout():Number
		{
			return _timeout;
		}
		
		public function set timeout( timeout:Number ):void
		{
			_timeout = timeout;
		}
		
		/**
		* 	Invoked to remove the target display object from
		* 	the display list.
		* 
		*	This method is invoked automatically when the timeout
		* 	completes.
		*/
		protected function remove():void
		{
			if( target && target.parent )
			{
				target.parent.removeChild( target );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hidden():void
		{
			//remove the target display object
			remove();
			
			//clean our references
			destroy();
		}
		
		/**
		* 	Starts this timeout running.
		* 
		* 	This method will throw a runtime error if no
		* 	target display object is assigned.
		*/
		public function start():void
		{
			if( !target )
			{
				throw new Error( "Cannot start a display object timeout with a null target." );
			}
			
			if( target is IDisplayObjectTimeoutShow )
			{
				IDisplayObjectTimeoutShow( target ).show();
			}else if( this is IDisplayObjectTimeoutShow )
			{
				IDisplayObjectTimeoutShow( this ).show();
			}else
			{
				shown();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function shown():void
		{
			startTimer();
		}
		
		/**
		* 	Stops this timeout running.
		*/
		public function stop():void
		{
			stopTimer();
		}
		
		/**
		* 	@private
		*/
		private function startTimer():void
		{
			stopTimer();
			
			_timer = new Timer( timeout, 1 );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, complete );
			_timer.start();
		}
		
		/**
		* 	@private
		*/
		private function complete( event:TimerEvent ):void
		{
			if( target is IDisplayObjectTimeoutHide )
			{
				IDisplayObjectTimeoutHide( target ).hide();
			}else if( this is IDisplayObjectTimeoutHide )
			{
				IDisplayObjectTimeoutHide( this ).hide();
			}else
			{
				hidden();
			}
		}
		
		/**
		* 	@private
		*/
		private function stopTimer():void
		{
  			if( _timer )
			{
				_timer.removeEventListener( TimerEvent.TIMER_COMPLETE, complete );
				_timer.stop();
			}
			
			_timer = null;
		}
		
		/**
		* 	Destroys this instance.
		* 
		* 	This stops any running timer and cleans references to complex
		* 	objects referenced by this implementation.
		* 
		* 	This method is called by default when the timeout completes so
		* 	if you want to reuse a display object timeout implementation you
		* 	should reassign the target before calling the start method.
		*/
		public function destroy():void
		{
			//clean our timer
			stopTimer();
			
			//clean our target reference
			_target = null;
		}
	}
}