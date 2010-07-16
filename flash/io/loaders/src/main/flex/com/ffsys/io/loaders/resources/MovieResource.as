package com.ffsys.io.loaders.resources {
	
	import flash.display.Loader;
	
	import com.ffsys.io.loaders.display.IDisplayMovie;
	import com.ffsys.io.loaders.display.MovieDisplay;
	
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
	public class MovieResource extends AbstractResource {
		
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
	}
}