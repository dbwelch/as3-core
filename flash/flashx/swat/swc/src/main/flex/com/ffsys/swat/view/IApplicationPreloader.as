package com.ffsys.swat.view {
	
	import com.ffsys.swat.configuration.IClassPathConfiguration;
	
	/**
	*	Describes the contract for the top level display
	*	object that handles the start of the preload process.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public interface IApplicationPreloader {
		
		/**
		*	The class path configuration for the application.
		*/
		function get classes():IClassPathConfiguration;
		
		/**
		* 	An array of classes that are created at runtime
		* 	using reflection.
		*/
		function getRuntimeClasses():Array;
	}
}