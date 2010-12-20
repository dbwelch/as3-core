package com.ffsys.io.loaders.core {
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.TimerEvent;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.events.ILoadEvent;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.resources.ResourceList;
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceList;

	/**
	*	Encapsulates child loader or loader queue implementations
	* 	and the logic for sequencing the load operations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.07.2007
	*/
	public class LoaderQueue extends LoaderElement
		implements	ILoaderQueue {
		
		private var _elements:Array;
		private var _current:ILoaderElement;
		private var _index:int = 0;
		private var _delay:int;
		private var _delayTimer:Timer;
		
		private var _force:Boolean;
		private var _silent:Boolean;
		private var _fatal:Boolean;
		
		/**
		* 	Creates a <code>LoaderQueue</code> instance.
		*/
		public function LoaderQueue()
		{
			super();
			_resource = new ResourceList();
			reset();
			clear();
			_bytesTotal = 0;
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
			_resource = new ResourceList( this.id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function willReload():Boolean
		{
			//if we have no resources but have ILoader items
			//we should reload
			return ( !this.resources.length && length );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function reload():void
		{
			load();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAllRequests():Array
		{
			var requests:Array = new Array();
			var target:ILoaderElement = null;
			for( var i:int = 0;i < this.length;i++ )
			{
				target = _elements[ i ] as ILoaderElement;
				if( target is ILoader )
				{
					requests.push( new URLRequest( ILoader( item ).uri ) );
				}else if( target is ILoaderQueue ) 
				{
					requests = requests.concat.apply(
						requests, ( target as ILoaderQueue ).getAllRequests() );
				}				
			}
			return requests;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAllLoaders():Array
		{
			var output:Array = new Array();
			var target:ILoaderElement = null;
			for( var i:int = 0;i < this.length;i++ )
			{	
				target = _elements[ i ] as ILoaderElement;
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
				}
				loader.queue = this;
				_elements.push( loader );
			}
			return loader;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeLoader( val:ILoaderElement ):Boolean
		{
			var i:int = 0;
			var l:int = _elements.length;
			var target:ILoaderElement;
			for( ;i < l;i++ )
			{
				target = _elements[ i ];
				
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
		public function insertLoaderAt( loader:ILoaderElement, index:int ):Boolean
		{
			if( loader && index >= 0 )
			{
				if( index < this.length )
				{
					_elements.splice( index, 0, loader );
				}else{
					_elements.push( loader );
				}
				return true;
			}
			
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderAt( index:int ):ILoaderElement
		{
			return ILoaderElement( _elements[ index ] );
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
			return _elements.indexOf( loader );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function removeLoaderAt( index:int ):ILoaderElement
		{
			var removed:Array = _elements.splice( index, 1 );
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
			return _elements.length;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function last():ILoaderElement
		{
			if( _elements.length )
			{
				return _elements[ _elements.length - 1 ];
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function first():ILoaderElement
		{
			return _elements[ 0 ];
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clear():void
		{
			_elements = new Array();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isEmpty():Boolean
		{
			return _elements.length == 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function reset():void
		{
			_index = 0;
		}
		
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
			return _current;
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
					LoadEvent.LOAD_COMPLETE, evt, _current, resources );
				
			dispatchEvent( event );
		}
		
		/**
		* 	@private
		*/
		private function loadItemAtIndex( index:int = 0 ):void
		{
		
			if( _current )
			{
				removeCompositeListeners( _current );
			}
			
			//add any composite child queue resources to our list
			if( this.resources && _current is ILoaderQueue )
			{
				this.resources.addResource( ILoaderQueue( _current ).resources );
			}
			
			if( index > ( _elements.length - 1 ) )
			{
				_loading = false;
				_force = false;
				
				trace("LoaderQueue::loadItemAtIndex() COMPLETE", index, this.customData );

				dispatchLoadCompleteEvent();
				
				reset();
				return;
			}
			
			_index = index;
			
			_current = getLoaderAt( index );
			
			var element:ILoaderElement = _current;
			
			trace("LoaderQueue::loadItemAtIndex()", _index, element );
			
			if( element is ILoader )
			{
				var loader:ILoader = ILoader( element );
				
				/*
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
				*/
			
				addCompositeListeners( loader );
			
				//if we were in a delay _loading may have been set to false
				//for the duration of the delay period
				_loading = true;
				loader.load();
			}else if( element is ILoaderQueue )
			{
				var child:ILoaderQueue = ILoaderQueue( element );
				addCompositeListeners( child );
				child.load();
			}
		}
		
		/**
		* 	@private
		*/
		private function childEventProxy( event:LoadEvent ):void
		{
			dispatchEvent( event );
		}
		
		/**
		* 	@private
		*/
		private function childQueueComplete( event:LoadEvent ):void
		{
			removeCompositeListeners( event.loader );
			//move on to the next item
			next();
		}
		
		/**
		* 	@private
		*/
		override protected function addCompositeListeners( target:IEventDispatcher ):void
		{
			//child queue listeners
			if( target is ILoaderQueue )
			{
				target.addEventListener( LoadEvent.QUEUE_START, childEventProxy );
				target.addEventListener( LoadEvent.LOAD_START, childEventProxy );
				target.addEventListener( LoadEvent.LOAD_PROGRESS, childEventProxy );
				target.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, childEventProxy );
				target.addEventListener( LoadEvent.DATA, childEventProxy );
				target.addEventListener( LoadEvent.LOAD_FINISHED, childEventProxy );
				target.addEventListener( LoadEvent.LOAD_COMPLETE, childQueueComplete );
			//child loader listeners
			}else if( target is ILoader )
			{
				target.addEventListener( LoadEvent.LOAD_START, childEventProxy );
				target.addEventListener( LoadEvent.LOAD_PROGRESS, childEventProxy );						
				target.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, resourceNotFoundHandler );
				target.addEventListener( LoadEvent.DATA, childEventProxy );
				target.addEventListener( LoadEvent.LOAD_FINISHED, resourceLoaded );
			}
		}		
		
		/**
		* 	@private
		*/
		override protected function removeCompositeListeners( target:IEventDispatcher ):void
		{
			//child queue listeners
			if( target is ILoaderQueue )
			{
				target.removeEventListener( LoadEvent.QUEUE_START, childEventProxy );
				target.removeEventListener( LoadEvent.LOAD_START, childEventProxy );
				target.removeEventListener( LoadEvent.LOAD_PROGRESS, childEventProxy );		
				target.removeEventListener( LoadEvent.RESOURCE_NOT_FOUND, childEventProxy );
				target.removeEventListener( LoadEvent.DATA, childEventProxy );
				target.removeEventListener( LoadEvent.LOAD_FINISHED, childEventProxy );
				target.removeEventListener( LoadEvent.LOAD_COMPLETE, childQueueComplete );
			//child loader listeners				
			}else if( target is ILoader )
			{
				target.removeEventListener( LoadEvent.LOAD_START, childEventProxy );
				target.removeEventListener( LoadEvent.LOAD_PROGRESS, childEventProxy );
				target.removeEventListener( LoadEvent.RESOURCE_NOT_FOUND, resourceNotFoundHandler );
				target.removeEventListener( LoadEvent.DATA, childEventProxy );
				target.removeEventListener( LoadEvent.LOAD_FINISHED, resourceLoaded );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get loaded():Boolean
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
					return output;
				}
			}
			
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function force( bytesTotal:uint = 0 ):void
		{
			_force = true;
			reset();
			load();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function load():void
		{
			_bytesLoaded = 0;
			_bytesTotal = bytesTotal;
			
			if( _loading )
			{
				close();
				reset();
			}
			
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.QUEUE_START, null, this, this.resource );
			dispatchEvent( evt );

			_loading = true;
			_complete = false;	
			loadItemAtIndex( _index );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function close():void
		{
			_loading = false;
			_force = false;
			_complete = true;
			
			stopDelay();
			
			if( _current )
			{
				removeCompositeListeners( _current );
				_current.close();
			}
		}
		
		/**
		*	Destroys this queue allowing composite objects
		* 	to be freed for garbage collection.
		*/
		override public function destroy():void
		{
			//calling super also calls close()
			//calling close() implies a call to stopDelay()
			//which also nulls the delay timer reference
			//calling super also clean the underlying
			super.destroy();
			_elements = null;
			_current = null;
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
		override public function set paused( paused:Boolean ):void
		{
			super.paused = paused;
			//stop any delay when set to pause
			if( this.paused )
			{
				stopDelay();
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function resume():void
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
		* 	@private
		*/
		private function resourceNotFoundHandler( event:LoadEvent ):void
		{
			var element:ILoaderElement = event.loader;
			
			if( element is ILoader )
			{
				var loader:ILoader = ILoader( element );

				var options:ILoadOptions = loader.options;

				if( this.options && this.options.fatal || options && options.fatal )
				{
					throw new Error(
						"LoaderQueue fatal resource not found error: " + loader.uri );
				}
			
				if( this.options && !this.options.silent && ( options && !options.quietOnResourceNotFound ) )
				{
					dispatchEvent( event as Event );
					Notifier.dispatchEvent( event as Event );
				}
			
				if( ( this.options && this.options.silent ) || ( options && options.continueOnResourceNotFound ) )
				{
					next();
				}
			
				removeCompositeListeners( loader );
			
				if( ( this.options && !this.options.silent ) && ( options && !options.continueOnResourceNotFound ) )
				{
					//if we don't continue on resource not found
					//we are complete and not currently loading
					//dispatch the complete event after the resource
					//not found event - this also resets the loading
					//and complete flags
					dispatchLoadCompleteEvent();
				}
			}
		}
		
		/**
		* 	@private
		*/
		private function resourceLoaded( event:LoadEvent ):void
		{
			if( event.loader is ILoader )
			{
				var loader:ILoader = ILoader( event.loader );
				
				//must be direct child loader to add the resource
				//nested loader queues have their lists added to maintain
				//the tree structure 
				if( getLoaderIndex( loader ) > -1 )
				{
					var resource:IResource = IResource( loader.resource );
					if( resource )
					{
						resource.id = loader.id;
						resources.addResource( resource );
					}
				}
			}

			dispatchEvent( event as Event );
			next();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getResourceById( id:String, list:String = null ):IResource
		{
			return this.resources.getResourceById( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getResourceListById( id:String ):IResourceList
		{
			return this.resources.getResourceListById( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getAllResources():Array
		{
			return this.resources.getAllResources();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get resources():IResourceList
		{
			return IResourceList( this.resource );
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
						//TODO
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
				_elements.unshift( loader );
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
				_elements.splice( index - 1, 0, loader );
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
				_elements.splice( index + 1, 0, removed );	
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
				_elements.push( removed );
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
					_elements.splice( priority, 0, removed );	
					return true;
				}	
			}
			return false;
		}
	}	
}