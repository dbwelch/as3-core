package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.resources.IResourceElement;
	
	/**
	*	Common type for all load events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.07.2007
	*/
	public interface ILoadEvent {
		function set triggerEvent( val:Event ):void;
		function get triggerEvent():Event;
		function set loader( val:ILoader ):void;
		function get loader():ILoader;
		
		function get request():URLRequest;
		function get uri():String;
		function get id():String;
		
		function set resource( val:IResourceElement ):void;
		function get resource():IResourceElement;
		
	}
	
}
