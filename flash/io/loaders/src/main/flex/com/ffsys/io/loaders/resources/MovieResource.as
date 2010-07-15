package com.ffsys.io.loaders.resources {
	
	import flash.display.Loader;
	
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.types.MovieLoader;
	
	import com.ffsys.io.loaders.display.IDisplayMovie;
	import com.ffsys.io.loaders.display.MovieDisplay;
	import com.ffsys.io.loaders.types.IMovieAccess;
	
	/**
	*	Represents a remote resource that encapsulates
	*	movie (swf) data that can be added to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class MovieResource extends AbstractResource
		implements IMovieAccess {
			
		protected var _accessed:Boolean;
		
		public function MovieResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		public function get loader():Loader
		{
			return Loader( data );
		}
		
		public function get movie():IDisplayMovie
		{
			if( !data )
			{
				throw new Error(
					"MovieResource, invalid data - content may have been unloaded via prior duplication." );
			}
			
			var display:IDisplayMovie;
			
			display = new MovieDisplay();
			display.uri = uri;
			display.loader = loader;
			display.bytesTotal = bytesTotal;

			return display;	
		}
		
		public function duplicate( duplicates:int = 0 ):ILoaderQueue
		{
			
			//--! loader is null but data is ok - WTF
			//--! the conditional below must test against data
			
			/*
			trace("MovieResource::duplicate(), " + loader );
			trace("MovieResource::duplicate(), " + data );
			*/
			
			//if we are using duplicates
			//the original becomes invalid
			//and needs to be unloaded
			if( data )
			{
				trace("MovieResource::duplicate(), unload original Loader" );
				Loader( data ).unload();
				data = null;
			}
			
			var queue:ILoaderQueue = new LoaderQueue();
			
			var i:int = 0;
			
			var request:URLRequest;
			var loader:MovieLoader;
			
			for( ;i < duplicates;i++ )
			{
				request = new URLRequest( uri );
				loader = new MovieLoader( request );
				queue.addLoader( request, loader );
			}
			
			return queue;
		}
		
	}
	
}
