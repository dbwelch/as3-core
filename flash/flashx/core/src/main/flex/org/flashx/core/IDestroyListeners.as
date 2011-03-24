package org.flashx.core {
	
	/**
	*	Describes the contract for instances that clean
	*	up all registered listeners.
	*	
	*	This allows the instance to become eligible for
	*	garbage collection provided there are no other
	*	references to the instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.12.2007
	*/
	public interface IDestroyListeners {
		
		/**
		*	Destroy all listeners for this instance.	
		*/
		function destroyListeners():void;
	}
}