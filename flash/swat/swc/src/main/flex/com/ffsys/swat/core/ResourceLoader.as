package com.ffsys.swat.core {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	import com.ffsys.io.loaders.types.*;	
	
	import com.ffsys.io.xml.IParser;

	import com.ffsys.swat.configuration.IConfigurationElement;	
	import com.ffsys.swat.configuration.rsls.IResourceQueueBuilder;
	import com.ffsys.swat.events.RslEvent;
	
	/**
	*	Preloads runtime resources by type.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class ResourceLoader extends EventDispatcher
		implements IResourceLoader {

		private var _parser:IParser;
		private var _request:URLRequest;
		private var _configuration:IConfigurationElement;		
		private var _configurationLoader:ParserAwareXmlLoader;
		private var _builder:IResourceQueueBuilder;
		private var _phases:Array = ResourceLoadPhase.defaults;
		
		private var _resources:IResourceManager;
		
		/**
		* 	@private
		*/
		protected var _assets:ILoaderQueue;
		
		/**
		* 	@private
		*/
		protected var _phase:String = ResourceLoadPhase.CODE_PHASE;
		
		/**
		*	Creates a <code>ResourceLoader</code> instance.
		* 
		* 	@param request The url request to load the configuration document from.
		*	@param parser A parser implementation to use when parsing the
		*	configuration document.
		*/
		public function ResourceLoader(
			request:URLRequest,
			parser:IParser)
		{
			super();
			this.request = request;
			this.parser = parser;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get resources():IResourceManager
		{
			return _resources;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfigurationElement
		{
			return _configuration;
		}
		
		public function set configuration( value:IConfigurationElement ):void
		{
			_configuration = value;
		}
		
		/**
		* 	A url request to load the configuration document from.
		*/
		public function get request():URLRequest
		{
			return _request;
		}
		
		public function set request( value:URLRequest ):void
		{
			_request = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get parser():IParser
		{
			return _parser;
		}
		
		public function set parser( value:IParser ):void
		{
			_parser = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get builder():IResourceQueueBuilder
		{
			return _builder;
		}
		
		public function set builder( value:IResourceQueueBuilder ):void
		{
			_builder = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get phases():Array
		{
			return _phases;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get phase():String
		{
			return _phase;
		}
		
		protected function getMainLoaderQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			_resources = new ResourceManager(
				IResourceList( queue.resource ) );
			return queue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function load():ILoaderQueue
		{
			if( this.parser == null )
			{
				throw new Error( "Cannot load resurces with a null configuration parser." );
			}
			
			if( this.request == null )
			{
				throw new Error( "Cannot load resurces with a null url request." );
			}			
			
			_assets = getMainLoaderQueue();
			
			var configurationQueue:ILoaderQueue = new LoaderQueue();
			configurationQueue.customData = ResourceLoadPhase.CONFIGURATION_PHASE;
			configurationQueue.resource.id = ResourceLoadPhase.CONFIGURATION_PHASE;
			_phase = ResourceLoadPhase.CONFIGURATION_PHASE;
			_configurationLoader = new ParserAwareXmlLoader();
			_configurationLoader.request = this.request;
			_configurationLoader.parser = this.parser;
			addConfigurationListeners( _configurationLoader );
			doWithConfigurationLoader( _configurationLoader );
			configurationQueue.addLoader( _configurationLoader );
			_assets.addLoader( configurationQueue );
			_assets.load();
			return _assets;
		}
		
		/**
		* 	Allows sub classes to perform operations on the configuration
		* 	document loader.
		* 
		* 	@param loader The configuration document loader.
		*/
		protected function doWithConfigurationLoader( loader:ParserAwareXmlLoader ):void
		{
			//
		}
		
		/**
		* 	Adds configuration document load listeners.
		* 
		* 	@param loader The event dispatcher.
		*/
		protected function addConfigurationListeners( loader:IEventDispatcher ):void
		{
			if( loader != null )
			{
				
				loader.addEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound, false, 0, false );

				loader.addEventListener(
					LoadEvent.LOAD_START,
					loadStart, false, 0, false );

				loader.addEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress, false, 0, false );

				loader.addEventListener(
					LoadEvent.DATA,
					configurationLoadComplete, false, 0, false );				
			}
		}
		
		/**
		* 	Removes configuration document load listeners.
		* 
		* 	@param loader The event dispatcher.
		*/
		protected function removeConfigurationListeners( loader:IEventDispatcher ):void
		{
			if( loader != null )
			{			
				loader.removeEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );
			
				loader.removeEventListener(
					LoadEvent.LOAD_START,
					loadStart );
				
				loader.removeEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );
			
				loader.removeEventListener(
					LoadEvent.DATA,
					configurationLoadComplete );				
			}
		}		
		
		/**
		*	Invoked when the configuration document has been loaded.
		* 
		* 	@param event The load event.
		*/
		protected function configurationLoadComplete( 
			event:LoadEvent ):void
		{
			removeConfigurationListeners( _configurationLoader );
			
			var targets:ILoaderQueue = getLoaderQueue( this.builder );
			var queue:ILoaderQueue = null;
			for( var i:int = 0;i < targets.length;i++ )
			{
				queue = ILoaderQueue( targets.getLoaderAt( i ) );
				if( !queue.isEmpty() )
				{
					_assets.addLoader( queue );
				}
			}

			addQueueListeners( _assets, loadComplete );
		}
		
		/**
		* 	@private
		*/
		protected function getLoaderQueue( builder:IResourceQueueBuilder ):ILoaderQueue
		{
			if( builder == null )
			{
				throw new Error(
					"Cannot get a loader queue with a null resource queue builder." );
			}
			
			var output:ILoaderQueue = new LoaderQueue();
			var queue:ILoaderQueue = null;
			var phase:String = null;
			for( var i:int = 0;i < this.phases.length;i++ )
			{
				phase = this.phases[ i ];
				queue = builder.getQueueByPhase( phase );
				if( queue && !queue.isEmpty() )
				{
					queue.customData = phase;
					output.addLoader( queue );
				}
			}
			return output;
		}
		
		/**
		*	@private	
		*/
		protected function addQueueListeners( queue:ILoaderQueue, complete:Function ):void
		{
			if( queue != null )
			{
				queue.addEventListener(
					LoadEvent.QUEUE_START,
					queueStart );
				
				queue.addEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );
				
				queue.addEventListener(
					LoadEvent.LOAD_START,
					loadStart );
			
				queue.addEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );
			
				queue.addEventListener(
					LoadEvent.DATA,
					itemLoaded );
				
				queue.addEventListener(
					LoadEvent.LOAD_COMPLETE,
					complete );
			}
		}
		
		/**
		*	@private
		*/
		protected function removeQueueListeners( queue:ILoaderQueue, complete:Function ):void
		{
			if( queue != null )
			{
				queue.removeEventListener(
					LoadEvent.QUEUE_START,
					queueStart );
				
				queue.removeEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );
			
				queue.removeEventListener(
					LoadEvent.LOAD_START,
					loadStart );
			
				queue.removeEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );
				
				queue.removeEventListener(
					LoadEvent.DATA,
					itemLoaded );
				
				queue.removeEventListener(
					LoadEvent.LOAD_COMPLETE,
					complete );
			}
		}
		
		/**
		*	@private
		*/
		protected function queueStart(
			event:LoadEvent ):RslEvent
		{	
			var evt:RslEvent = new RslEvent(
				RslEvent.PHASE_START,
				this,
				event );
				
			_phase = String( event.loader.customData );
			
			var list:IResourceList = IResourceList( ILoaderQueue( event.loader ).resource );
			list.id = this.phase;
			
			dispatchEvent( evt );
			return evt;
		}
		
		/**
		*	@private
		*/
		protected function resourceNotFound(
			event:LoadEvent ):RslEvent
		{	
			var evt:RslEvent = new RslEvent(
				RslEvent.RESOURCE_NOT_FOUND,
				this,
				event );
			dispatchEvent( evt );
			return evt;
		}
		
		/**
		*	@private
		*/
		protected function loadStart( event:LoadEvent ):RslEvent
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_START,
				this,
				event );
			evt.bytesLoaded = event.loader.bytesLoaded;
			evt.bytesTotal = event.loader.bytesTotal;					
			dispatchEvent( evt );
			return evt;				
		}
		
		/**
		*	@private
		*/
		protected function loadProgress( 
			event:LoadEvent ):RslEvent
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_PROGRESS,
				this,
				event );
			//evt.bytesLoaded = event.bytesLoaded;
			//evt.bytesTotal = event.bytesTotal;
			
			
			evt.bytesLoaded = event.loader.bytesLoaded;
			evt.bytesTotal = event.loader.bytesTotal;			
			
			dispatchEvent( evt );
			return evt;			
		}	
		
		/**
		*	@private
		*/
		protected function itemLoaded( event:LoadEvent ):RslEvent
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOADED,
				this,
				event );
			evt.bytesLoaded = event.loader.bytesLoaded;
			evt.bytesTotal = event.loader.bytesTotal;				
			dispatchEvent( evt );
			return evt;
		}
		
		/**
		*	@private
		*/
		protected function loadComplete( event:LoadEvent ):RslEvent
		{
			var evt:RslEvent = new RslEvent(
				RslEvent.LOAD_COMPLETE,
				this );	
			removeQueueListeners( _assets, loadComplete );
			_phase = ResourceLoadPhase.COMPLETE_PHASE;
			dispatchEvent( evt );
			
			/*
			//ensure the resources property is set
			trace("ResourceLoader::loadComplete()", "GET RESOURCES REFERENCE: ",
				this.resources,
				this.resources.length );
				
			var resource:IResourceElement = null;
			for( var i:int = 0;i < this.resources.length;i++ )
			{
				resource = this.resources.getResourceAt( i );
				trace("ResourceLoader::loadComplete()", resource, resource.id );
				
				if( resource is IResourceList )
				{
					trace("ResourceLoader::loadComplete() GOT COMPOSITE LIST: ", IResourceList( resource ).length );
				}
			}
			*/
			
			//clean up the queue now we have the resources
			_assets.destroy();
			return evt;
		}
		
		/**
		* 	Closes any open connections and cleans composite references.
		*/
		public function destroy():void
		{
			if( _configurationLoader )
			{
				_configurationLoader.destroy();
			}
			if( _assets )
			{
				_assets.destroy();
			}
			_parser = null;
			_request = null;
			_resources = null;
			_configuration = null;
			_configurationLoader = null;
			_assets = null;
			_phase = null;
			_phases = null;
			_builder = null;
		}
	}
}