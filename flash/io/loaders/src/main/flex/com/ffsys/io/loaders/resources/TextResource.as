package com.ffsys.io.loaders.resources {
	
	/**
	*	Represents a loaded resource that is text.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class TextResource extends AbstractResource {
		
		/**
		* 	Creates a <code>TextResource</code> instance.
		* 
		* 	@param data The data this resource encapsulates.
		* 	@param uri The <code>URI</code> the data was loaded from.
		* 	@param bytesTotal The total number of bytes loaded.
		*/
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
