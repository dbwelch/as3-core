package com.ffsys.effects.tween {
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.IObjectInspector;
	/* END OBJECT_INSPECTOR REMOVAL */
	
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
		extends ITweenSpeed,
		 		IObjectInspector {	

		function get values():Array;
		
		function set properties( properties:Array ):void;
		function get properties():Array;
		
		function set easing( val:Array ):void;
		function get easing():Array;
		
		function set endValues( val:Array ):void;
		function get endValues():Array;
		
		function set duration( duration:Number ):void;
		function get duration():Number;
		
		function set delay( delay:Number ):void;
		function get delay():Number;
		
		function set startValues( val:Array ):void;
		function get startValues():Array;
		
		function set loops( val:int ):void;
		function get loops():int;
		
		function set originalStartValues( val:Array ):void;
		function get originalStartValues():Array;
		
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
