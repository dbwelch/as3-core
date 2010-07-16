package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.resources.IResourceElement;
	
	/**
	*	Describes the contract for load events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.07.2007
	*/
	public interface ILoadEvent {
		
		/**
		*	An event that triggered this event.	
		*/
		function set triggerEvent( val:Event ):void;
		function get triggerEvent():Event;
		
		/**
		*	A loader implementation associated with this event.	
		*/
		function set loader( val:ILoader ):void;
		function get loader():ILoader;
		
		/**
		*	The request that started the load operation.
		*/
		function get request():URLRequest;
		
		/**
		*	The URI that was requested to start the load operation.	
		*/
		function get uri():String;
		
		/**
		*	The identifier of the loader.	
		*/
		function get id():String;
		
		/**
		*	A resource associated with this event.	
		*/
		function set resource( val:IResourceElement ):void;
		function get resource():IResourceElement;
		
		/**
		*	The total number of bytes loaded.	
		*/
		function get bytesLoaded():uint;
		
		/**
		*	The total number of bytes.	
		*/
		function get bytesTotal():uint;
	}
}