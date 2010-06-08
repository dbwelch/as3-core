package com.ffsys.io.loaders.resources {
	
	import com.ffsys.io.loaders.types.ITextAccess;
	
	/**
	*	Represents a loaded resource that is String data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class TextResource extends AbstractResource
		implements ITextAccess {
		
		public function TextResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		public function get text():String
		{
			return String( this.data );
		}
		
	}
	
}