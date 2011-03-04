package com.ffsys.io.loaders.resources {
	
	import flash.display.Loader;
	
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
		
		/**
		* 	Creates a <code>MovieResource</code> instance.
		* 
		* 	@param data The data this resource encapsulates.
		* 	@param uri The <code>URI</code> the data was loaded from.
		* 	@param bytesTotal The total number of bytes loaded.
		*/
		public function MovieResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		/**
		* 	The data for this resource coerced to a loader.
		*/		
		public function get loader():Loader
		{
			return Loader( data );
		}
		
		/**
		*	@inheritDoc
		*/
		override public function destroy():void
		{
			if( loader )
			{
				loader.unload();
			}
			super.destroy();
		}
	}
}