package com.ffsys.ui.display
{
	
	/**
	*	Describes the contract for display object timeout
	* 	targets that want to control the hiding of the display
	* 	object this allows timeout targets to perform an animation
	* 	or other function before they are removed from the display
	* 	list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2010
	*/
	public interface IDisplayObjectTimeoutHide
	{
		/**
		* 	Invoked to inform the target display object
		* 	that the timeout is complete and the target should
		* 	hide itself.
		* 
		* 	Once the hide process is complete the target display
		* 	object should invoke the finished method on the timeout
		* 	implementation so that it is removed from the display list
		* 	and the timeout implementation cleans up all references and
		* 	events.
		*/
		function hide():void;
	}
}