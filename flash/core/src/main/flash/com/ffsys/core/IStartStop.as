package com.ffsys.core {
	
	/**
	*	Describes the contract for instances that
	*	provide methods for starting and stopping
	*	events that occur over time.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.12.2007
	*/
	public interface IStartStop {
		
		/**
		*	Starts this instance.	
		*/
		function start():void;
		
		/**
		*	Stops this instance.
		*/
		function stop():void;
	}
	
}
