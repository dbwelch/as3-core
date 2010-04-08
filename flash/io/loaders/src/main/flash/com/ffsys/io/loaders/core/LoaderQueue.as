package com.ffsys.io.loaders.core {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	
	import flash.net.URLRequest;
	import flash.net.URLLoader;
	
	import flash.utils.Timer;
	
	import com.ffsys.utils.string.StringUtils;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.core.IBytesTotal;
	import com.ffsys.io.loaders.events.ILoadEvent;
	import com.ffsys.io.loaders.events.ResourceNotFoundEvent;
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.LoadCompleteEvent;
	import com.ffsys.io.loaders.message.ILoadMessageFormatter;
	import com.ffsys.io.loaders.responder.ILoadResponder;
	import com.ffsys.io.loaders.events.LoadStartEvent;
	import com.ffsys.io.loaders.events.LoaderQueueStartEvent;
	import com.ffsys.io.loaders.responder.ILoadResponderDecorator;
	import com.ffsys.io.loaders.responder.LoadResponderDecorator;
	
	import com.ffsys.io.loaders.resources.ResourceList;
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceList;
	
	//-->
	//import com.ffsys.io.loaders.calculator.CumulativeSizeCalculator;
	//import com.ffsys.io.loaders.events.CumulativeSizeCompleteEvent;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.IObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;	
	/* END OBJECT_INSPECTOR REMOVAL */

	/**
	*	Handles loading a queue of external assets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class LoaderQueue extends EventDispatcher
		implements	ILoaderQueue,
					IBytesTotal,
					IObjectInspector {
				
		/**
		*	@private	
		*/		
		protected var _id:String;
			
		/**
		*	@private
		*	
		*	<code>Array</code> used to store the
		*	<code>ILoaderElement</code> instances.
		*/
		protected var _items:Array;
		
		/**
		*	@private
		*	
		*	The current index (or position) of the queue.
		*/
		protected var _index:int;
		
		/**
		*	@private	
		*/
		protected var _item:ILoaderElement;
		
		/**
		*	@private	
		*/
		protected var _bytesTotal:uint;
		
		/**
		*	@private	
		*/
		protected var _bytesLoaded:uint;
		
		/**
		*	@private	
		*/
		protected var _bytesTotalStorage:IBytesTotal;
		
		protected var _responderDecorator:ILoadResponderDecorator;
		protected var _loadOptionsDecorator:ILoadOptionsDecorator;
		
		protected var _resources:ResourceList;
		protected var _formatter:ILoadMessageFormatter;
		
		/**
		*	@private	
		*/
		protected var _loading:Boolean;
		
		/**
		*	@private	
		*/
		protected var _complete:Boolean;		
		
		public function LoaderQueue()
		{
			_responderDecorator = new LoadResponderDecorator( this );
			_loadOptionsDecorator = new LoadOptionsDecorator();
			
			_resources = new ResourceList();
			
			super();
			reset();
			clear();
			
			this.bytesTotal = 0;
			this.bytesTotalStorage = this;
		}
		
		public function flushResources():void
		{
			
			if( resources )
			{
				resources.destroy();
			}
			
			_resources = new ResourceList();
		}
		
		public function willReload():Boolean
		{
			//if we have no resources but have ILoader items
			//we should reload
			return ( !_resources.getLength() && getLength() );
		}
		
		public function reload():void
		{
			load( bytesTotal );
		}
		
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		public function get id():String
		{
			return _id;
		}
		
		public function set bytesTotalStorage( val:IBytesTotal ):void
		{
			_bytesTotalStorage = val;
		}
		
		public function get bytesTotalStorage():IBytesTotal
		{
			return _bytesTotalStorage;
		}		
		
		public function set bytesTotal( val:uint ):void
		{
			_bytesTotal = val;
		}
		
		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}
		
		public function set bytesLoaded( val:uint ):void
		{
			_bytesLoaded = val;
		}
		
		public function get bytesLoaded():uint
		{
			return _bytesLoaded;
		}
		
		/*
		*	IForceLoad implementation.	
		*/
		protected var _forceLoad:Boolean;
		
		public function set forceLoad( val:Boolean ):void
		{
			_forceLoad = val;
		}
		
		public function get forceLoad():Boolean
		{
			return _forceLoad;
		}
		
		public function getAllRequests():Array
		{
			var requests:Array = new Array();
			
			var item:ILoader;
			
			var i:int;
			var l:int = getLength();
			
			var j:int;
			var jl:int;
			
			for( ;i < l;i++ )
			{
				item = getLoaderAt( i ) as ILoader;
				requests.push( new URLRequest( item.uri ) );
			}
			
			return requests;
		}
		
		/*
		*	ILoaderQueue implementation.
		*/
		
		public function getAllLoaders():Array
		{
			var output:Array = new Array();
			
			var i:int = 0;
			var l:int = _items.length;
			
			var target:ILoaderElement;
			
			for( ;i < l;i++ )
			{	
				target = _items[ i ] as ILoaderElement;
				
				if( target is ILoader )
				{
					output.push( target );
				}else if( target is ILoaderQueue ) 
				{
					output = output.concat.apply(
						output, ( target as ILoaderQueue ).getAllLoaders() );
				}
			}
			
			return output;
		}
		
		/**
		*	Adds a URLRequest to the queue.
		*
		*	By default if the second argument is omitted we try to
		*	determine the Class using the FileTypeRegistry.
		*
		*	@param request the URLRequest to add to the queue
		*	@param loader an optional ILoader instance to use for loading this request 
		*/
		public function addLoader(
			request:URLRequest,
			loader:ILoader = null,
			options:ILoadOptions = null ):ILoader
		{
			
			if( !loader )
			{
				loader = LoaderFactory.create( request.url );
			}else{
				loader.uri = request.url;
			}
			
			if( options )
			{
				loader.options = options;
			}
			
			loader.request = request;
			loader.queue = this;
			
			_items.push( loader );
			
			return loader;
		}
		
		public function removeLoader( val:ILoaderElement ):Boolean
		{
			var i:int = 0;
			var l:int = _items.length;
			
			var target:ILoaderElement;
			
			for( ;i < l;i++ )
			{
				target = _items[ i ];
				
				if( target == val )
				{
					removeLoaderAt( i );
					return true;
				}
				
				if( ( target is ILoaderQueue )
					&& ( target as ILoaderQueue ).removeLoader( val ) )
				{
					return true;
				}
			}
			
			return false;
		}
		
		public function getLoaderAt( index:int ):ILoaderElement
		{
			return ILoaderElement( _items[ index ] );
		}
		
		public function getLoaderById( id:String ):ILoaderElement
		{
			var i:int = 0;
			var l:int = getLength();
			
			var element:ILoaderElement;
			
			for( ;i < l;i++ )
			{
				element = getLoaderAt( i );
				
				if( element.id == id )
				{
					return element;
				}
				
			}
			
			return null;
		}
		
		public function getLoaderIndex( loader:ILoaderElement ):int
		{
			var i:int = 0;
			var l:int = getLength();
			
			var element:ILoaderElement;
			
			for( ;i < l;i++ )
			{
				element = getLoaderAt( i );
				
				if( element == loader )
				{
					return i;
				}
				
			}
			
			return -1;			
		}

		public function removeLoaderAt( index:int ):ILoaderElement
		{
			var removed:Array = _items.splice( index, 1 );
			
			if( removed && removed.length > 0 )
			{
				return removed[ 0 ] as ILoaderElement;
			}
			
			return null;
		}
		
		public function getLength():int
		{
			return _items.length;
		}
		
		public function last():ILoaderElement
		{
			if( _items.length )
			{
				return _items[ _items.length - 1 ];
			}
			
			return null;
		}
		
		public function first():ILoaderElement
		{
			return _items[ 0 ];
		}
		
		public function clear():void
		{
			_items = new Array();
		}
		
		public function isEmpty():Boolean
		{
			return _items.length == 0;
		}
		
		/**
		*	Resets the queue position to zero.
		*/
		public function reset():void
		{
			_index = 0;
		}
		
		/**
		*	Flattens this LoaderQueue. If the LoaderQueue contains
		*	any other LoaderQueue instances all the ILoader instances
		*	within the child LoaderQueue(s) are collected and this LoaderQueue
		*	contains all the ILoader instances in any and all children including
		*	this LoaderQueue itself.
		*/
		public function flatten():void
		{
			var loaders:Array = getAllLoaders();
			clear();
			
			var i:int = 0;
			var l:int = loaders.length;
			var loader:ILoader;
			
			for( ;i < l;i++ )
			{
				loader = loaders[ i ];
				addLoader( loader.request, loader, loader.options );
			}
			
		}
		
		public function get item():ILoaderElement
		{
			return _item;
		}
		
		private function bytesTotalAvailable( event:LoadCompleteEvent ):void
		{
			event.target.removeEventListener( event.type, bytesTotalAvailable );
		}
		
		private function dispatchCumulativeSizeComplete( event:LoadCompleteEvent ):void
		{
			/*
			var evt:CumulativeSizeCompleteEvent =
				new CumulativeSizeCompleteEvent( event, event.loader, this.bytesTotal );
			
			dispatchEvent( evt );
			*/
				
		}
		
		protected function dispatchLoadCompleteEvent():void
		{
			
			//the queue has finished loading
			_loading = false;
			_complete = true;
			
			var evt:Event = new Event( Event.COMPLETE );
			var event:LoadCompleteEvent =
				new LoadCompleteEvent( evt, ILoader( _item ), resources );
				
			dispatchEvent( event );
		}
		
		private function loadItemAtIndex( index:int = 0 ):void
		{
		
			if( _item )
			{
				removeResponderListeners( _item, responder );
				removeResponderListeners( _item, this );
			}
			
			if( index > ( _items.length - 1 ) )
			{
				//trace("LoaderQueue::complete() " + index );
				//trace("LoaderQueue::complete() " + _item );
				
				/*
				removeResponderListeners( _item );
				removeResponderListeners( this );
				removeResponderListeners( _item, this );
				*/
				/*
				//-->
				//clean up our reference to the ResourceList
				//now we've dispatched the event
				//_resources = null;
				*/
				
				_loading = false;
				_force = false;

				dispatchLoadCompleteEvent();
				
				reset();
				return;
			}
			
			_index = index;
			
			//trace( "LoaderQueue.loadItemAtIndex : " + index );
			//trace( "LoaderQueue.loadItemAtIndex : " + responder );
			
			_item = getLoaderAt( index );
			
			var loader:ILoader = ILoader( _item );
			
			//if we're set to only load ILoader instances
			//that have the forceLoad flag set
			if( _force )
			{
				//move on to the next one if this ILoader
				//is not set to force load
				if( !loader.forceLoad )
				{
					loadItemAtIndex( _index + 1 );
					return;
				}
			}
			
			var evt:LoaderQueueStartEvent = new LoaderQueueStartEvent( null, loader );
			dispatchEvent( evt );
			Notifier.dispatchEvent( evt );
			
			addResponderListeners( loader, responder );
			addResponderListeners( loader, this );
			
			/*
			trace("LoaderQueue::loadItemAtIndex(), index " + _index );
			trace("LoaderQueue::loadItemAtIndex(), uri " + loader.uri );
			*/
			
			//if we were in a delay _loading may have been set to false
			//for the duration of the delay period
			_loading = true;
			
			loader.load( loader.request );
		}
		
		/*
		*	ILoadStatus implementation.	
		*/
		
		public function get loading():Boolean
		{
			return _loading;
		}
		
		public function get loaded():Boolean
		{

			//we only return true if all child
			//ILoader instance are fully and
			//successfully loaded
			var output:Boolean = true;
			
			var i:int = 0;
			var l:int = getLength();
			
			var loader:ILoader;
			
			for( ;i < l;i++ )
			{
				loader = getLoaderAt( i ) as ILoader;
				output = ( output && loader.loaded );
				
				//break early if any of the child ILoader
				//instances are not loaded
				if( !output )
				{
					trace("LoaderQueue::loaded(), not loaded: " + loader );
					trace("LoaderQueue::loaded(), not loaded: " + loader.getBytesLoaded() );
					trace("LoaderQueue::loaded(), not loaded: " + loader.getBytesTotal() );
					return output;
				}
			}
			
			return output;
		}
		
		public function get complete():Boolean
		{
			return _complete;
		}
		
		/**
		*	Loads all items that have been set to forceLoad	
		*/
		
		protected var _force:Boolean;
		
		public function force( bytesTotal:uint = 0 ):void
		{
			_force = true;
			reset();
			
			/*
			trace( this );
			
			trace( "LoaderQueue force : " + index );
			trace( "LoaderQueue force : " + getLength() );
			*/
			
			load( bytesTotal );
		}
		
		public function load( bytesTotal:uint = 0 ):void
		{
			this.bytesLoaded = 0;
			this.bytesTotal = bytesTotal;
			
			if( _loading )
			{
				close();
				reset();
			}
			
			//trace( "LoaderQueue load : " + getLength() );
			
			_loading = true;
			_complete = false;
			
			loadItemAtIndex( _index );
		}
		
		//private var _closed:Boolean;
		public function close():void
		{
			_loading = false;
			_force = false;
			_complete = true;
			//_closed = true;				
			
			/*
			if( _calculator )
			{
				_calculator.close();
			}
			*/
			
			stopDelay();
			
			if( _item )
			{	
				removeResponderListeners( _item, responder );
				removeResponderListeners( _item, this );
				
				_item.close();
			}
		}
		
		public function get index():int
		{
			return _index;
		}
		
		protected var _delay:int;
		protected var _delayTimer:Timer;
		
		public function set delay( val:int ):void
		{
			_delay = val;
		}
		
		public function get delay():int
		{
			return _delay;
		}
		
		protected function proceed( event:TimerEvent ):void
		{
			loadItemAtIndex( index + 1 );
			stopDelay();
		}
		
		protected function next():void
		{
			//we shouldn't proceed to the next item
			//in the queue if this queue has been closed
			
			/*
			if( _closed )
			{
				return;
			}
			*/
			
			//loadItemAtIndex( this.index + 1 );
			
			//only use the dealy if we have a delay set
			//and are not the first item to load
			if( delay && index )
			{
				//we're not loading while we're delaying
				_loading = false;
				
				startDelay();
			}else{
				loadItemAtIndex( this.index + 1 );
			}
		}
		
		protected function startDelay():void
		{
			_delayTimer = new Timer( delay, 1 );
			_delayTimer.addEventListener( TimerEvent.TIMER, proceed, false, 0, true );
			_delayTimer.start();
		}
		
		protected function stopDelay():void
		{
			if( _delayTimer )
			{
				_delayTimer.removeEventListener( TimerEvent.TIMER, proceed );
				_delayTimer.stop();
			}
			
			_delayTimer = null;
		}

		/*
		*	ILoadOptionsDecorator implementation.
		*/
		
		public function set silent( val:Boolean ):void
		{
			_loadOptionsDecorator.silent = val;
		}
		
		public function get silent():Boolean
		{
			return _loadOptionsDecorator.silent;
		}
		
		public function set fatal( val:Boolean ):void
		{
			_loadOptionsDecorator.fatal = val;
		}
		
		public function get fatal():Boolean
		{
			return _loadOptionsDecorator.fatal;
		}
		
		/*
		*	ILoadResponderDecorator implementation.
		*/
		
		public function set responder( val:ILoadResponder ):void
		{
			if( responder )
			{
				this.removeEventListener(
					LoadCompleteEvent.LOAD_COMPLETE,
					responder.resourceLoadComplete );
			}
			
			_responderDecorator.responder = val;
			
			//hook our LoadCompleteEvent into the responder
			if( val )
			{
				this.addEventListener(
					LoadCompleteEvent.LOAD_COMPLETE,
					val.resourceLoadComplete, false, 0, true );
			}
		}
		
		public function get responder():ILoadResponder
		{
			return _responderDecorator.responder;
		}		
		
		public function addResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null,
			filters:Array = null ):void
		{
			_responderDecorator.addResponderListeners( dispatcher, responder, filters );
		}
		
		public function removeResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null ):void
		{
			_responderDecorator.removeResponderListeners( dispatcher, responder );
		}
		
		public function cleanupResponderListeners( event:ILoadEvent ):void
		{
			//
		}		
		
		/*
		*	ILoadResponder implementation	
		*/
		
		public function resourceNotFoundHandler( event:ResourceNotFoundEvent ):void
		{
			var loader:ILoader = event.loader;

			var options:ILoadOptions = loader.options;
			
			/*
			trace( "LoaderQueue resourceNotFoundHandler options.silent : " + options.silent );
			trace( "LoaderQueue resourceNotFoundHandler options.fatal : " + options.fatal );
			trace( "LoaderQueue resourceNotFoundHandler options.continueOnResourceNotFound : " +
				options.continueOnResourceNotFound );
			trace( "LoaderQueue resourceNotFoundHandler options.quietOnResourceNotFound : " +
				options.quietOnResourceNotFound );
			
			*/
			
			if( fatal || options.fatal )
			{
				throw new Error(
					"LoaderQueue fatal resource not found error: " + event.loader.uri );
			}
			
			if( !silent && !options.quietOnResourceNotFound )
			{
				dispatchEvent( event as Event );
				Notifier.dispatchEvent( event as Event );
			}
			
			if( silent || options.continueOnResourceNotFound )
			{
				next();
			}						
			
			removeResponderListeners( event.loader );
			removeResponderListeners( this );
			removeResponderListeners( event.loader, this );
			
			if( !silent && !options.continueOnResourceNotFound )
			{
				//if we don't continue on resource not found
				//we are complete and not currently loading
				//dispatch the complete event after the resource
				//not found event - this also resets the loading
				//and complete flags
				dispatchLoadCompleteEvent();
			}
			
		}
		
		public function resourceLoadStart( event:LoadStartEvent ):void
		{
			//dispatchEvent( event as Event );
		}
		
		public function resourceLoadProgress( event:LoadProgressEvent ):void
		{
			
			//trace( "bytesLoaded : " + this.bytesLoaded );
			//trace( "bytesTotal : " + this.bytesTotal );
			
			var progressEvent:ProgressEvent = new ProgressEvent( ProgressEvent.PROGRESS );
			progressEvent.bytesLoaded = this.bytesLoaded;
			progressEvent.bytesTotal = this.bytesTotal;
			
			//trace( "progressEvent bytesLoaded : " + progressEvent.bytesLoaded );
			//trace( "progressEvent bytesTotal : " + progressEvent.bytesTotal );
			
			var evt:LoadProgressEvent =
				new LoadProgressEvent( progressEvent, event.loader );
			
			//trace( "percent : " + evt.percentLoaded );
			
			dispatchEvent( evt );
			
			//dispatchEvent( event );
		}
		
		public function addResource( loader:ILoader ):void
		{
			var resource:IResource = loader.resource;
			
			//trace("LoaderQueue::addResource() " + loader );

			if( resource )
			{
			
				resource.id = loader.id;
			
				if( loader.list )
				{
					
					try {
						ResourceList( loader.list ).addResource( resource );
					}catch( e:Error )
					{
						//throw new Error( "LoaderQueue, could not add resource : " + resource + "\n\n" + e.toString() );
						
						//possibly the queue has been closed when this error is thrown
						//ignored for the moment - but needs to be fixed properly
					}					
					
					/*
					trace( "Adding individual resource to list : " +
						ResourceList( loader.customData ) );
					*/
					
				}else{
					resources.addResource( resource );
				}
			
			}			
		}
		
		public function resourceLoaded( event:ILoadEvent ):void
		{
			
			//trace("LoaderQueue::resourceLoaded(), " + event.loader.id );
			
			dispatchEvent( event as Event );
			next();
		}
		
		public function resourceLoadComplete( event:LoadCompleteEvent ):void
		{
			//dispatchEvent( event );
		}
		
		/*
		*	ILoadCumulativeResponder implementation.
		*/
		public function cumulativeResourceLoadProgress( event:LoadProgressEvent ):void
		{
			dispatchEvent( event as Event );
		}
		
		public function set formatter( val:ILoadMessageFormatter ):void
		{
			_formatter = val;
		}
		
		public function get formatter():ILoadMessageFormatter
		{
			return _formatter;
		}
		
		/*
		*	IResourceAccess implementation.
		*/
		public function getResourceById( id:String, list:String = null ):IResource
		{
			return _resources.getResourceById( id );
		}
		
		public function getResourceListById( id:String ):IResourceList
		{
			return _resources.getResourceListById( id );
		}
		
		public function getAllResources():Array
		{
			return _resources.getAllResources();
		}
		
		public function get resources():IResourceList
		{
			return _resources;
		}
		
		/*
		*	IPriorityQueue implementation.
		*/
		
		public function prioritize(	loader:ILoaderElement, priority:int ):Boolean
		{
			
			if( !loader )
			{
				throw new Error( "LoaderQueue, cannot prioritize a null ILoader." );
			}
			
			//trace("LoaderQueue::prioritize(), on loader id: " + loader.id );
			
			var prioritized:Boolean = false;
			
			var currentLoader:ILoader = item as ILoader;
			
			//attempt to prioritize the loader that is currently
			//loading
			if( ( loader == currentLoader ) && currentLoader.loading )
			{
				//--> refactor to be runtime warnings in case this behaviour is required
				//--> to bypass the loading of certain assets
				
				//trying to prioritize an ILoader to the currently loading
				//ILoader instance, bypass prioritization
				if( priority == LoaderPriority.CURRENT )
				{
					//trace("LoaderQueue::prioritize(), bypassing prioritization on: " + loader.id );
					return false;
				}
				
			}
			
			//switch the priority to be the current
			//index of we are set to switch out the current loader
			//this will cause the default prioritizeIndex() clause
			//to be triggered below
			if( priority == LoaderPriority.CURRENT )
			{
				priority = index;
			}
			
			//indicates that we are prioritizing to the current
			//index being loaded
			var prioritizeCurrentLoad:Boolean =
				( currentLoader && ( priority == index ) );
			
			//if the current item is loading
			//close it's stream
			if( prioritizeCurrentLoad )
			{
				//trace("LoaderQueue::prioritize(), closing current item: " + currentLoader.id );
				
				//removeResponderListeners( currentLoader, responder );
				//removeResponderListeners( currentLoader, this );		
				
				//close any open stream
				currentLoader.close();
				
				//stop any delay in effect
				stopDelay();
			}
			
			switch( priority )
			{
				case LoaderPriority.TOP:
					prioritized = prioritizeTop( loader );
					break;
				case LoaderPriority.UP:
					prioritized = prioritizeUp( loader );
					break;					
				case LoaderPriority.DOWN:
					prioritized = prioritizeDown( loader );
					break;					
				case LoaderPriority.BOTTOM:
					prioritized = prioritizeBottom( loader );
					break;					
				default:
					prioritized = prioritizeIndex( loader, priority );
					break;					
			}
			
			//after the queue prioritization
			//if we've moved an attempt to be current
			//we need to restart the load process
			//on the newly prioritized item
			if( prioritizeCurrentLoad )
			{
				//trace("LoaderQueue::prioritize(), starting load on prioritized item: " + loader.id );
				loadItemAtIndex( index );
			}
			
			return prioritized;
		}
			
		public function prioritizeById( id:String, priority:int ):Boolean
		{
			var element:ILoaderElement = getLoaderById( id );
			
			if( element )
			{
				return prioritize( element, priority );
			}
			
			return false;
		}		
		
		protected function prioritizeTop( loader:ILoaderElement ):Boolean
		{
			var index:int = getLoaderIndex( loader );
			
			if( index > 0 )
			{
				var removed:ILoaderElement = removeLoaderAt( index );
				_items.unshift( loader );
				return true;
			}
			
			return false;
		}
		
		protected function prioritizeUp( loader:ILoaderElement ):Boolean
		{
			var index:int = getLoaderIndex( loader );
			
			if( index > 0 )
			{
				var removed:ILoaderElement = removeLoaderAt( index );
				_items.splice( index - 1, 0, loader );
				return true;
			}
			
			return false;
		}
		
		protected function prioritizeDown( loader:ILoaderElement ):Boolean
		{
			var index:int = getLoaderIndex( loader );
			
			if( index > -1 && index < ( getLength() - 1 ) )
			{
				var removed:ILoaderElement = removeLoaderAt( index );
				_items.splice( index + 1, 0, removed );	
				return true;
			}
			
			return false;
		}			
		
		protected function prioritizeBottom( loader:ILoaderElement ):Boolean
		{
			var index:int = getLoaderIndex( loader );
			
			if( index > -1 )
			{
				var removed:ILoaderElement = removeLoaderAt( index );
				_items.push( removed );
				return true;
			}
			
			return false;
		}
		
		protected function prioritizeIndex( loader:ILoaderElement, priority:int ):Boolean
		{
			if( priority >= 0 && priority < ( getLength() - 1 ) )
			{
				var index:int = getLoaderIndex( loader );
				
				if( index > -1 && ( index != priority ) )
				{
					var removed:ILoaderElement = removeLoaderAt( index );
					_items.splice( priority, 0, removed );	
					return true;
				}
				
			}
			
			return false;
		}
		
		/* BEGIN OBJECT_INSPECTOR REMOVAL */
		
		/**
		*	@private	
		*/
		public function getCommonStringOutputMethods():Object
		{
			var output:Object = new Object();
			return output;
		}

		/**
		*	@private	
		*/
		public function getCommonStringOutputProperties():Object
		{
			var output:Object = new Object();
			return output;
		}

		/**
		*	@private	
		*/
		public function getCommonStringOutputComposites():Array
		{
			return _items;
		}

		/**
		*	@private	
		*/
		public function getDefaultStringOutputOptions():ObjectInspectorOptions
		{
			var output:ObjectInspectorOptions = new ObjectInspectorOptions();
			return output;
		}

		/**
		*	@private	
		*/
		public function toSimpleString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
				
			return output.getSimpleInspection();
		}

		/**
		*	@private	
		*/
		public function toObjectString():String
		{
			var output:ObjectInspector = new ObjectInspector(
				this, getDefaultStringOutputOptions() );
			
			output.methods = getCommonStringOutputMethods();
			output.properties = getCommonStringOutputProperties();
			output.composites = getCommonStringOutputComposites();
			return output.getComplexInspection();
		}
		
		/**
		*	@private	
		*/		
		public function getObjectString( complex:Boolean = false ):String
		{
			return complex ? toObjectString() : toSimpleString();
		}

		/**
		*	Gets a <code>String</code> representation
		*	of this instance.
		*	
		*	@return The <code>String</code>
		*	representation of this instance.
		*/
		override public function toString():String
		{
			return getObjectString( true );
		}
		/* END OBJECT_INSPECTOR REMOVAL */
	}	
}