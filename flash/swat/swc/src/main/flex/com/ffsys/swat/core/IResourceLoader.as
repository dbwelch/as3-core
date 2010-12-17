package com.ffsys.swat.core {
	
	import flash.events.IEventDispatcher;
	
	/**
	*	Describes the contract for resource loaders.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2010
	*/
	public interface IResourceLoader
		extends IEventDispatcher {
		
		/**
		*	The current preload phase being loaded.
		*/
		function get phase():String;
		
		/**
		*	Starts a load operation.
		*/
		function load():void;
	}
}