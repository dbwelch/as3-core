package com.ffsys.effects.tween {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.effects.IEffect;
	
	import com.ffsys.effects.tween.TweenEvent;

	public class TweenGroup extends AbstractTweenCollection
		implements ITweenCollection {
		
		public function TweenGroup( ...args )
		{
			super( args );
		}
		
		/*
		*	ITweenCollection implementation.
		*/
		override public function addTween( val:ITween ):int
		{
			if( delay && ( getLength() > 0 ) )
			{
				var indexDelay:Number = ( delay * getLength() );
			
				if( ( val is Tween ) )
				{
					val.delay = indexDelay;
				}else if( ( val is ITweenCollectionList ) )
				{
					var collection:ITweenCollectionList = ( val as ITweenCollectionList );
					var tweens:Array = collection.getAllTweens();
					
					var i:int = 0;
					var l:int = collection.getLength();
					
					for( ;i < l;i++ )
					{
						tweens[ i ].delay = indexDelay;
					}
				}
				
				//trace( "Tween group set delay : " + val );
				//trace( "Tween group set delay value : " + indexDelay );
			}
			
			addProxyListeners( val as IEventDispatcher );
			
			//trace( "Group add tween : " + val );
			//trace( "Group add tween : " + val.hasEventListener( TweenEvent.COMPLETE ) );
			
			val.parent = this;
			
			return super.addTween( val );
		}
		
		/*
		override public function set delay( val:Number ):void
		{
			var tweens:Array = this.getAllTweens();
			
			var i:int = 0;
			var l:int = this.getLength();
			
			var indexDelay:Number;
			
			for( ;i < l;i++ )
			{
				indexDelay = ( i * delay );
			
				tweens[ i ].delay = indexDelay;
			}		
		}
		*/
		
		/*
		*	ITweenTarget implementation.
		*/
		override public function get target():Object
		{
			return targets;
		}
		
		/*
		*	ITweenClone implementation.
		*/
		override public function clone():ITween
		{
			var tween:TweenGroup = new TweenGroup();
			
			var i:int = 0;
			var l:int = this.targets.length;
			
			for( ;i < l;i++ )
			{
				tween.addTween( this.targets[ i ].clone() );
			}
			
			return tween;
		}
		
		/*
		*	ITweenControl implementation.
		*/
		override public function start( trigger:Boolean = false ):void
		{
			applyMethodToTargets( TweenEvent.START, [ trigger ] );	
			paused = false;
			complete = false;
			playing = true;
			super.start( trigger );
		}
		
		override public function stop():void
		{
			applyMethodToTargets( TweenEvent.STOP, [] );
			playing = false;
			super.stop();
		}
		
		override public function pause():void
		{
			applyMethodToTargets( TweenEvent.PAUSE, [] );
			paused = true;
			super.pause();
		}
		
		override public function resume():void
		{
			applyMethodToTargets( TweenEvent.RESUME, [] );
			paused = false;
			super.resume();
		}
		
		override public function finish( original:Boolean = false ):void
		{
			applyMethodToTargets( TweenEvent.FINISH, [ original ] );
			complete = true;
			playing = false;
			paused = false;
			super.finish();
		}
		
		/*
		*	ITweenParameters implementation.
		*/
		
		override public function set delay( val:Number ):void
		{
			super.delay = val;
			
			var i:int = 0;
			var l:int = this.targets.length;
			
			var target:ITween;
			
			for( ;i < l;i++ )
			{
				target = this.targets[ i ];
				target.delay = ( i * val );
			}
			
		}
		
		/*
		*	ITweenEventProxy implementation.
		*/
		
		/*
		public function addProxyListeners( dispatcher:IEventDispatcher ):void
		{
			dispatcher.addEventListener( TweenEvent.START, dispatchStartEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.STOP, dispatchStopEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.PAUSE, dispatchPauseEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.RESUME, dispatchResumeEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.UPDATE, dispatchUpdateEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.END, dispatchEndEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.COMPLETE, dispatchCompleteEvent, false, 0, true );
			
			dispatcher.addEventListener(
				TweenEvent.COLLECTION_COMPLETE, dispatchCollectionCompleteEvent, false, 0, true );			
		}
		
		public function removeProxyListeners( dispatcher:IEventDispatcher ):void
		{
			dispatcher.removeEventListener( TweenEvent.START, dispatchStartEvent );
			dispatcher.removeEventListener( TweenEvent.STOP, dispatchStopEvent );
			dispatcher.removeEventListener( TweenEvent.PAUSE, dispatchPauseEvent );
			dispatcher.removeEventListener( TweenEvent.RESUME, dispatchResumeEvent );
			dispatcher.removeEventListener( TweenEvent.UPDATE, dispatchUpdateEvent );
			dispatcher.removeEventListener( TweenEvent.END, dispatchEndEvent );
			dispatcher.removeEventListener( TweenEvent.COMPLETE, dispatchCompleteEvent );
			
			dispatcher.removeEventListener(
				TweenEvent.COLLECTION_COMPLETE, dispatchCollectionCompleteEvent );		
		}
		*/
		
		override public function dispatchCompleteEvent( event:TweenEvent ):void
		{
			//removeProxyListeners( event.target as IEventDispatcher );
			
			//trace( "TweenGroup dispatch complete event : " + this );
			
			//trace( "Tween group complete : " + this );
			//trace( "Tween group complete target : " + event.target );			
			
			var broadcast:Boolean = true;
			
			var i:int = 0;
			var l:int = this.targets.length;
			
			var target:ITween;
			
			for( ;i < l;i++ )
			{
				target = this.targets[ i ];
				broadcast = ( broadcast && target.complete );
			}
			
			dispatchEvent( event );
			
			//trace( "Tween group should broadcast : " + broadcast );
			
			if( broadcast )
			{
				playing = false;
				complete = true;
				super.dispatchCollectionCompleteEvent( new TweenEvent( TweenEvent.COLLECTION_COMPLETE, this ) );
			}
		}
		
		override public function dispatchCollectionCompleteEvent(
			event:TweenEvent ):void
		{
			//removeProxyListeners( event.target as IEventDispatcher );
			
			//trace( "TweenGroup dispatch collection complete event : " + this );
			
			removeAllProxyListeners();
			super.dispatchCollectionCompleteEvent( event );
		}
	}
}