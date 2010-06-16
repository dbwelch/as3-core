package com.ffsys.ui.components.display.loaders
{
	import com.ffsys.io.loaders.core.ILoader;

	public interface ILoaderComponent
	{
		/**
		*	The URI to load the runtime asset from.
		*/
		function get uri():String;
		function set uri( uri:String ):void;
		
		/**
		* 	Determines whether the load process has been deferred
		* 	until the load method is manually invoked.
		*/
		function get deferred():Boolean;
		function set deferred( deferred:Boolean ):void;
		
		/**
		* 	Gets the loader used to load the runtime asset.
		*/
		function get loader():ILoader;
		
		/**
		* 	Starts the load process.
		* 
		* 	By default the load process will start when the loader
		* 	is added to the display list unless it is configured to
		* 	be deferred in which case the load process does not start
		* 	until this method is invoked.
		*/
		function load():void;
	}
}