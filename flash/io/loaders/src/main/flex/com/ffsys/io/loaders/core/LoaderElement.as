package com.ffsys.io.loaders.core
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import com.ffsys.io.loaders.resources.IResourceElement;
	
	/**
	* 	Abstract super class for elements that can exist in a loader queue.
	* 
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.12.2010
	*/
	public class LoaderElement extends EventDispatcher
		implements ILoaderElement
	{
		private var _queue:ILoaderQueue;
		private var _customData:Object;
		
		/**
		* 	@private
		*/
		protected var _id:String;
		
		/**
		* 	@private
		*/
		protected var _bytesTotal:uint = 0;
		
		/**
		* 	@private
		*/
		protected var _bytesLoaded:uint = 0;
		
		/**
		* 	@private
		*/
		protected var _loading:Boolean;
		
		/**
		* 	@private
		*/
		protected var _paused:Boolean;
		
		/**
		* 	@private
		*/
		protected var _complete:Boolean;
		
		/**
		* 	@private
		*/
		protected var _loaded:Boolean;
		
		//TODO: remove the duplication between loaded/complete
		
		/**
		*	@private	
		*/	
		protected var _options:ILoadOptions;
		
		/**
		*	@private	
		*/	
		protected var _resource:IResourceElement;

		/**
		*	@private	
		*/	
		protected var _forceLoad:Boolean;		
	
		/**
		* 	Creates a <code>LoaderElement</code> instance.
		*/
		public function LoaderElement()
		{
			super();
			_options = new LoadOptions();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get options():ILoadOptions
		{
			return _options;
		}
		
		public function set options( value:ILoadOptions ):void
		{
			_options = value;
		}
		
		/**
		* 	@private
		*/
		protected function addCompositeListeners( target:IEventDispatcher ):void
		{
			//
		}		
		
		/**
		* 	@private
		*/
		protected function removeCompositeListeners( target:IEventDispatcher ):void
		{
			//
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set customData( data:Object ):void
		{
			_customData = data;
		}
		
		public function get customData():Object
		{
			return _customData;
		}		
				
		/**
		*	@inheritDoc	
		*/		
		public function set queue( queue:ILoaderQueue ):void
		{
			_queue = queue;
		}
		
		public function get queue():ILoaderQueue
		{
			return _queue;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get complete():Boolean
		{
			return _complete;
		}		
		
		/**
		* 	An identifier for this loader element.
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
			return false;
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
		}
		
		/**
		*	@inheritDoc	
		*/
		public function resume():void
		{
			//
		}		
		
		/**
		* 	The total number of bytes loaded.
		*/		
		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}
		
		/**
		* 	@inheritDoc
		*/		
		public function get bytesLoaded():uint
		{
			return _bytesLoaded;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function load():void
		{
			//
		}
		
		/**
		* 	Closes any open connections.
		*/
		public function close():void
		{
			//
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set forceLoad( val:Boolean ):void
		{
			_forceLoad = val;
		}
		
		public function get forceLoad():Boolean
		{
			return _forceLoad;
		}		
		
		/**
		*	@inheritDoc	
		*/				
		public function get resource():IResourceElement
		{
			return _resource;
		}
		
		public function set resource( value:IResourceElement ):void
		{
			_resource = value;
		}		
		
		/**
		* 	Performs destruction of this loader element.
		* 
		* 	If the element is in the process of loading a
		* 	resource the connection will be closed.
		* 
		* 	All composite references will be null after this
		* 	method is invoked.
		*/
		public function destroy():void
		{
			close();
			_resource = null;
			_id = null;
			_queue = null;
			_customData = null;
			_options = null;
		}
	}
}