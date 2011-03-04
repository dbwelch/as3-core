package com.ffsys.effects.tween {
	
	/**
	*	Represents the available properties that constitute
	*	ITween parameters.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.08.2007
	*/
	public interface ITweenParameters
		extends ITweenSpeed {	
		
		/**
		* 	The current set of values.
		*/
		function get values():Array;
		
		/**
		* 	The properties this tween is operating on.
		*/
		function set properties( properties:Array ):void;
		function get properties():Array;
		
		/**
		* 	The easing equations to use for each tween.
		*/
		function set easing( val:Array ):void;
		function get easing():Array;
		
		/**
		* 	The end values for each target property.
		*/
		function set endValues( val:Array ):void;
		function get endValues():Array;
		
		/**
		* 	The duration of the tween.
		*/
		function set duration( duration:Number ):void;
		function get duration():Number;
		
		/**
		* 	An initial delay before starting the tween.
		*/
		function set delay( delay:Number ):void;
		function get delay():Number;
		
		/**
		* 	The values to start tweening from.
		*/
		function set startValues( val:Array ):void;
		function get startValues():Array;
		
		/**
		* 	The number of times to loop the tween.
		*/
		function set loops( val:int ):void;
		function get loops():int;
		
		/**
		* 	The original start values.
		*/
		function set originalStartValues( val:Array ):void;
		function get originalStartValues():Array;
		
		/**
		* 	The original end values.
		*/
		function set originalEndValues( val:Array ):void;
		function get originalEndValues():Array;
		
		
		function getParameters():Object;
		
		/**
		*	Sets all tween properties to the orginal start values.
		*/		
		function applyOriginalStartValues():void;
		
		/**
		*	Sets all tween properties to the original end values.
		*/		
		function applyOriginalEndValues():void;
		
		/**
		*	Sets all tween properties to the current start values.
		*/
		function applyStartValues():void;
		
		/**
		*	Sets all tween properties to the current end values.
		*/
		function applyEndValues():void;		
		
		/**
		*	Applies an Array of values to all the properties of the target
		*	Object.
		*/
		function applyValues( values:Array, target:Object = null ):void;
	}
}