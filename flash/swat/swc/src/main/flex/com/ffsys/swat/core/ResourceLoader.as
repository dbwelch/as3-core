package com.ffsys.swat.core {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;

	import com.ffsys.ioc.BeanManager;
	import com.ffsys.ioc.IBeanManager;
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.ui.css.StyleManager;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	import com.ffsys.io.loaders.types.*;	
	
	import com.ffsys.io.xml.IParser;

	import com.ffsys.swat.configuration.IConfigurationElement;	
	import com.ffsys.swat.configuration.rsls.IResourceQueueBuilder;
	import com.ffsys.swat.events.RslEvent;
	
	import com.ffsys.utils.properties.IProperties;
	
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
			
		private var _styleManager:IStyleManager;
		private var _beanManager:IBeanManager;
		private var _parser:IParser;
		private var _request:URLRequest;
		private var _configuration:IConfigurationElement;		
		private var _configurationLoader:ParserAwareXmlLoader;
		private var _builder:IResourceQueueBuilder;
		private var _phases:Array = ResourceLoadPhase.defaults;
		private var _observers:Vector.<IResourceLoadObserver> = new Vector.<IResourceLoadObserver>();
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
		public function addObserver( observer:IResourceLoadObserver ):Boolean
		{
			if( observer != null )
			{
				_observers.push( observer );
				return true;
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeObserver( observer:IResourceLoadObserver ):Boolean
		{
			var index:int = _observers.indexOf( observer );
			if( index > -1 )
			{
				_observers.splice( index, 1 );
				return true;
			}
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get beanManager():IBeanManager
		{
			if( _beanManager == null )
			{
				_beanManager = new BeanManager();
			}
			return _beanManager;
		}
		
		public function set beanManager( value:IBeanManager ):void
		{
			_beanManager = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			if( _styleManager == null )
			{
				_styleManager = new StyleManager();
			}			
			return _styleManager;
		}
		
		public function set styleManager( value:IStyleManager ):void
		{
			_styleManager = value;
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
		
		/**
		* 	Gets the main loader queue used for the load process.
		* 
		* 	This allows sub classes to change the loader queue implementation
		* 	used for the load process.
		* 
		* 	@return The main loader queue.
		*/
		protected function getMainLoaderQueue():ILoaderQueue
		{
			var queue:ILoaderQueue = new LoaderQueue();
			_resources = new ResourceManager(
				IResourceList( queue.resource ), this.beanManager, this.styleManager );
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
			_configurationLoader = new ParserAwareXmlLoader();
			_configurationLoader.request = this.request;
			_configurationLoader.parser = this.parser;
			addConfigurationListeners( _configurationLoader );
			doWithConfigurationLoader( _configurationLoader );
			configurationQueue.addLoader( _configurationLoader );
			_assets.addLoader( configurationQueue );
			addQueueListeners( _assets, loadComplete );
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
			trace("ResourceLoader::addConfigurationListeners()");
			if( loader != null )
			{
				trace("ResourceLoader::addConfigurationListeners() GOT LOADER : ", loader );
				
				/*
				loader.addEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound, false, 0, false );

				loader.addEventListener(
					LoadEvent.LOAD_START,
					loadStart, false, 0, false );

				loader.addEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress, false, 0, false );
					*/
					
				loader.addEventListener(
					LoadEvent.DATA,
					configurationLoadComplete );				
			}
		}
		
		/**
		* 	Removes configuration document load listeners.
		* 
		* 	@param loader The event dispatcher.
		*/
		protected function removeConfigurationListeners( loader:IEventDispatcher ):void
		{
			trace("ResourceLoader::removeConfigurationListeners()", loader );
			if( loader != null )
			{			
				
				/*
				loader.removeEventListener(
					LoadEvent.RESOURCE_NOT_FOUND,
					resourceNotFound );
			
				loader.removeEventListener(
					LoadEvent.LOAD_START,
					loadStart );
				
				loader.removeEventListener(
					LoadEvent.LOAD_PROGRESS,
					loadProgress );
					*/
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
			trace("ResourceLoader::configurationLoadComplete()", event);
			
			removeConfigurationListeners( _configurationLoader );
			
			var targets:ILoaderQueue = getLoaderQueue( this.builder );
			var queue:ILoaderQueue = null;
			for( var i:int = 0;i < targets.length;i++ )
			{
				queue = ILoaderQueue( targets.getLoaderAt( i ) );
				if( !queue.isEmpty() )
				{
					trace("ResourceLoader::configurationLoadComplete()", "ADDING RESOURCE QUEUE", queue, queue.length );
					_assets.addLoader( queue );
				}
			}
			
			if( this.configuration != null )
			{
				//ensure the configuration knows about the loaded resources
				this.configuration.resources = this.resources;
			}
			
			trace("ResourceLoader::configurationLoadComplete()" , _assets.length, _assets.index );
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
			var j:int = 0;
			var properties:IProperties = null;
			for( var i:int = 0;i < this.phases.length;i++ )
			{
				properties = null;
				phase = this.phases[ i ];
				queue = builder.getQueueByPhase( phase, _beanManager, _styleManager );
				
				if( phase == ResourceLoadPhase.MESSAGES_PHASE )
				{
					properties = _resources.messages;
				}else if( phase == ResourceLoadPhase.ERRORS_PHASE )
				{
					properties = _resources.errors;
				}else if( phase == ResourceLoadPhase.SETTINGS_PHASE )
				{
					properties = _resources.settings;
				}
				
				if( queue && !queue.isEmpty() )
				{
					//inject a property reference
					if( properties != null )
					{
						for( j = 0;j < queue.length;j++ )
						{
							PropertiesLoader(
								queue.getLoaderAt( j ) ).properties = properties;
						}
					}
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
					LoadEvent.QUEUE_COMPLETE,
					queueComplete );
				
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
					LoadEvent.QUEUE_COMPLETE,
					queueComplete );					
				
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
		* 	Sets the current load phase and notifies observers
		* 	of the new phase.
		* 
		* 	@param phase The identifier for the load phase.
		* 	@param event A resource load event.
		*/
		protected function setPhase( phase:String, event:RslEvent = null ):void
		{
			if( phase != null )
			{
				_phase = phase;
				notifyObservers( [ event ], "phase" );
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
				
			var queueData:String = event.loader.customData as String;
			
			//don't allow nested queues with no custom data phase
			//to break the phase defined by a parent queue
			if( queueData != null )
			{
				setPhase( queueData, evt );
				
				//update the resource list identifier with the phase
				var list:IResourceList =
					IResourceList( ILoaderQueue( event.loader ).resource );
				list.id = this.phase;
			}
			
			dispatchEvent( evt );
			return evt;
		}
		
		/**
		*	@private
		*/
		protected function queueComplete(
			event:LoadEvent ):RslEvent
		{	
			var evt:RslEvent = new RslEvent(
				RslEvent.PHASE_COMPLETE,
				this,
				event );
			evt.bytesLoaded = event.loader.bytesLoaded;
			evt.bytesTotal = event.loader.bytesTotal;			
			notifyObservers( [ evt ], "complete" );
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
			
			//create missing resources in the resource manager
			_resources.missing.push(
				new ResourceNotFound( null, event.uri, event.bytesLoaded ) );
			
			notifyObservers( [ evt ] );
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
			notifyObservers( [ evt ] );	
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
			evt.bytesLoaded = event.loader.bytesLoaded;
			evt.bytesTotal = event.loader.bytesTotal;
			notifyObservers( [ evt ] );
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
			notifyObservers( [ evt ] );
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
			evt.bytesLoaded = event.loader.bytesLoaded;
			evt.bytesTotal = event.loader.bytesTotal;			
			removeQueueListeners( _assets, loadComplete );
			//don't call setPhase() as we don't want a duplicate notification
			_phase = ResourceLoadPhase.COMPLETE_PHASE;
			notifyObservers( [ evt ], "finished" );
			dispatchEvent( evt );
			
			//clean up the queue now we have the resources
			_assets.destroy();
			
			return evt;
		}
		
		/**
		* 	@private
		* 
		* 	Notifies observers of resource load events.
		* 
		* 	@param event The resource load event.
		*/
		private function notifyObservers(
			parameters:Array = null,
			method:String = "resource" ):void
		{
			if( _observers != null && _observers.length > 0 && parameters != null )
			{
				var observer:IResourceLoadObserver = null;
				for each( observer in _observers )
				{
					observer[ method ].apply( observer, parameters );
				}
			}
		}
		
		/**
		* 	Closes any open connections and cleans composite references.
		*/
		public function destroy():void
		{
			if( _configurationLoader != null )
			{
				_configurationLoader.destroy();
			}
			if( _assets != null )
			{
				_assets.destroy();
			}
			
			if( _observers != null )
			{
				var observer:IResourceLoadObserver = null;
				for each( observer in _observers )
				{
					removeObserver( observer );
				}
			}
			
			_observers = null;
			_parser = null;
			_request = null;
			_resources = null;
			_configuration = null;
			_configurationLoader = null;
			_assets = null;
			_phase = null;
			_phases = null;
			_builder = null;
			_beanManager = null;
			_styleManager = null;
		}
	}
}