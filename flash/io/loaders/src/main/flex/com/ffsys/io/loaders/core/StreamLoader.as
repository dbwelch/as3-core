package com.ffsys.io.loaders.core {

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;	
	import flash.net.URLStream;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.BinaryResource;
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceList;
	import com.ffsys.io.loaders.message.ILoadMessage;
	
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
	public class StreamLoader extends AbstractLoader
		implements ILoader {
			
		private var _bytes:ByteArray;
		
		/**
		* 	Creates a <code>StreamLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function StreamLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
		}				
		
		/**
		* 	The byte array of loaded bytes.
		*/
		public function get bytes():ByteArray
		{
			return _bytes;
		}
		
		/**
		* 	Adds listeners to the super class.
		*/
        override protected function addListeners():void
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
		
		/**
		* 	Removes listeners from the super class.
		*/
		override protected function removeListeners():void
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
		
		/**
		*	@inheritDoc	
		*/		
		override public function load():void
		{
			_bytes = new ByteArray();
			
			_bytesLoaded = 0;
			_bytesTotal = 0;
			
			this.request = request;
			
			if( _composite )
			{
				close();
				removeListeners();
			}
			
			_composite = new URLStream();
			addListeners();			

			_loading = true;
			_loaded = false;
			_complete = false;
			
			URLStream( _composite ).load( request );
		}

		/**
		*	@inheritDoc
		*/
        override protected function completeHandler(
			event:Event,
			data:Object = null ):void
		{
			loadSuccess();
			
			if( bytes )
			{
				resource = new BinaryResource( bytes );
				
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					resource as BinaryResource
				);
				
				dispatchEvent( evt );
				Notifier.dispatchEvent( evt );
			}
			
			dispatchLoadCompleteEvent();
        }

		/**
		*	@private	
		*/
        override protected function openHandler( event:Event ):void
		{
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.LOAD_START, event, this );
			dispatchEvent( evt as Event );
			Notifier.dispatchEvent( evt as Event );
        }

		/**
		*	@private	
		*/
        override protected function progressHandler( event:ProgressEvent ):void
		{
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.LOAD_PROGRESS, event, this );
			dispatchEvent( evt as Event );
			Notifier.dispatchEvent( evt as Event );
        }

		/**
		*	@private	
		*/
        override protected function securityErrorHandler( event:SecurityErrorEvent ):void
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
        override protected function httpStatusHandler( event:HTTPStatusEvent ):void
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
        override protected function ioErrorHandler( event:IOErrorEvent ):void
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
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.LOAD_COMPLETE, event, this );
			
			dispatchEvent( evt );
			
			Notifier.dispatchEvent( evt );
		}
		
		/**
		*	@private	
		*/		
		override protected function dispatchResourceNotFoundEvent(
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
			
			var evt:LoadEvent =
				new LoadEvent(
					LoadEvent.RESOURCE_NOT_FOUND ,event as Event, loader );
			
			//ensure a queue always receives the ResourceNotFoundEvent
			
			dispatchEvent( evt as Event );
			Notifier.dispatchEvent( evt as Event );
		}					
		
		/**
		*	Closes any open connection.
		*/		
		override public function close():void
		{
			try {
				_composite.close();
				
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