package com.ffsys.io.loaders.core {

	import flash.net.URLRequest;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.loaders.resources.IResourceCallback;
	
	/**
	*	Defines the contract for instances that
	*	load external resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public interface ILoader
		extends ILoaderElement,
				IResourceCallback {
		
		/**
		*	The <code>URLRequest</code> used to load
		*	the resource.
		*/
		function set request( value:URLRequest ):void;
		function get request():URLRequest;
	
		/**
		*	The uniform resource indicator used to
		*	load the resource.
		*/
		function set uri( value:String ):void;
		function get uri():String;
	}
}