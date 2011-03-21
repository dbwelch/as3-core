package org.flashx.ui.display
{
	
	/**
	*	Describes the contract for display object timeout
	* 	targets that want to control the showing of the display
	* 	object this allows timeout targets to perform an animation
	* 	or other function before the timeout starts.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2010
	*/
	public interface IDisplayObjectTimeoutShow
	{
		/**
		* 	Invoked to inform the target display object
		* 	that the timeout is starting and the target can
		* 	perform an animation before it should invoke the
		* 	shown method on the timeout implementation to start
		* 	the timeout process.
		*/
		function show():void;
	}
}