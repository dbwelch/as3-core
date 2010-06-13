package com.ffsys.swat.configuration
{
	/**
	*	Describes the contract for instances that provide class
	* 	path information used when the application boots.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public interface IClassPathConfiguration
	{
		/**
		* 	Gets the class path to the main application class.
		* 
		* 	@return The main application class path.
		*/
		function getMainClassPath():String;
		
		/**
		* 	Gets the class path to the flash variables class.
		* 
		* 	@return The flash variables class path.
		*/
		function getFlashVariablesClassPath():String;
		
		/**
		* 	Gets the class path to the view used during the application preload process.
		* 
		* 	@return The application preload view class path.
		*/
		function getPreloadViewClassPath():String;
	}
}