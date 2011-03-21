package org.flashx.ui.core
{
	import flash.display.Stage;
	
	/**
	*	Describes the contract for components
	* 	that receive a reference to the stage
	* 	before they are added to the display list.
	* 
	* 	The <code>stage</code> setter method will
	* 	be invoked after bean type injection is complete.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.01.2011
	*/
	public interface IStageAware
	{
		/**
		* 	Sets the stage reference.
		*/
		function set stage( stage:Stage ):void;
	}
}