package com.ffsys.io.loaders.resources {
	
	import flash.display.Loader;
	
	/**
	*	Represents a remote resource that encapsulates
	*	a flash movie containing embedded fonts.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.06.2010
	*/
	public class FontResource extends AbstractResource {
		
		public function FontResource(
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
	}
}