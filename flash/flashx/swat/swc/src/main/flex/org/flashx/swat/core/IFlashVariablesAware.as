package org.flashx.swat.core
{
	
	import org.flashx.core.IFlashVariables;
	
	/**
	*	Describes the contract for implementation that are aware
	* 	of the application flash variables.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IFlashVariablesAware
	{
		/**
		* 	The flash variables instantiated when the application
		* 	was started.
		*/
		function get flashvars():IFlashVariables;
		function set flashvars( flashvars:IFlashVariables ):void;
	}
}