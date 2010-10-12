package com.ffsys.effects.tween {
	
	/**
	*	Describes the contract for ITween instances
	*	that can be controlled - start/stop etc.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public interface ITweenControl {
		function start( trigger:Boolean = false ):void;
		function stop():void;
		function pause():void;
		function resume():void;
		function toggle():void;
		function finish( original:Boolean = false ):void;
	}
	
}
