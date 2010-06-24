package com.ffsys.ui.loaders
{
	/**
	*	Describes the contract for loader component preloaders.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.06.2010
	*/
	public interface IPreloader
	{
		/**
		* 	Invoked when the loading process starts.
		*/
		function started():void;
		
		/**
		* 	Invoked when a error occurs during the load process.
		*/
		function error():void;
		
		/**
		* 	Invoked when an individual item starts loading.
		*/
		function start():void;
		
		/**
		*	Invoked while a runtime resource is loading.
		* 
		* 	@param bytesLoaded The number of bytes loaded.
		* 	@param bytesTotal The total number of bytes for the file.
		*/
		function progress( bytesLoaded:uint, bytesTotal:uint ):void;
		
		/**
		* 	Invoked when a runtime resource has completed loading.
		* 
		* 	@param data The data encapsulating the loaded resource.
		*/
		function loaded( data:Object ):void;
		
		/**
		* 	Invoked when all runtime resources have been loaded.
		*/
		function completed():void;
		
		/**
		* 	Invoked to inform the preloader that the loaded component
		* 	has been destroyed.
		*/
		function destroyed():void;
	}
}