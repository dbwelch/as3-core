package org.flashx.io.loaders.resources {
	
	import flash.media.Video;
	
	/**
	* 	Represents a video resource.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class VideoResource extends AbstractResource {
		
		/**
		* 	Creates a <code>VideoResource</code> instance.
		* 
		* 	@param data The data this resource encapsulates.
		* 	@param uri The <code>URI</code> the data was loaded from.
		* 	@param bytesTotal The total number of bytes loaded.
		*/
		public function VideoResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		/**
		* 	The display object used to display the video.
		*/
		public function get video():Video
		{
			return Video( this.data );
		}
	}
}