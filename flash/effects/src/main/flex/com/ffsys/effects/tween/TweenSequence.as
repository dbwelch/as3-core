/*
*	Possible enhancements:
*
*		- Negative delays
*		- Infinite loops :)
*		- Alternative easing for INBOUND loop direction
*/

package com.ffsys.effects.tween {

	import flash.events.IEventDispatcher;
	
	import com.ffsys.effects.events.TweenEvent;
	import com.ffsys.effects.events.TweenCompleteEvent;
	import com.ffsys.effects.events.TweenCollectionCompleteEvent;

	public class TweenSequence extends AbstractTweenCollection
		implements ITweenCollection {
		
		private var _currentIndex:int;
		private var _currentTarget:ITween;
		
		public function TweenSequence( ...args )
		{
			super( args );
			_currentIndex = 0;
		}			
		
		/*
		*	ITweenCollection implementation.
		*/
		override public function addTween( val:ITween ):int
		{
			if( delay )
			{
				val.delay = delay;
			}
			
			val.parent = this;
			
			return super.addTween( val );
		}
		
		/*
		*	ITweenTarget implementation.
		*/
		
		/**
		*	@private
		*
		*	Declared so that we adhere to the ITweenTarget interface
		*	but no functionality is implemented as you cannot set the
		*	target of a Tween instance - this is managed internally.
		*
		*/
		override public function set target( val:Object ):void
		{
			//
		}
		
		override public function get target():Object
		{
			return _currentTarget;
		}		
		
		/*
		*	ITweenControl implementation.
		*/
		override public function start( trigger:Boolean = false ):void
		{
			var index:int = _currentIndex;
			
			//trace( "Tween sequence start : " + index );
			
			if( index == 0 )
			{
				super.start( trigger );
			}
			
			if( index > ( targets.length - 1 ) )
			{
				dispatchCollectionCompleteEvent( new TweenCollectionCompleteEvent( this ) );
				
				reset();
				return;
			}
			
			//trace( "TweenSequence start index : " + index );
			
			/*
			if( _currentTarget )
			{	
				removeProxyListeners( _currentTarget as IEventDispatcher );
			}
			*/
			
			var item:ITween = targets[ index ];
			
			paused = false;
			complete = false;
			playing = true;
			
			_currentTarget = item;
			
			addProxyListeners( item as IEventDispatcher );
			
			//trace( "willTrigger : " + ( item as IEventDispatcher ).willTrigger( TweenEvent.COMPLETE ) );
			
			item.start();
		}
		
		override public function stop():void
		{
			if( _currentTarget )
			{
				_currentTarget.stop();
			}
			
			playing = false;
			super.stop();
		}
		
		override public function pause():void
		{
			if( _currentTarget )
			{
				_currentTarget.pause();
			}
			
			paused = true;
			super.pause();
		}
		
		override public function resume():void
		{
			if( !paused )
			{
				return;
			}
			
			if( _currentTarget )
			{
				_currentTarget.resume();
			}
			
			paused = false;
			super.resume();
		}
		
		override public function finish( original:Boolean = false ):void
		{
			if( _currentTarget )
			{
				_currentTarget.finish( original );
			}			
			
			complete = true;
			
			//dispatchEvent( new TweenCollectionResumeEvent() );
			
			super.finish();
		}
		
		/*
		*	ITweenParameters implementation.
		*
		*	Always operates on the last ITween added to this group.
		*/
		override public function set delay( val:Number ):void
		{
			super.delay = val;
			
			var i:int = 0;
			var l:int = targets.length;
			
			var target:ITween;
			
			for( ;i < l;i++ )
			{
				target = targets[ i ];
				target.delay = val;
			}
			
		}
		
		/*
		*	ITweenEventProxy implementation.
		*/
		override public function dispatchCompleteEvent( event:TweenCompleteEvent ):void
		{
			//trace( "Tween sequence complete : " + this );
			//trace( "Tween sequence complete target : " + event.target );
			
			
			/*
			var broadcast:Boolean = true;
			
			var i:int = 0;
			var l:int = this.targets.length;
			
			var target:ITween;
			
			for( ;i < l;i++ )
			{
				target = this.targets[ i ];
				broadcast = ( broadcast && target.complete );
				
				//trace( "TweenSequence complete : " + target );
				//trace( "TweenSequence complete : " + target.complete );
			}
			*/			
			
			super.dispatchCompleteEvent( event );
			
			//trace( "Tween sequence complete hasSequentialElements() : " + hasSequentialElements() );
			
			if( hasSequentialElements() )
			{
				next();
			}
		}
		
		override public function dispatchCollectionCompleteEvent(
			event:TweenCollectionCompleteEvent ):void
		{
			if( hasSequentialElements() )
			{
				next();
			}else{
			
				//trace( "TweenSequence dispatchCollectionCompleteEvent : " + event.target );
			
				removeProxyListeners( event.target as IEventDispatcher );
				
				playing = false;
				complete = true;
				
				//trace( "TweenSequence dispatchCollectionCompleteEvent : " + this );
				
				super.dispatchCollectionCompleteEvent( event );
			}
		}
		
		/*
		*	ITweenClone implementation.
		*/
		override public function clone():ITween
		{
			var tween:TweenSequence = new TweenSequence();
			
			var i:int = 0;
			var l:int = this.targets.length;
			
			for( ;i < l;i++ )
			{
				tween.addTween( this.targets[ i ].clone() );
			}
			
			return tween;
		}
		
		/*
		*	Utility methods.
		*/
		private function next():void
		{
			
			//trace( "Tween sequence next!!!" );
			
			if( _currentTarget )
			{	
				removeProxyListeners( _currentTarget as IEventDispatcher );
			}
			
			_currentIndex++;
			start();
		}
		
		public function reset():void
		{
			if( !playing )
			{
				_currentIndex = 0;
				_currentTarget = null;
			}else{
				throw new Error( "Cannot reset() a TweenSequence that is playing." );
			}
		}		
		
		private function hasSequentialElements():Boolean
		{
			return ( _currentIndex < ( targets.length - 1 ) );
		}					
				
	}
	
}