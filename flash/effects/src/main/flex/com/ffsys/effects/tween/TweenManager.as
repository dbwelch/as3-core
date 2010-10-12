package com.ffsys.effects.tween {
	
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
	public class TweenManager extends Object {
		
		static private var _controller:TweenController = new TweenController();
		
		/**
		*	@private
		*/
		public function TweenManager()
		{
			super();
			throw new Error( "TweenManager cannot be instantiated, static method access only." );
		}
		
		/*
		*	ITweenControl implementation.
		*
		*	Strictly speaking this is not an implementation as these
		*	are all static methods, yet this is considered an ITweenControl
		*	implementation.
		*/
		static public function start( trigger:Boolean = false ):void
		{
			_controller.start( trigger );
		}
		
		static public function stop():void
		{
			_controller.stop();
		}
		
		static public function pause():void
		{
			_controller.pause();
		}
		
		static public function resume():void
		{
			_controller.resume();
		}
		
		static public function finish( original:Boolean = false ):void
		{
			_controller.finish( original );
		}
		
		static public function complete():void
		{
			_controller.complete = true;
		}
		
		/*
		*	ITweenSpeed implementation.
		*/
		static public function setRefreshRate( value:int ):void
		{
			_controller.refreshRate = value;
		}
		
		static public function setFrameRate( value:int ):void
		{
			_controller.frameRate = value;
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
			return _controller.addTween( tween );
		}
		
		/**
		*	Removes an ITween from the manager.
		*
		*	@param tween the ITween to remove 
		*/
		static public function removeTween( tween:ITween ):Boolean
		{
			return _controller.removeTween( tween );
		}
		
	}
	
}
