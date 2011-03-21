package org.flashx.swat.core {
	
	import flash.events.IEventDispatcher;
	
	import org.flashx.swat.configuration.IConfiguration;
	import org.flashx.swat.view.IApplicationPreloadView;
	import org.flashx.swat.view.IApplicationPreloader;
	
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
	}
}