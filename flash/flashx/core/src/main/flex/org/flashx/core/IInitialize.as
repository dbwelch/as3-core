package org.flashx.core {
	
	/**
	*	Describes the contract for instances that provide
	*	a public initialization method.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.12.2007
	*/
	public interface IInitialize {
		
		/**
		*	Performs initialization routines for this
		*	instance.
		*/
		function initialize():void;
	}
}