package com.ffsys.effects.tween {
	
	/**
	*	Describes the contract for Objects that
	*	control the setting of the property themselves
	*	this is useful if a method needs to be invoked
	*	rather than a property set.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.08.2007
	*/
	public interface ITweenUpdater {
		
		/**
		*	Determines whether all values should be
		*	applied to the property. If this is false
		*	no properties will be set and non of the subsequent
		*	methods will fire.
		*
		*	@return a Boolean indicating whether any properties should be set
		*/
		function shouldApplyTweenValues( properties:Array, values:Array ):Boolean;
		
		/**
		*	Determines whether an individual property should be set.
		*/
		
		//TODO: add the target parameter so that implemetors can test whether
		//the target has the given property
		function shouldApplyTweenValue( property:String, value:Object ):Boolean;
		
		function applyTweenValue( target:Object, property:String, value:Object ):void;
		
	}
	
}
