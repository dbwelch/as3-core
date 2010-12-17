package com.ffsys.swat.core {
	
	import flash.events.IEventDispatcher;
	
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.view.IApplicationPreloadView;
	import com.ffsys.swat.view.IApplicationPreloader;
	
	/**
	*	Describes the contract for bootstrap loaders.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.06.2010
	*/
	public interface IBootstrapLoader
		extends IResourceLoader {
		
		/**
		* 	The application preload view.
		*/
		function get view():IApplicationPreloadView;
		function set view( view:IApplicationPreloadView ):void;
		
		/**
		* 	The main application preloader.
		*/
		function get main():IApplicationPreloader;
		function set main( main:IApplicationPreloader ):void;
		
		/**
		* 	Gets the application configuration.
		*/
		function get configuration():IConfiguration;
	}
}