package com.ffsys.io.loaders.resources {

	/**
	*	Represents a loaded resource that is an object.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class ObjectResource extends AbstractResource {
		
		public function ObjectResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
	}
}