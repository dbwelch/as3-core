package com.ffsys.swat.core {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.view.IApplicationPreloadView;
	
	/**
	*	Describes the contract for the runtime asset preloader.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.06.2010
	*/
	public interface IRuntimeAssetPreloader
		extends IEventDispatcher {
		
		function get view():IApplicationPreloadView;
			
		function set view( view:IApplicationPreloadView ):void;
		
		/**
		* 	Gets the runtime configuration.
		* 
		* 	@return The runtime configuration.
		*/
		function get configuration():IConfiguration;
		
		function get phase():String;
		
		/**
		*	Starts the preloading process.
		*/
		function load():void;
	}
}