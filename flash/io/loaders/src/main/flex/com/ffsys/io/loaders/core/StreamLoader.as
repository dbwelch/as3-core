package com.ffsys.io.loaders.core {
	
	import flash.net.URLStream;
	import flash.net.URLRequest;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	
	import flash.utils.ByteArray;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.LoadStartEvent;
	import com.ffsys.io.loaders.events.LoadCompleteEvent;
	import com.ffsys.io.loaders.events.ResourceNotFoundEvent;
	
	import com.ffsys.io.loaders.message.ILoadMessage;
	
	import com.ffsys.io.loaders.resources.BinaryResource;
	import com.ffsys.io.loaders.events.BinaryLoadEvent;
	
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceList;
	
	import com.ffsys.utils.identifier.IdentifierUtils;
	
	/* BEGIN OBJECT_INSPECTOR REMOVAL */
	import com.ffsys.utils.inspector.ObjectInspector;
	import com.ffsys.utils.inspector.ObjectInspectorOptions;	
	/* END OBJECT_INSPECTOR REMOVAL */
	
	/**
	*	Represents a loader that loads arbritrary binary
	*	streams.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2007
	*/
	public class StreamLoader extends URLStream
		implements ILoader {
		
		/**
		*	@private	
		*/
		protected var _bytes:ByteArray;
		
		/**
		*	@private	
		*/		
		protected var _loading:Boolean;
	
		/**
		*	@private	
		*/		
		protected var _loaded:Boolean;
	
		/**
		*	@private	
		*/		
		protected var _complete:Boolean;		
		
		/**
		*	@private	
		*/		
		private var _decorator:LoaderDecorator;
		
		//declared to match the behaviour of URLLoader
		public var bytesLoaded:uint;
		public var bytesTotal:uint;		
		
		public function StreamLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			_decorator = new LoaderDecorator( request, options );
			
			super();
		}
		
		public function get bytes():ByteArray
		{
			return _bytes;
		}
		
        protected function addListeners():void
		{
            addEventListener(
				Event.COMPLETE, completeHandler, false, 0, true );
				
            addEventListener(
				Event.OPEN, openHandler, false, 0, true );
				
            addEventListener(
				ProgressEvent.PROGRESS, progressHandler, false, 0, true );
				
            addEventListener(
				SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true );
				
            addEventListener(
				HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true );
				
            addEventListener(
				IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
        }

		protected function removeListeners():void
		{
            removeEventListener(
				Event.COMPLETE, completeHandler );
				
            removeEventListener(
				Event.OPEN, openHandler );
				
            removeEventListener(
				ProgressEvent.PROGRESS, progressHandler );
				
            removeEventListener(
				SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
				
            removeEventListener(
				HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
				
            removeEventListener(
				IOErrorEvent.IO_ERROR, ioErrorHandler );			
		}
		
		public function addResponderListeners(
			target:IEventDispatcher,
			startMethod:Function = null,
			progressMethod:Function = null,			
			loadedMethod:Function = null,
			resourceNotFoundMethod:Function = null ):void
		{
			
			if( !target )
			{
				throw new Error( "ILoader: cannot modify responder listeners on a null target." );
			}
			
			if( startMethod != null )
			{
				addEventListener(
					LoadStartEvent.LOAD_START, startMethod, false, 0, true );
			}
			
			if( progressMethod != null )
			{
				addEventListener(
					LoadProgressEvent.LOAD_PROGRESS, progressMethod, false, 0, true );
			}			
			
			if( loadedMethod != null )
			{
				addEventListener(
					LoadEvent.DATA, loadedMethod, false, 0, true );
			}
			
			if( resourceNotFoundMethod != null )
			{
				addEventListener(
					ResourceNotFoundEvent.RESOURCE_NOT_FOUND, resourceNotFoundMethod, false, 0, true );
			}

		}
		
		public function removeResponderListeners(
			target:IEventDispatcher,
			startMethod:Function = null,
			progressMethod:Function = null,			
			loadedMethod:Function = null,
			resourceNotFoundMethod:Function = null ):void
		{
			
			if( !target )
			{
				throw new Error( "ILoader: cannot modify responder listeners on a null target." );
			}
			
			if( startMethod != null )
			{
				removeEventListener( LoadStartEvent.LOAD_START, startMethod );
			}
			
			if( progressMethod != null )
			{
				removeEventListener( LoadProgressEvent.LOAD_PROGRESS, progressMethod );
			}			
			
			if( loadedMethod != null )
			{
				removeEventListener( LoadEvent.DATA, loadedMethod );
			}
			
			if( resourceNotFoundMethod != null )
			{
				removeEventListener( ResourceNotFoundEvent.RESOURCE_NOT_FOUND, resourceNotFoundMethod );
			}

		}
		
		/*
		*	ILoadStatus implementation.	
		*/
		
		/**
		*	@inheritDoc	
		*/
		public function get loading():Boolean
		{
			return _loading;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get complete():Boolean
		{
			return _complete;
		}
		
		/**
		*	@inheritDoc	
		*/		
		override public function load( request:URLRequest ):void
		{
			_bytes = new ByteArray();
			
			bytesLoaded = 0;
			bytesTotal = 0;
			
			this.request = request;
			
			removeListeners();
			addListeners();			

			_loading = true;
			_loaded = false;
			_complete = false;
			
			super.load( request );			
		}

		/**
		*	@private	
		*/
        protected function completeHandler(
			event:Event,
			data:Object = null ):void
		{
			loadSuccess();
			
			if( bytes )
			{
				resource = new BinaryResource( bytes );
				
				var evt:BinaryLoadEvent = new BinaryLoadEvent(
					event,
					this,
					resource as BinaryResource
				);
				
				if( queue )
				{
					queue.addResource( this );
				}
				
				dispatchEvent( evt );
				
				Notifier.dispatchEvent( evt );
			}
			
			dispatchLoadCompleteEvent();
        }

		/**
		*	@private	
		*/
        protected function openHandler( event:Event ):void
		{
			var evt:LoadStartEvent = new LoadStartEvent( event, this );
			dispatchEvent( evt as Event );
			Notifier.dispatchEvent( evt as Event );
        }

		public function getBytesLoaded():uint
		{
			return bytesLoaded;
		}
		
		public function getBytesTotal():uint
		{
			return bytesTotal;
		}

		/**
		*	@private	
		*/
        protected function progressHandler( event:ProgressEvent ):void
		{
			var evt:LoadProgressEvent = new LoadProgressEvent( event, this );
			dispatchEvent( evt as Event );
			Notifier.dispatchEvent( evt as Event );
        }

		/**
		*	@private	
		*/
		protected function loadSuccess():void
		{
			//successful load event
			_loaded = true;
			_loading = false;
			_complete = true;
		}

		/**
		*	@private	
		*/
		protected function loadFailure():void
		{
			//we've stopped loading and
			//the resource was not successfully loaded
			_loaded = false;
			_loading = false;
			_complete = true;
		}

		/**
		*	@private	
		*/
        protected function securityErrorHandler( event:SecurityErrorEvent ):void
		{
			loadFailure();
			
			//-->
            trace( "securityErrorHandler: " + event );
			
			/*
			dispatchEvent( event as Event );
			Notifier.dispatchEvent( event as Event );
			*/
        }

		/**
		*	@private	
		*/
        protected function httpStatusHandler( event:HTTPStatusEvent ):void
		{
			//trace( "Http status : " + event.status );
		
			if( event.status == 404 )
			{
				dispatchResourceNotFoundEvent( event );
			}else{
			
				//--> stack overflow on clone() ???
				//dispatchEvent( event as Event );
				
				Notifier.dispatchEvent( event as Event );
			}
        }

		/**
		*	@private	
		*/
        protected function ioErrorHandler( event:IOErrorEvent ):void
		{
			dispatchResourceNotFoundEvent( event );
        }

		/**
		*	@private	
		*/
		protected function dispatchLoadCompleteEvent():void
		{
			removeListeners();
			
			var event:Event = new Event( Event.COMPLETE );
			var evt:LoadCompleteEvent = new LoadCompleteEvent( event, this );
			
			dispatchEvent( evt );
			
			Notifier.dispatchEvent( evt );
		}
		
		/**
		*	@private	
		*/		
		protected function dispatchResourceNotFoundEvent(
			event:Event, loader:ILoader = null ):void
		{
			removeListeners();
		
			close();
			
			loadFailure();
			
			if( !loader )
			{
				try {
					loader = ILoader( event.target );
				}catch( e:Error )
				{
					loader = this as ILoader;
				}
			}
			
			/*
			trace( "Resource not found uri : " + this.uri );
			trace( "Resource not found quiet : " + options.quietOnResourceNotFound );
			trace( "Resource not found continue : " + options.continueOnResourceNotFound );
			*/
			
			if( !queue && options.fatal )
			{
				throw new Error(
					"ILoader fatal resource not found error: " + this.uri );
			}
			
			var evt:ResourceNotFoundEvent =
				new ResourceNotFoundEvent( event as Event, loader );
			
			//ensure a queue always receives the ResourceNotFoundEvent
			if( queue )
			{
				queue.resourceNotFoundHandler( evt );
			}
			
			if( !queue && !options.quietOnResourceNotFound )
			{
				dispatchEvent( evt as Event );
				Notifier.dispatchEvent( evt as Event );
			}
			
		}
		
		/*
		*	ILoaderParameters implementation.
		*/

		/**
		*	@inheritDoc	
		*/
		public function set list( val:IResourceList ):void
		{
			_decorator.list = val;
		}
		
		public function get list():IResourceList
		{
			return _decorator.list;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set customData( val:Object ):void
		{
			_decorator.customData = val;
		}
		
		public function get customData():Object
		{
			return _decorator.customData;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set message( val:ILoadMessage ):void
		{
			_decorator.message = val;
		}
		
		public function get message():ILoadMessage
		{
			return _decorator.message;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set resource( val:IResource ):void
		{
			_decorator.resource = val;
		}
		
		public function get resource():IResource
		{
			return _decorator.resource;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set id( val:String ):void
		{
			_decorator.id = val;
		}
		
		public function get id():String
		{
			return _decorator.id;
		}		
		
		/**
		*	@inheritDoc	
		*/		
		public function set request( val:URLRequest ):void
		{
			_decorator.request = val;
		}
		
		public function get request():URLRequest
		{
			return _decorator.request;
		}		
		
		/**
		*	@inheritDoc	
		*/		
		public function set queue( val:ILoaderQueue ):void
		{
			_decorator.queue = val;
		}
		
		public function get queue():ILoaderQueue
		{
			return _decorator.queue;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set options( val:ILoadOptions ):void
		{
			_decorator.options = val;
		}
		
		public function get options():ILoadOptions
		{
			return _decorator.options;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set uri( val:String ):void
		{
			_decorator.uri = val;
		}
		
		public function get uri():String
		{
			return _decorator.uri;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set callback( val:String ):void
		{
			_decorator.callback = val;
		}
		
		public function get callback():String
		{
			return _decorator.callback;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set forceLoad( val:Boolean ):void
		{
			_decorator.forceLoad = val;
		}
		
		public function get forceLoad():Boolean
		{
			return _decorator.forceLoad;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function getParentId():String
		{
			return IdentifierUtils.getParentId( uri );
		}					
		
		/**
		*	@inheritDoc	
		*/		
		override public function close():void
		{
			try {
				super.close();
				
				//if we closed the stream we should remove our
				//listeners
				removeListeners();
				
				//only set these flags if the above attempt to
				//close the underlying stream did not throw an
				//error - if it did there is no stream to close
				//and hence no need to set any flags as they should
				//already have been set

				//we're no longer loading, we're not loaded
				//either as we've been closed early, but complete
				//is true as there is nothing else to do with this
				//load stream
				loadFailure();
				
			}catch( e:Error )
			{
				//we don't want an invalid stream error
				//thrown when attempting to close a URLLoader
				//with no open stream
			}
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
			output.customData = customData;
			output.message = message;
			return output;
		}

		/**
		*	@private	
		*/
		public function getCommonStringOutputComposites():Array
		{
			var output:Array = new Array();
			output.push( options );
			return output;
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

			output.detail = uri;

			//pass in the default methods, properties and composites
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
		*	@return The <code>String</code> representation
		*	of this instance.
		*/
		override public function toString():String
		{
			return getObjectString( true );
		}		
		/* END OBJECT_INSPECTOR REMOVAL */
	}
}