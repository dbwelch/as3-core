package com.ffsys.ui.loaders
{
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.ui.core.IComponent;

	public interface ILoaderComponent
	{
		/**
		* 	Gets the container that holds the loaded runtime asset.
		*/
		function get container():IComponent;
		
		/**
		*	The an array of URLs to load the runtime assets from.
		*/
		function get urls():Array;
		function set urls( urls:Array ):void;
		
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