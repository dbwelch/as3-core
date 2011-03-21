package org.flashx.io.loaders.core {

	import flash.events.Event;
	import flash.events.IEventDispatcher;	
	import flash.net.URLStream;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	
	import org.flashx.events.Notifier;
	
	import org.flashx.io.loaders.events.LoadEvent;
	import org.flashx.io.loaders.resources.BinaryResource;
	import org.flashx.io.loaders.resources.IResource;
	import org.flashx.io.loaders.resources.IResourceList;
	
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
				removeCompositeListeners( IEventDispatcher( _composite ) );
			}
			
			_composite = new URLStream();
			addCompositeListeners( IEventDispatcher( _composite ) );

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
	}
}