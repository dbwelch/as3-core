package org.flashx.effects.tween {

	import flash.events.IEventDispatcher;
	
	public interface ITween
		extends IEventDispatcher,
				IDefaultEasing,
				ITweenParameters,
				ITweenStatus,
				ITweenControl,
				ITweenParent,
				ITweenTarget,
				ITweenReverse,
				ITweenSpeed,
				ITweenClone
	{
		function get parameters():ITweenParameters;
		function set parameters( value:ITweenParameters ):void;
		
		function set formatter( val:ITweenValueFormatter ):void;
		function get formatter():ITweenValueFormatter;
		
		function set updater( val:ITweenUpdater ):void;
		function get updater():ITweenUpdater;
		
		/**
		*	Initialize all the target's properties to the start values for
		* 	the tween.
		*/
		function initialize():void;
	}
}