package com.ffsys.io.loaders.types {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.utils.ByteArray;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractDisplayLoader;
	import com.ffsys.io.loaders.core.LoadOptions;
	
	import com.ffsys.io.loaders.display.IDisplayMovie;
	
	import com.ffsys.io.loaders.events.MovieLoadEvent;
	
	import com.ffsys.io.loaders.resources.MovieResource;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Represents a loader for Flash swf movies.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class MovieLoader extends AbstractDisplayLoader {
		
		public function MovieLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
				
			resource = new MovieResource( loader, uri, bytesTotal );
			
			var evt:MovieLoadEvent = new MovieLoadEvent(
				event,
				this,
				resource as MovieResource
			);
			
			if( queue )
			{
				queue.addResource( this );
			}
			
			super.completeHandler( event );
			
			dispatchEvent( evt );
			
			Notifier.dispatchEvent( evt );
	
			dispatchLoadCompleteEvent();
			
			//removeListeners();
			
			//clean our reference to the underlying Loader
			_loader = null;
        }

	}
	
}
