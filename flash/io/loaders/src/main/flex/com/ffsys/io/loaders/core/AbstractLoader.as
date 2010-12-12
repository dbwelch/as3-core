package com.ffsys.io.loaders.core {
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.message.ILoadMessage;
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceList;
	
	import com.ffsys.utils.identifier.IdentifierUtils;	
	
	/**
	*	Abstract super class for loader implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class AbstractLoader extends LoaderElement
		implements 	ILoader {
	
		private var _request:URLRequest;
		private var _message:ILoadMessage;
		private var _callback:String;
		
		/**
		* 	@private
		*/
		protected var dataFormat:String = null;			
			
		/**
		* 	@private
		*/
		protected var _composite:Object;
		
		/**
		*	Creates an <code>AbstractLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function AbstractLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super();
			this.request = request;
			if( options )
			{
				this.options = options;
			}
		}
		
		/**
		* 	The composite object handling the load process.
		* 
		* 	This is a <code>URLLoader</code> by default.
		*/
		public function get composite():Object
		{
			return _composite;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get message():ILoadMessage
		{
			return _message;
		}
		
		public function set message( message:ILoadMessage ):void
		{
			_message = message;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get callback():String
		{
			return _callback;
		}

		public function set callback( callback:String ):void
		{
			_callback = callback;
		}
		
		/**
		*	Adds listeners to this implementation.
		* 
		* 	Concrete implementations can modify the default behaviour
		* 	of adding event listeners to the <code>URLLoader</code> super class.
		*/
        protected function addListeners():void
		{
			if( _composite )
			{
	            _composite.addEventListener(
					Event.COMPLETE, completeHandler, false, 0, true );
				
	            _composite.addEventListener(
					Event.OPEN, openHandler, false, 0, true );
				
	            _composite.addEventListener(
					ProgressEvent.PROGRESS, progressHandler, false, 0, true );
				
	            _composite.addEventListener(
					SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true );
				
	            _composite.addEventListener(
					HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true );
				
	            _composite.addEventListener(
					IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
			}
        }

		/**
		*	Removes listeners from this implementation.
		* 
		* 	Concrete implementations can modify the default behaviour
		* 	of removing event listeners from the <code>URLLoader</code> super class.
		*/
		protected function removeListeners():void
		{
			if( _composite )
			{			
	            _composite.removeEventListener(
					Event.COMPLETE, completeHandler );
				
	            _composite.removeEventListener(
					Event.OPEN, openHandler );
				
	            _composite.removeEventListener(
					ProgressEvent.PROGRESS, progressHandler );
				
	            _composite.removeEventListener(
					SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
				
	            _composite.removeEventListener(
					HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			
	            _composite.removeEventListener(
					IOErrorEvent.IO_ERROR, ioErrorHandler );
			}
		}
		
		/**
		*	@inheritDoc
		*/
		override public function load():void
		{
			if( this.request == null )
			{
				throw new Error( "Cannot load with a null url request." );
			}
			
			if( _composite )
			{
				close();
				removeListeners();
			}
			
			_composite = new URLLoader();
			
			if( dataFormat != null )
			{
				_composite.dataFormat = dataFormat;
			}
			
			addListeners();
				
			_loading = true;
			_loaded = false;
			_complete = false;
			
			URLLoader( _composite ).load( this.request );
		}

		/**
		*	Invoked when the load operation is complete.
		* 
		* 	@param event The event that triggered this event.
		* 	@param data The data associated with the complete event.	
		*/
        protected function completeHandler(
			event:Event,
			data:Object = null ):void
		{
			loadSuccess();
        }
		
		/**
		*	@private	
		*/
		protected function loadSuccess():void
		{
			//trace("AbstractLoader::loadSuccess(), " + uri );
			
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
        protected function progressHandler( event:ProgressEvent ):void
		{
			_bytesLoaded = event.bytesLoaded;
			_bytesTotal = event.bytesTotal;
			
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.LOAD_PROGRESS, event, this );
			dispatchEvent( evt as Event );
			Notifier.dispatchEvent( evt as Event );
        }

		/**
		*	@private	
		*/
        protected function openHandler( event:Event ):void
		{
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.LOAD_START, event, this );
			dispatchEvent( evt as Event );
			Notifier.dispatchEvent( evt as Event );
        }

		/**
		*	@private	
		*/
        protected function securityErrorHandler( event:SecurityErrorEvent ):void
		{
			loadFailure();
			
			//TODO: implement proper handling for security errors
            //trace( "securityErrorHandler: " + event );
			
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
			
			if( !queue && options.fatal )
			{
				throw new Error(
					"ILoader fatal resource not found error: " + this.uri );
			}
			
			var evt:LoadEvent =
				new LoadEvent(
					LoadEvent.RESOURCE_NOT_FOUND ,event as Event, loader );
			
			dispatchEvent( evt as Event );
			Notifier.dispatchEvent( evt as Event );
		}
		
		override public function get id():String
		{
			if( !_id && this.options && this.options.autoGenerateId )
			{
				return getAutomaticId();
			}
			return super.id;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set uri( value:String ):void
		{
			this.request = new URLRequest( value );
		}
		
		public function get uri():String
		{
			if( _request )
			{
				return _request.url;
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set request( value:URLRequest ):void
		{
			_request = value;
			if( _request && !this.id && options && options.autoGenerateId )
			{
				this.id = getAutomaticId();
			}
		}
		
		public function get request():URLRequest
		{
			return _request;
		}		
		
		/**
		*	@private	
		*/
		private function getAutomaticId():String
		{
			if( this.uri )
			{
				return IdentifierUtils.getFileNameId( this.uri );
			}
			return null;
		}
		
		/**
		*	@inheritDoc
		*/		
		override public function close():void
		{
			try {
				URLLoader( _composite ).close();
				
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
	}
}