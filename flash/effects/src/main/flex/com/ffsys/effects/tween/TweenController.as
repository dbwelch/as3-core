package com.ffsys.effects.tween {
	
	import com.ffsys.effects.events.TweenEvent;
	
	/**
	*	Class for managing all tween instances currently in effect.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.08.2007
	*/
	public class TweenController extends AbstractTweenCollection {
		
		static private const COMPLETE:String = "dispatchCompleteEvent";
		
		static private const REFRESH_RATE:String = "refreshRate";
		static private const FRAME_RATE:String = "frameRate";
		
		public function TweenController()
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
			applyMethodToTargets( TweenController.COMPLETE, [] );
		}
		
	}
	
}
