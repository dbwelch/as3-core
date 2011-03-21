package org.flashx.ui.display
{
	import flash.display.DisplayObject;
	
	import org.flashx.core.IDestroy;
	import org.flashx.core.IStartStop;

	/**
	*	Describes the contract for implementations that wait
	* 	a specified number of milliseconds before removing a 
	* 	target display object from the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2010
	*/
	public interface IDisplayObjectTimeout
		extends IStartStop,
				IDestroy
	{
		/**
		* 	The target display object to be removed when
		* 	the timeout expires.
		*/
		function get target():DisplayObject;
		function set target( target:DisplayObject ):void;
		
		/**
		* 	The timeout in milliseconds before the target display object
		* 	is removed from the display list and destroyed.
		*/
		function get timeout():Number;
		function set timeout( timeout:Number ):void;
		
		/**
		* 	Invoked to inform this instance that the timeout has
		* 	been completed.
		*/
		function hidden():void;
		
		/**
		* 	Invoked to inform this instance that the timeout should
		* 	start.
		*/
		function shown():void;
	}
}