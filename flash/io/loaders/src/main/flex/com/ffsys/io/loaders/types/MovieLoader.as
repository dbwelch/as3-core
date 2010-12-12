package com.ffsys.io.loaders.types {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.utils.ByteArray;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractDisplayLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.display.IDisplayMovie;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.MovieResource;
	
	/**
	*	Loads swf movies.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class MovieLoader extends AbstractDisplayLoader {
		
		/**
		* 	Creates a <code>MovieLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function MovieLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		/**
		* 	@inheritDoc
		*/
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			this.resource = new MovieResource( loader, uri, bytesTotal );
			
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.DATA,
				event,
				this,
				resource as MovieResource
			);
			
			super.completeHandler( event );
			dispatchEvent( evt );
			Notifier.dispatchEvent( evt );
			
			//clean our reference to the underlying Loader
			_composite = null;
        }
	}
}