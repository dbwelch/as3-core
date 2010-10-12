package com.ffsys.effects.tween {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.effects.events.TweenEvent;
	import com.ffsys.effects.events.TweenCompleteEvent;
	import com.ffsys.effects.events.TweenEndEvent;
	import com.ffsys.effects.events.TweenPauseEvent;
	import com.ffsys.effects.events.TweenResumeEvent;
	import com.ffsys.effects.events.TweenStartEvent;
	import com.ffsys.effects.events.TweenStopEvent;
	import com.ffsys.effects.events.TweenUpdateEvent;
	import com.ffsys.effects.events.TweenCollectionStartEvent;
	import com.ffsys.effects.events.TweenCollectionStopEvent;
	import com.ffsys.effects.events.TweenCollectionPauseEvent;
	import com.ffsys.effects.events.TweenCollectionResumeEvent;
	import com.ffsys.effects.events.TweenCollectionCompleteEvent;
	import com.ffsys.effects.events.TweenCollectionFinishEvent;
	
	/**
	*	Represents an Abstract super class for all ITweenCollection instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public class AbstractTweenCollection extends AbstractTween
		implements ITweenCollection {
		
		protected var _collectionDecorator:TweenCollectionDecorator;
		
		public function AbstractTweenCollection( tweens:Array = null )
		{
			super();
			
			_collectionDecorator = new TweenCollectionDecorator();
			
			if( tweens )
			{
				addTweens.apply( this, tweens );
			}
		}		
		
		/*
		*	ITweenCollection implementation.
		*/
		public function getAllTweens():Array
		{
			return _collectionDecorator.getAllTweens();
		}
				
		public function addTweens( ...args ):void
		{
			_collectionDecorator.addTweens.apply( _collectionDecorator, args );
		}
		
		public function addTween( val:ITween ):int
		{
			return _collectionDecorator.addTween( val );
		}
		
		public function removeTween( val:ITween ):Boolean
		{
			return _collectionDecorator.removeTween( val );
		}
		
		public function getTweenAt( index:int ):ITween
		{
			return _collectionDecorator.getTweenAt( index );
		}	

		public function removeTweenAt( index:int ):ITween
		{
			return _collectionDecorator.removeTweenAt( index )
		}
		
		public function getLength():int
		{
			return _collectionDecorator.getLength();
		}
		
		public function last():ITween
		{
			return _collectionDecorator.last();
		}
		
		public function first():ITween
		{
			return _collectionDecorator.first();
		}
		
		public function clear():void
		{
			_collectionDecorator.clear();
		}
		
		public function isEmpty():Boolean
		{
			return _collectionDecorator.isEmpty();
		}
		
		public function get targets():Array
		{
			return _collectionDecorator.targets;
		}
		
		public function getTweensByType( type:Class ):ITweenCollectionList
		{
			return _collectionDecorator.getTweensByType( type );
		}
		
		public function merge(
			source:ITweenCollectionList,
			destination:ITweenCollectionList = null ):ITweenCollectionList
		{
			return _collectionDecorator.merge( source, destination );
		}
		
		
		/*
		*	ITweenReverse implementation.
		*/
		override public function reverse():Array
		{
			
			trace( "AbstractTweenCollection reverse" );
			
			return _collectionDecorator.reverse();
		}
		
		/*
		*	ITweenTarget implementation.
		*/
		
		/**
		*	@private
		*
		*	Declared so that we adhere to the ITweenTarget interface
		*	but no functionality is implemented as you cannot set the
		*	target of an ITweenCollection instance.
		*
		*/		
		override public function set target( val:Object ):void
		{
			applyPropertyToTargets( "target", val );
		}
		
		override public function get target():Object
		{
			return new Object();
		}
		
		/*
		*	ITweenControl implementation.
		*/
		override public function start( trigger:Boolean = false ):void
		{
			dispatchEvent( new TweenCollectionStartEvent( this ) );
		}
		
		override public function stop():void
		{
			dispatchEvent( new TweenCollectionStopEvent( this ) );
		}
		
		override public function pause():void
		{
			dispatchEvent( new TweenCollectionPauseEvent( this ) );
		}
		
		override public function resume():void
		{
			dispatchEvent( new TweenCollectionResumeEvent( this ) );
		}
		
		override public function finish( original:Boolean = false ):void
		{
			dispatchEvent( new TweenCollectionFinishEvent( this ) );
		}
		
		/*
		*	ITweenEventProxy implementation.
		*/
		public function addProxyListeners( dispatcher:IEventDispatcher ):void
		{
			dispatcher.addEventListener( TweenEvent.START, dispatchStartEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.STOP, dispatchStopEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.PAUSE, dispatchPauseEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.RESUME, dispatchResumeEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.UPDATE, dispatchUpdateEvent, false, 0, true );
			dispatcher.addEventListener( TweenEvent.END, dispatchEndEvent, false, 0, true );
			
			//trace( "addProxyListeners : " + dispatcher );
			
			dispatcher.addEventListener( TweenEvent.COMPLETE, dispatchCompleteEvent, false, 0, true );
			
			var isCollection:Boolean = ( dispatcher is ITweenCollection );
			
			if( isCollection )
			{
				dispatcher.addEventListener(
					TweenEvent.COLLECTION_COMPLETE, dispatchCollectionCompleteEvent, false, 0, true );
			}else{
				//dispatcher.addEventListener( TweenEvent.COMPLETE, dispatchCompleteEvent, false, 0, true );
			}
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
			
			var isCollection:Boolean = ( dispatcher is ITweenCollection );
			
			if( isCollection )
			{
				dispatcher.removeEventListener(
					TweenEvent.COLLECTION_COMPLETE, dispatchCollectionCompleteEvent );
			}else{
				//dispatcher.removeEventListener( TweenEvent.COMPLETE, dispatchCompleteEvent );
			}
			
		}
		
		public function dispatchStartEvent( event:TweenStartEvent ):void
		{
			dispatchEvent( event );
		}
		
		public function dispatchStopEvent( event:TweenStopEvent ):void
		{
			dispatchEvent( event );
		}
		
		public function dispatchPauseEvent( event:TweenPauseEvent ):void
		{
			dispatchEvent( event );
		}
		
		public function dispatchResumeEvent( event:TweenResumeEvent ):void
		{
			dispatchEvent( event );
		}
		
		public function dispatchUpdateEvent( event:TweenUpdateEvent ):void
		{
			dispatchEvent( event );
		}
		
		public function dispatchEndEvent( event:TweenEndEvent ):void
		{
			dispatchEvent( event );
		}
		
		public function dispatchCompleteEvent( event:TweenCompleteEvent ):void
		{
			dispatchEvent( event );
		}
		
		public function dispatchCollectionCompleteEvent(
			event:TweenCollectionCompleteEvent ):void
		{
			dispatchEvent( event );
		}
		
		/*
		*	ITweenValueFormatter implementation.
		*/
		override public function set formatter( val:ITweenValueFormatter ):void
		{
			super.formatter = val;
			applyPropertyToTargets( "formatter", val );
		}
		
		/*
		*	ITweenUpdater implementation.
		*/
		override public function set updater( val:ITweenUpdater ):void
		{
			super.updater = val;
			applyPropertyToTargets( "updater", val );
		}		
		
		override public function set loops( val:int ):void
		{
			super.loops = val;
			applyPropertyToTargets( "loops", val );
		}
		
		override public function set delay( val:Number ):void
		{
			super.delay = val;
			applyPropertyToTargets( "delay", val );
		}
		
		override public function initialize():void
		{
			applyMethodToTargets( "initialize", [] );
		}
		
		/*
		*	Utility methods.
		*/
		protected function removeAllProxyListeners():void
		{
			var i:int = 0;
			var l:int = targets.length;
			
 			for( ;i < l;i++ )
			{
				removeProxyListeners( targets[ i ] as IEventDispatcher );
			}
		}
		
		protected function applyMethodToTargets( name:Object, args:Array ):void
		{
			var i:int = 0;
			var l:int = this.targets.length;
			
			var target:ITween;
			
			var methodName:String = name.toString();
			
			for( ;i < l;i++ )
			{
				target = this.targets[ i ];
				target[ methodName ].apply( null, args );
			}
		}
		
		protected function applyPropertyToTargets( name:Object, value:Object ):void
		{
			var i:int = 0;
			var l:int = this.targets.length;
			
			var target:ITween;
			
			var propertyName:String = name.toString();
			
			for( ;i < l;i++ )
			{
				target = this.targets[ i ];
				target[ propertyName ] = value;
			}
		}

	}
	
}