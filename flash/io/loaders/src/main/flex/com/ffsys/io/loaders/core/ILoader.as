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
				ILoaderParameters,
				IResourceCallback,
				ILoadStatus,
				IForceLoad {
			
		/**
		*	The load message associated with the loader.
		*/
		function get message():ILoadMessage;
		function set message( message:ILoadMessage ):void;
					
		/*
		*	We can't implement IBytesTotal/IBytesLoaded
		*	as URLLoader declares bytesLoaded/bytesTotal
		*	public variables.	
		*/
		
		/**
		*	The number of bytes currently loaded.
		*	
		*	@return The number of bytes loaded.
		*/
		function getBytesLoaded():uint;
		
		/**
		*	The total number of bytes for this
		*	load operation.
		*	
		*	@return The total number of bytes for
		*	this load operation.
		*/
		function getBytesTotal():uint;
	
		/**
		*	Starts a load operation on this
		*	<code>ILoader</code>.
		*	
		*	@param request The <code>URLRequest</code>
		*	to load the resource from.
		*/
		function load( request:URLRequest ):void;
		
		/**
		*	@deprecate
		*/
		function addResponderListeners(
			target:IEventDispatcher,
			startMethod:Function = null,
			progressMethod:Function = null,
			loadedMethod:Function = null,
			resourceNotFoundMethod:Function = null ):void;
		
		/**
		*	@deprecate	
		*/		
		function removeResponderListeners(
			target:IEventDispatcher,
			startMethod:Function = null,
			progressMethod:Function = null,			
			loadedMethod:Function = null,
			resourceNotFoundMethod:Function = null ):void;		
	}	
}