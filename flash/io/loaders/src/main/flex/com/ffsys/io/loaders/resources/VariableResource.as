package com.ffsys.io.loaders.resources {
	
	import flash.net.URLVariables;
	
	/**
	*	Represents a remote resource that encapsulates variables.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public class VariableResource extends AbstractResource {
		
		public function VariableResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		public function get variables():URLVariables
		{
			return URLVariables( this.data );
		}
	}
}