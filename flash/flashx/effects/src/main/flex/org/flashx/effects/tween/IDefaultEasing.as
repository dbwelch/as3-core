package org.flashx.effects.tween {
	
	/*
	*	Describes the contract for instances that provide a
	*	default easing method.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.08.2007
	*/
	public interface IDefaultEasing {

		/**
		* 	Gets the default function used to perform easing.
		*/
		function getDefaultEasing():Function;
	}
}