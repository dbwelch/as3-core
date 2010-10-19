package com.ffsys.swat.configuration
{
	import flash.display.DisplayObject;
	
	import com.ffsys.core.IFlashVariables;
	import com.ffsys.swat.core.SwatFlashVariables;
	import com.ffsys.swat.view.IApplication;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
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
		
		/**
		* 	Gets the class path to the main application view.
		* 
		* 	@return The main application view class path.
		*/
		function getMainViewClassPath():String;
		
		/**
		* 	Gets the class path to the configuration parser.
		* 
		* 	@return The configuration parser class path.
		*/
		function getConfigurationParserClassPath():String;	
		
		/**
		* 	Gets the class path to the configuration.
		* 
		* 	@return The configuration class path.
		*/
		function getConfigurationClassPath():String;
		
		/**
		* 	Gets the main application class instance.
		*	
		*	@return The main application instance.
		*/
		function getMainClassInstance():IApplication;
		
		/**
		*	Gets the application preload view instance.
		*	
		*	@return The application preload view instance.
		*/
		function getApplicationPreloadViewInstance():IApplicationPreloadView;
		
		/**
		*	Gets the flash variables instance.
		*	
		*	@return The flash variables instance.
		*/
		function getFlashVariablesInstance( root:DisplayObject ):IFlashVariables;
		
		/**
		*	Gets the main view instance.
		*	
		*	@return The main view instance.
		*/
		function getMainViewInstance():DisplayObject;
		
		/**
		*	Gets the parser used to deserialize the configuration
		*	data.
		*	
		*	@return The configuration parser instance.
		*/
		function getConfigurationParserInstance():IConfigurationParser;
		
		/**
		* 	Gets an instance of the application configuration.
		*	
		*	@return The application configuration.
		*/
		function getConfigurationInstance():IConfiguration;
	}
}