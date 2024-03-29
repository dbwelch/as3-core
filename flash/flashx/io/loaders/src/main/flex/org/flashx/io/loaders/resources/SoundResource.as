package org.flashx.io.loaders.resources {
	
	import flash.media.Sound;
	
	/**
	*	Represents a loaded resource that is a sound.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class SoundResource extends AbstractResource {
		
		/**
		* 	Creates a <code>SoundResource</code> instance.
		* 
		* 	@param data The data this resource encapsulates.
		* 	@param uri The <code>URI</code> the data was loaded from.
		* 	@param bytesTotal The total number of bytes loaded.
		*/
		public function SoundResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		public function get sound():Sound
		{
			return Sound( this.data );
		}
	}
}