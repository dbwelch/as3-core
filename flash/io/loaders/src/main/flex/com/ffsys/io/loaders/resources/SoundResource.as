package com.ffsys.io.loaders.resources {
	
	import flash.media.Sound;
	
	import com.ffsys.io.loaders.types.ISoundAccess;
	
	/**
	*	Represents a loaded resource that is Sound data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class SoundResource extends AbstractResource
		implements ISoundAccess {
		
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