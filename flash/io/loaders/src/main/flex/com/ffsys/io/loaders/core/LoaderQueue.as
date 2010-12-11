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
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.core.IBytesTotal;
	import com.ffsys.io.loaders.events.ILoadEvent;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.responder.ILoadResponder;
	import com.ffsys.io.loaders.responder.ILoadResponderDecorator;
	import com.ffsys.io.loaders.responder.LoadResponderDecorator;
	
	import com.ffsys.io.loaders.resources.ResourceList;
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceList;

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
					IBytesTotal {
		
		private var _id:String;
		private var _items:Array;
		private var _item:ILoaderElement;
		private var _resources:IResourceList;
		
		private var _index:int;
		private var _bytesTotal:uint;
		private var _bytesLoaded:uint;
		private var _paused:Boolean;		
		private var _loading:Boolean;
		private var _complete:Boolean;
		private var _forceLoad:Boolean;
		private var _delay:int;
		private var _delayTimer:Timer;
		
		private var _force:Boolean;
		
		private var _silent:Boolean;
		private var _fatal:Boolean;
		
		private var _responderDecorator:ILoadResponderDecorator;
		
		/**
		* 	Creates a <code>LoaderQueue</code> instance.
		*/
		public function LoaderQueue()
		{
			super();
			
			_responderDecorator = new LoadResponderDecorator( this );
			
			_resources = new ResourceList();
			reset();
			clear();
			this.bytesTotal = 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function flushResources():void
		{
			if( resources )
			{
				resources.destroy();
			}	
			_resources = new ResourceList();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function willReload():Boolean
		{
			//if we have no resources but have ILoader items
			//we should reload
			return ( !_resources.length && length );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function reload():void
		{
			load( bytesTotal );
		}
		
		/**
		* 	An identifier for this queue.
		*/
		public function get id():String
		{
			return _id;
		}
		
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		/**
		* 	The total number of bytes.
		*/		
		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}
		
		public function set bytesTotal( val:uint ):void
		{
			_bytesTotal = val;
		}
		
		/**
		* 	The total number of bytes loaded.
		*/		
		public function get bytesLoaded():uint
		{
			return _bytesLoaded;
		}
		
		public function set bytesLoaded( val:uint ):void
		{
			_bytesLoaded = val;
		}
		
		/**
		* 	@inheritDoc
		*/		
		public function get forceLoad():Boolean
		{
			return _forceLoad;
		}		
		
		public function set forceLoad( val:Boolean ):void
		{
			_forceLoad = val;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAllRequests():Array
		{
			var requests:Array = new Array();
			
			var item:ILoader;
			
			var i:int;
			var l:int = length;
			
			var j:int;
			var jl:int;
			
			for( ;i < l;i++ )
			{
				item = getLoaderAt( i ) as ILoader;
				requests.push( new URLRequest( item.uri ) );
			}
			
			return requests;
		}
		
		/**
		* 	@inheritDoc
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
		*	@inheritDoc
		*/
		public function addLoader(
			loader:ILoaderElement,
			options:ILoadOptions = null ):ILoaderElement
		{
			if( loader )
			{
				if( loader is ILoader )
				{
					if( options )
					{
						ILoader( loader ).options = options;
					}
					ILoader( loader ).queue = this;
				}
				_items.push( loader );
			}
			
			return loader;
		}
		
		/**
		* 	@inheritDoc
		*/
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
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderAt( index:int ):ILoaderElement
		{
			return ILoaderElement( _items[ index ] );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderById( id:String ):ILoaderElement
		{
			var i:int = 0;
			var l:int = length;
			
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
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderIndex( loader:ILoaderElement ):int
		{
			return _items.indexOf( loader );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeLoaderAt( index:int ):ILoaderElement
		{
			var removed:Array = _items.splice( index, 1 );
			if( removed && removed.length > 0 )
			{
				return removed[ 0 ] as ILoaderElement;
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get length():int
		{
			return _items.length;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function last():ILoaderElement
		{
			if( _items.length )
			{
				return _items[ _items.length - 1 ];
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function first():ILoaderElement
		{
			return _items[ 0 ];
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clear():void
		{
			_items = new Array();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isEmpty():Boolean
		{
			return _items.length == 0;
		}
		
		/**
		* 	@inheritDoc
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
		
		/**
		* 	@inheritDoc
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
				addLoader( loader, loader.options );
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function append( source:ILoaderQueue ):void
		{
			if( source )
			{
				var loaders:Array = source.getAllLoaders();
				for( var i:int = 0;i < loaders.length;i++ )
				{
					addLoader( loaders[ i ] );
				}
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get item():ILoaderElement
		{
			return _item;
		}
		
		/**
		* 	@private
		*/
		protected function dispatchLoadCompleteEvent():void
		{
			
			//the queue has finished loading
			_loading = false;
			_complete = true;
			
			var evt:Event = new Event( Event.COMPLETE );
			
			var event:LoadEvent =
				new LoadEvent(
					LoadEvent.LOAD_COMPLETE, evt, ILoader( _item ), resources );
				
			dispatchEvent( event );
		}
		
		/**
		* 	@private
		*/
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
			
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.LOAD_ITEM_START ,null, loader );
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
		
		/**
		* 	@inheritDoc
		*/
		public function get loading():Boolean
		{
			return _loading;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get loaded():Boolean
		{

			//we only return true if all child
			//ILoader instance are fully and
			//successfully loaded
			var output:Boolean = true;
			
			var i:int = 0;
			var l:int = length;
			
			var loader:ILoader;
			
			for( ;i < l;i++ )
			{
				loader = getLoaderAt( i ) as ILoader;
				output = ( output && loader.loaded );
				
				//break early if any of the child ILoader
				//instances are not loaded
				if( !output )
				{
					
					/*
					trace("LoaderQueue::loaded(), not loaded: " + loader );
					trace("LoaderQueue::loaded(), not loaded: " + loader.getBytesLoaded() );
					trace("LoaderQueue::loaded(), not loaded: " + loader.getBytesTotal() );
					*/
					
					return output;
				}
			}
			
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get complete():Boolean
		{
			return _complete;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function force( bytesTotal:uint = 0 ):void
		{
			_force = true;
			reset();
			
			/*
			trace( this );
			
			trace( "LoaderQueue force : " + index );
			trace( "LoaderQueue force : " + length );
			*/
			
			load( bytesTotal );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function load( bytesTotal:uint = 0 ):void
		{
			this.bytesLoaded = 0;
			this.bytesTotal = bytesTotal;
			
			if( _loading )
			{
				close();
				reset();
			}
			
			//trace( "LoaderQueue load : " + length );
			
			_loading = true;
			_complete = false;
			
			loadItemAtIndex( _index );
		}
		
		/**
		* 	Closes any open connections.
		*/
		public function close():void
		{
			_loading = false;
			_force = false;
			_complete = true;
			
			stopDelay();
			
			if( _item )
			{
				removeResponderListeners( _item, responder );
				removeResponderListeners( _item, this );
				_item.close();
			}
		}
		
		/**
		*	Destroys this queue allowing composite objects
		* 	to be freed for garbage collection.
		*/
		public function destroy():void
		{
			close();
			
			if( _resources )
			{
				_resources.destroy();
			}
			
			_resources = null;
			_id = null;
			_items = null;
			_item = null;
			
			//TODO: call destroy on these composite instances
			
			_responderDecorator = null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get index():int
		{
			return _index;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get delay():int
		{
			return _delay;
		}		
		
		public function set delay( val:int ):void
		{
			_delay = val;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get paused():Boolean
		{
			return _paused;
		}
		
		public function set paused( paused:Boolean ):void
		{
			_paused = paused;
			
			//stop any delay when set to pause
			if( _paused )
			{
				stopDelay();
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function resume():void
		{
			if( this.paused )
			{
				_paused = false;
				next();
			}
		}
		
		
		/**
		* 	Moves on to processing the next item in the queue.
		* 
		* 	This method is invoked as a handler after any delay
		* 	between loading has executed.
		* 
		* 	@param event The timer event that triggered this listener.
		*/
		protected function proceed( event:TimerEvent ):void
		{
			stopDelay();
			loadItemAtIndex( index + 1 );
		}		
		
		/**
		* 	Encapsulates the logic for determining whether we proceed
		* 	to the next item or start a delay between items.
		*/
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
			
			//nothing to do if we are paused
			if( this.paused )
			{
				return;
			}
			
			//loadItemAtIndex( this.index + 1 );
			
			//only use the delay if we have a delay set
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
		
		/**
		* 	Starts the delay timer.
		*/
		protected function startDelay():void
		{
			_delayTimer = new Timer( delay, 1 );
			_delayTimer.addEventListener( TimerEvent.TIMER, proceed, false, 0, true );
			_delayTimer.start();
		}
		
		/**
		* 	Stops the delay timer.
		*/
		protected function stopDelay():void
		{
			if( _delayTimer )
			{
				_delayTimer.removeEventListener( TimerEvent.TIMER, proceed );
				_delayTimer.stop();
			}
			
			_delayTimer = null;
		}

		/**
		*	Determines whether this queue should behave in a silent manner.
		*/
		public function get silent():Boolean
		{
			return _silent;
		}
				
		public function set silent( val:Boolean ):void
		{
			_silent = val;
		}
		
		/**
		*	Determines whether this queue should behave in a fatal manner.
		* 
		* 	When this property is <code>true</code> this implementation
		* 	will throw an exception when a resource not found event is encountered.
		*/
		public function get fatal():Boolean
		{
			return _fatal;
		}
				
		public function set fatal( val:Boolean ):void
		{
			_fatal = val;
		}
		
		/*
		*	ILoadResponderDecorator implementation.
		*/
		
		/**
		* 	@inheritDoc
		*/
		public function get responder():ILoadResponder
		{
			return _responderDecorator.responder;
		}		
		
		public function set responder( val:ILoadResponder ):void
		{
			if( responder )
			{
				this.removeEventListener(
					LoadEvent.LOAD_COMPLETE,
					responder.resourceLoadComplete );
			}
			
			_responderDecorator.responder = val;
			
			//hook our LoadCompleteEvent into the responder
			if( val )
			{
				this.addEventListener(
					LoadEvent.LOAD_COMPLETE,
					val.resourceLoadComplete, false, 0, true );
			}
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function addResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null,
			filters:Array = null ):void
		{
			_responderDecorator.addResponderListeners( dispatcher, responder, filters );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeResponderListeners(
			dispatcher:IEventDispatcher,
			responder:ILoadResponder = null ):void
		{
			_responderDecorator.removeResponderListeners( dispatcher, responder );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function cleanupResponderListeners( event:LoadEvent ):void
		{
			//
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function resourceNotFoundHandler( event:LoadEvent ):void
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
		
		/**
		* 	@inheritDoc
		*/
		public function resourceLoadStart( event:LoadEvent ):void
		{
			//dispatchEvent( event as Event );
			dispatchEvent( event.clone() );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function resourceLoadProgress( event:LoadEvent ):void
		{
			dispatchEvent( event.clone() );
		}
		
		/**
		* 	@inheritDoc
		*/
		
		//TODO: deprecate
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
		
		
		/**
		* 	@inheritDoc
		*/
		public function resourceLoaded( event:LoadEvent ):void
		{
			
			//trace("LoaderQueue::resourceLoaded(), " + event.loader.id );
			
			dispatchEvent( event as Event );
			next();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function resourceLoadComplete( event:LoadEvent ):void
		{
			//we don't proxy this event
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getResourceById( id:String, list:String = null ):IResource
		{
			return _resources.getResourceById( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getResourceListById( id:String ):IResourceList
		{
			return _resources.getResourceListById( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAllResources():Array
		{
			return _resources.getAllResources();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get resources():IResourceList
		{
			return _resources;
		}
		
		/*
		*	IPriorityQueue implementation.
		*/
		
		/**
		* 	@inheritDoc
		*/
		public function prioritize(
			loader:ILoaderElement,
			priority:int ):Boolean
		{
			
			if( !loader )
			{
				throw new Error( "LoaderQueue, cannot prioritize a null ILoader." );
			}
			
			//trace("LoaderQueue::prioritize(), on loader id: " + loader.id );
			
			var prioritized:Boolean = false;
			
			var currentLoader:ILoader = item as ILoader;
			
			if( currentLoader )
			{
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
			
			}
			
			return prioritized;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function prioritizeById( id:String, priority:int ):Boolean
		{
			var element:ILoaderElement = getLoaderById( id );
			
			if( element )
			{
				return prioritize( element, priority );
			}
			
			return false;
		}		
		
		/**
		* 	Prioritize a loader element to the top of the queue.
		* 
		* 	@param loader The loader element.
		* 
		* 	@return A boolean indicating whether any prioritization took place.
		*/
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
		
		/**
		* 	Prioritize a loader element up one place in the queue.
		* 
		* 	@param loader The loader element.
		* 
		* 	@return A boolean indicating whether any prioritization took place.
		*/
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
		
		/**
		* 	Prioritize a loader element down one place in the queue.
		* 
		* 	@param loader The loader element.
		* 
		* 	@return A boolean indicating whether any prioritization took place.
		*/
		protected function prioritizeDown( loader:ILoaderElement ):Boolean
		{
			var index:int = getLoaderIndex( loader );
			if( index > -1 && index < ( length - 1 ) )
			{
				var removed:ILoaderElement = removeLoaderAt( index );
				_items.splice( index + 1, 0, removed );	
				return true;
			}
			return false;
		}			
		
		/**
		* 	Prioritize a loader element to the bottom of queue.
		* 
		* 	@param loader The loader element.
		* 
		* 	@return A boolean indicating whether any prioritization took place.
		*/
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
		
		/**
		* 	Prioritize a loader element to a specified index in the queue.
		* 
		* 	@param loader The loader element.
		* 	@param priority The index to prioritize to.
		* 
		* 	@return A boolean indicating whether any prioritization took place.
		*/
		protected function prioritizeIndex( loader:ILoaderElement, priority:int ):Boolean
		{
			if( priority >= 0 && priority < ( length - 1 ) )
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
	}	
}