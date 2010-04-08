package com.ffsys.io.loaders.resources {
	
	import com.ffsys.io.loaders.display.IDisplayVideo;
	import com.ffsys.io.loaders.types.IVideoAccess;
	
	/**
	*	Represents a remote resource that encapsulates Bitmap data
	*	that can be added to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class VideoResource extends AbstractResource
		implements IVideoAccess {
		
		public function VideoResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		public function set video( val:IDisplayVideo ):void
		{
			this.data = ( val as  Object );
		}
		
		public function get video():IDisplayVideo
		{
			return IDisplayVideo( this.data );
		}
		
	}
	
}
