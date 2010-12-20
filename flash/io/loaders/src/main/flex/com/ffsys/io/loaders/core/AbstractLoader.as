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
		implements ILoader {
	
		private var _request:URLRequest;
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
		* 
		* 	@param target The target event dispatcher.
		*/
        override protected function addCompositeListeners( target:IEventDispatcher ):void
		{
			if( target )
			{
	            target.addEventListener(
					Event.COMPLETE, completeHandler );
				
	            target.addEventListener(
					Event.OPEN, openHandler );
				
	            target.addEventListener(
					ProgressEvent.PROGRESS, progressHandler );
				
	            target.addEventListener(
					SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
				
	            target.addEventListener(
					HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
				
	            target.addEventListener(
					IOErrorEvent.IO_ERROR, ioErrorHandler );
			}
        }

		/**
		*	Removes listeners from this implementation.
		* 
		* 	Concrete implementations can modify the default behaviour
		* 	of removing event listeners from the <code>URLLoader</code> super class.
		* 
		* 	@param target The target event dispatcher.
		*/
		override protected function removeCompositeListeners( target:IEventDispatcher ):void
		{
			if( target )
			{			
	            target.removeEventListener(
					Event.COMPLETE, completeHandler );
				
	            target.removeEventListener(
					Event.OPEN, openHandler );
				
	            target.removeEventListener(
					ProgressEvent.PROGRESS, progressHandler );
				
	            target.removeEventListener(
					SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
				
	            target.removeEventListener(
					HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
			
	            target.removeEventListener(
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
				removeCompositeListeners( IEventDispatcher( _composite ) );
			}
			
			_composite = new URLLoader();
			
			if( dataFormat != null )
			{
				_composite.dataFormat = dataFormat;
			}
			
			addCompositeListeners( IEventDispatcher( _composite ) );
			
			_bytesLoaded = 0;
			_bytesTotal = 0;
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
			//clean our listeners as we loaded successfully
			removeCompositeListeners( IEventDispatcher( _composite ) );
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
			removeCompositeListeners( IEventDispatcher( _composite ) );
		
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
		
		/**
		* 	Adds the ability for loader implementations
		* 	to aumatically generate an identifier based
		* 	on the file name of the resource.
		*/
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
				removeCompositeListeners( IEventDispatcher( _composite ) );
				
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
		
		/**
		*	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_request = null;
			_callback = null;
			dataFormat = null;
			_composite = null;
		}
	}
}