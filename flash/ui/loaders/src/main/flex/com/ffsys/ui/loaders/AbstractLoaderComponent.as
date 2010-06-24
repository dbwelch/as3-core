package com.ffsys.ui.loaders
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.events.*;
	
	import com.ffsys.ui.core.InteractiveComponent;
	import com.ffsys.ui.core.IComponent;
	import com.ffsys.ui.core.UIComponent;
	import com.ffsys.ui.core.IMaskComponent;
	import com.ffsys.ui.core.MaskComponent;
	import com.ffsys.ui.graphics.IComponentGraphic;
	
	import com.ffsys.effects.tween.ITween;
	import com.ffsys.effects.events.ITweenEvent;
	import com.ffsys.effects.events.TweenEvent;

	/**
	*	Abstract super class for instances that load visual assets
	* 	and add them to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class AbstractLoaderComponent extends InteractiveComponent
		implements ILoaderComponent
	{	
		private var _queue:ILoaderQueue = new LoaderQueue();
		private var _container:IComponent;
		private var _loader:ILoader;
		private var _urls:Array;
		private var _masked:Boolean;
		private var _masker:IMaskComponent;
		
		private var _reveal:ITween;
		private var _hide:ITween;
		private var _automatic:Boolean;
		private var _pauseTime:Number = 5000;
		private var _playing:Boolean;
		private var _started:Boolean;
		private var _index:uint = 0;
		private var _loops:Boolean = false;
		
		private var _pauseTimeElapsed:Boolean = false;
		private var _timer:Timer;
	
		/**
		* 	Creates an <code>AbstractLoaderComponent</code> instance.
		* 
		* 	@param urls An array of urls to load.
		*/
		public function AbstractLoaderComponent( urls:Array = null )
		{
			super();
			this.urls = urls;
			_container = new UIComponent();
			addChild( DisplayObject( _container ) );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get masked():Boolean
		{
			return _masked;
		}
		
		public function set masked( masked:Boolean ):void
		{
			if( _masker && contains( DisplayObject( _masker ) ) )
			{
				removeChild( DisplayObject( _masker ) );
				_container.mask = null;
			}
			
			_masked = masked;
			
			if( this.masked )
			{
				_masker = new MaskComponent(
					this.preferredWidth,
					this.preferredHeight );
				addChild( DisplayObject( _masker ) );
				_container.mask = DisplayObject( _masker );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get masker():IMaskComponent
		{
			return _masker;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get reveal():ITween
		{
			return _reveal;
		}
		
		public function set reveal( reveal:ITween ):void
		{
			_reveal = reveal;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get hide():ITween
		{
			return _hide;
		}
		
		public function set hide( hide:ITween ):void
		{
			_hide = hide;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get loops():Boolean
		{
			return _loops;
		}
		
		public function set loops( loops:Boolean ):void
		{
			_loops = loops;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get playing():Boolean
		{
			return _playing;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get index():uint
		{
			return _index;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get started():Boolean
		{
			return _started;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function start():void
		{
			if( playing )
			{
				return;
			}

			revealItemAtIndex( index );
			
			_playing = true;
			_started = true;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function stop():void
		{
			if( !playing )
			{
				return;
			}
			
			//TODO: stop any running reveal/hide effects.
			
			if( _timer )
			{
				_timer.stop();
				_timer = null;
			}
			
			_playing = false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get length():uint
		{
			return 0;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasNextItem():Boolean
		{
			return this.length > 1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasPreviousItem():Boolean
		{
			return this.length > 1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function next():void
		{
			trace("AbstractLoaderComponent::next()", hasNextItem() );
			
			if( !hasNextItem() )
			{
				return;
			}
			
			trace("AbstractLoaderComponent::next()", this.index );
			
			_index = getConstrainedIndex( this.index + 1 );
			
			trace("AbstractLoaderComponent::next() after constrain: ", this.index );
			
			revealItemAtIndex( _index );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function previous():void
		{
			if( !hasPreviousItem() )
			{
				return;
			}
			
			_index = getConstrainedIndex( this.index - 1 );
			revealItemAtIndex( _index );
		}
		
		/**
		* 	@private
		* 
		* 	Constrains the slideshow index so it wraps around in
		* 	both directions.
		*/
		private function getConstrainedIndex( index:uint ):uint
		{
			if( loops )
			{
				if( index < 0 )
				{
					return length - 1;
				}else if( index >= length )
				{
					return 0;
				}
			}
			
			return index;
		}
		
		/**
		* 	Gets a display object for a given index in the slideshow.
		* 
		* 	This method does nothing by default, concrete implementations
		* 	should return the display object to display at this index.
		* 
		* 	@param index The index for the display object.
		* 
		* 	@return The target display object for this item in the slideshow.
		*/
		protected function getSlideShowItemAtIndex(
			index:uint ):DisplayObject
		{
			return null;
		}
		
		/**
		* 	@private
		*/
		private function revealItemAtIndex( index:uint ):void
		{
			var item:DisplayObject = getSlideShowItemAtIndex( index );
			
			trace("AbstractLoaderComponent::revealItemAtIndex()", item, reveal );
			
			_pauseTimeElapsed = false;
			
			if( item )
			{
				if( reveal )
				{
					var effect:ITween = reveal;
					
					//update the target for the effect
					effect.target = item;
					
					//initialize all property values to the start values
					effect.initialize();
					
					//start the effect
					effect.addEventListener( TweenEvent.COLLECTION_COMPLETE, revealComplete );
					effect.start();
					
					trace("AbstractLoaderComponent::revealItemAtIndex()", "STARTING REVEAL EFFECT" );
				}else{
					
					removePreviousItem( getCurrentItem() );
					startPauseTimer();
				}
				
				_container.addChild( item );
			}
		}
		
		/**
		*	Gets the current slide show item by retrieving the child
		* 	display object at the highest depth.
		* 
		* 	@return The current slide show item. 
		*/
		protected function getCurrentItem():DisplayObject
		{
			if( _container.numChildren > 0 )
			{
				return _container.getChildAt( _container.numChildren - 1 );
			}
			
			return null;
		}
		
		/**
		* 	Removes the previous slideshow display object now that
		* 	the current slide show item has hidden it.
		* 
		* 	@param item The current slideshow item.
		* 
		* 	@return The display object that was removed.
		*/
		protected function removePreviousItem( item:DisplayObject ):DisplayObject
		{
			if( item && item.parent )
			{
				var index:uint = item.parent.getChildIndex( item );
				
				if( index > 0 )
				{
					var previous:DisplayObject = item.parent.getChildAt( index - 1 );
					trace("AbstractLoaderComponent::removePreviousItem()", item, previous );
					return item.parent.removeChild( previous );
				}
			}
			
			return null;
		}
		
		/**
		* 	Invoked when the reveal is complete.
		*/
		private function revealComplete( event:ITweenEvent ):void
		{
			trace("AbstractLoaderComponent::revealComplete()", this );
			
			Event( event ).target.removeEventListener(
				Event( event ).type, arguments.callee );
				
			if( hide == null )
			{
				removePreviousItem( getCurrentItem() );
			}
				
			startPauseTimer();
		}
		
		/**
		*	@private
		* 	
		* 	Starts the pause timer.
		*/
		private function startPauseTimer():void
		{
			//TODO: implement the timer logic
			
			//_pauseTimeElapsed = true;
			
			/*
			removePreviousItem( getCurrentItem() );
			next();
			*/
			
			trace("AbstractLoaderComponent::startPauseTimer()", _pauseTime );
			
			if( _timer )
			{
				_timer.stop();
			}
			
			_timer = new Timer( _pauseTime, 1 );
			_timer.addEventListener( TimerEvent.TIMER_COMPLETE, pauseTimerComplete );
			_timer.start();
		}
		
		/**
		* 	@private
		*/
		private function pauseTimerComplete( event:TimerEvent ):void
		{
			trace("AbstractLoaderComponent::pauseTimerComplete()");
			
			_timer.removeEventListener(
				TimerEvent.TIMER_COMPLETE, pauseTimerComplete );
			_timer.stop();
			_timer = null;
			_pauseTimeElapsed = true;
			next();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get automatic():Boolean
		{
			return _automatic;
		}
		
		public function set automatic( automatic:Boolean ):void
		{
			_automatic = automatic;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get pauseTime():Number
		{
			return _pauseTime;
		}
		
		public function set pauseTime( pauseTime:Number ):void
		{
			if( pauseTime < 100 )
			{
				throw new Error( "The pause time must be greater than 100 milliseconds." );
			}
			
			_pauseTime = pauseTime;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get urls():Array
		{
			return _urls;
		}
		
		public function set urls( urls:Array ):void
		{
			_urls = urls;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get container():IComponent
		{
			return _container;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get uri():String
		{
			if( loader )
			{
				return loader.uri;
			}
			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get loader():ILoader
		{
			return _loader;
		}
		
		public function hasUrls():Boolean
		{
			return ( this.urls != null ) && ( this.urls.length > 0 );
		}
		
		/**
		* 	Gets the loader used to load the runtime asset.
		* 
		* 	@param url The url to load.
		* 
		*	@return The loader that is responsible for loading
		* 	the asset.
		*/
		protected function getLoader( url:String ):ILoader
		{
			throw new Error( "You must implement the get loader method in your concrete implementation." );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function load():void
		{
			if( !hasUrls() )
			{
				throw new Error( "Cannot load with no urls." );
			}
			
			trace("AbstractLoaderComponent::load()", this.urls );
			
			var loader:ILoader = null;
			for( var i:int = 0;i < this.urls.length;i++ )
			{
				loader = getLoader( this.urls[ i ] );
				_queue.addLoader( loader.request, loader );
			}
			
			removeLoaderListeners();
			addLoaderListeners();
				
			//start loading the queue
			_queue.load();
		}
		
		/**
		* 	Closes any open load process.
		*/
		public function close():void
		{
			_queue.close();
		}
		
		/**
		*	@inheritDoc 
		*/
		override protected function createChildren():void
		{
			//
		}
		
		/**
		* 	@private
		*/
		private function addLoaderListeners():void
		{
			_queue.addEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound, false, 0, false );
			
			_queue.addEventListener(
				LoadStartEvent.LOAD_START,
				loadStart, false, 0, false );
				
			_queue.addEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				loadProgress, false, 0, false );
			
			_queue.addEventListener(
				LoadEvent.DATA,
				loadComplete, false, 0, false );
				
			_queue.addEventListener(
				LoadCompleteEvent.LOAD_COMPLETE,
				completed, false, 0, false );
		}
		
		/**
		* 	@private
		*/
		private function removeLoaderListeners():void
		{
			_queue.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				resourceNotFound );
			
			_queue.removeEventListener(
				LoadStartEvent.LOAD_START,
				loadStart );
				
			_queue.removeEventListener(
				LoadProgressEvent.LOAD_PROGRESS,
				loadProgress );
			
			_queue.removeEventListener(
				LoadEvent.DATA,
				loadComplete );
				
			_queue.addEventListener(
				LoadCompleteEvent.LOAD_COMPLETE,
				completed );
		}
		
		/**
		*	@private
		*/
		protected function loadStart( event:ILoadEvent ):void
		{
			//TODO: wrap these in a custom event
			//trace("AbstractLoaderComponent::loadStart()");
		}
		
		/**
		*	@private
		*/
		protected function resourceNotFound(
			event:ILoadEvent ):void
		{
			//TODO: wrap these in a custom event
			//trace("AbstractLoaderComponent::resourceNotFound()");
		}
		
		/**
		*	@private
		*/
		protected function loadProgress( 
			event:ILoadEvent ):void
		{
			//TODO: wrap these in a custom event
			//trace("AbstractLoaderComponent::loadProgress()");
		}
		
		/**
		*	@private
		*/
		protected function loadComplete( 
			event:ILoadEvent ):void
		{
			//set to start automatically and not playing
			if( automatic && !started )
			{
				start();
			}else if( started && _pauseTimeElapsed && hasNextItem() )
			{
				next();
			}
			
			if( this.border )
			{
				this.border.draw( this.width, this.height );
			}
		
			if( this.background )
			{
				this.background.draw( this.width, this.height );
			}
		}
		
		/**
		*	@private
		*/
		protected function completed( 
			event:ILoadEvent ):void
		{
			//TODO: wrap these in a custom event	
			//trace("AbstractLoaderComponent::loadComplete()");
			
			//cleanup the listeners
			removeLoaderListeners();
		}
	}
}