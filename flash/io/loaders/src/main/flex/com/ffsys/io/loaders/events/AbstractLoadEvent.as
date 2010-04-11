package com.ffsys.io.loaders.events {
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import com.ffsys.events.AbstractEvent;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	import com.ffsys.io.loaders.resources.IResourceElement;
	
	/**
	*	Abstract base class for all load related events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.07.2007
	*/
	public class AbstractLoadEvent extends AbstractEvent
		implements ILoadEvent {
		
		/**
		*	The ILoader instance that was handling the loading.
		*/
		private var _loader:ILoader;
		
		private var _resource:IResourceElement;
		
		public function AbstractLoadEvent(
			type:String,
			triggerEvent:Event,
			loader:ILoader )
		{
			super( type, triggerEvent );
			this.loader = loader;
		}
		
		public function set resource( val:IResourceElement ):void
		{
			_resource = val;
		}
		
		public function get resource():IResourceElement
		{
			return _resource;
		}		
		
		public function set loader( val:ILoader ):void
		{
			_loader = val;
		}
		
		public function get loader():ILoader
		{
			return _loader;
		}
		
		public function get request():URLRequest
		{
			if( _loader )
			{
				return _loader.request;
			}
			
			return null;
		}
		
		public function get uri():String
		{
			if( _loader )
			{
				return _loader.uri;
			}
			
			return null;
		}
		
		public function get id():String
		{
			if( _loader )
			{
				return _loader.id;
			}
			
			return null;
		}											
		
	}
	
}
