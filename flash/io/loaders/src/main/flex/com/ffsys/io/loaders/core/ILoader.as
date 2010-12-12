package com.ffsys.io.loaders.core {

	import flash.net.URLRequest;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.loaders.message.ILoadMessage;
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
		*	A load message associated with the loader.
		*/
		function get message():ILoadMessage;
		function set message( message:ILoadMessage ):void;
		
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