package org.flashx.io.loaders.resources {
	
	import flash.utils.ByteArray;
	
	/**
	*	Represents a loaded resource that is binary data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class BinaryResource extends AbstractResource {
		
		/**
		* 	Creates a <code>BinaryResource</code> instance.
		* 
		* 	@param data The data this resource encapsulates.
		* 	@param uri The <code>URI</code> the data was loaded from.
		* 	@param bytesTotal The total number of bytes loaded.
		*/
		public function BinaryResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		/**
		* 	The data for this resource coerced to a byte array.
		*/
		public function get bytes():ByteArray
		{
			return ByteArray( this.data );
		}
	}
}