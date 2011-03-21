package org.flashx.ui.loaders
{
	/**
	*	Describes the contract for objects that are aware 
	* 	of a loader component.
	* 
	* 	Typically this might be a preloader implementation
	* 	that needs to know about the loader it is responding to.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.06.2010
	*/
	public interface ILoaderComponentAware
	{
		/**
		* 	The loader component associated with this
		* 	instance.
		*/
		function get loader():ILoaderComponent;
		function set loader( loader:ILoaderComponent ):void;
	}
}