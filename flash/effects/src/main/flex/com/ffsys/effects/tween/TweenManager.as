package com.ffsys.effects.tween {
	
	import com.ffsys.effects.events.*;
	
	/**
	*	Global class for managing all tween instances
	*	currently in effect.
	*
	*	All methods of this Class are static and this Class
	*	should not be instantiated directly.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class TweenManager extends AbstractTweenCollection {
		
		static private var _instance:TweenManager = new TweenManager();
		
		static private const COMPLETE:String = "dispatchCompleteEvent";
		static private const REFRESH_RATE:String = "refreshRate";
		static private const FRAME_RATE:String = "frameRate";		
		
		/**
		*	@private
		*/
		public function TweenManager()
		{
			super();
		}
		
		/*
		*	ITweenSpeed implementation.
		*/
		override public function set refreshRate( value:int ):void
		{
			applyPropertyToTargets( REFRESH_RATE, value );
		}
		
		override public function set frameRate( value:int ):void
		{
			applyPropertyToTargets( FRAME_RATE, value );
		}
		
		/*
		*	ITweenControl implementation.
		*/
		override public function start( trigger:Boolean = false ):void
		{
			applyMethodToTargets( TweenEvent.START, [ trigger ] );
		}
		
		override public function stop():void
		{
			applyMethodToTargets( TweenEvent.STOP, [] );
		}
		
		override public function pause():void
		{
			applyMethodToTargets( TweenEvent.PAUSE, [] );
		}
		
		override public function resume():void
		{
			applyMethodToTargets( TweenEvent.RESUME, [] );
		}
		
		override public function finish( original:Boolean = false ):void
		{
			applyMethodToTargets( TweenEvent.FINISH, [ original ] );
		}
		
		override public function set complete( val:Boolean ):void
		{
			applyMethodToTargets( COMPLETE, [] );
		}
		
		static public function get instance():TweenManager
		{
			if( !_instance )
			{
				_instance = new TweenManager();
			}
			return _instance;
		}
		
		/*
		*	ITweenCollectionList implementation.
		*/		
		
		/**
		*	Adds an ITween to the manager.
		*
		*	@param tween the ITween to add
		*/
		static public function addTween( tween:ITween ):int
		{
			return instance.addTween( tween );
		}
		
		/**
		*	Removes an ITween from the manager.
		*
		*	@param tween the ITween to remove 
		*/
		static public function removeTween( tween:ITween ):Boolean
		{
			return instance.removeTween( tween );
		}
	}
}