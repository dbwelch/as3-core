package org.flashx.io.loaders.events {
	
	import org.flashx.events.AbstractEvent;
	
	/**
	*	Event dispatched when converting
	*	<code>NetStream</code> callback methods
	*	to standard events.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.05.2008
	*/
	public class VideoStatusEvent extends AbstractEvent {
		
		/**
		*	Event dispatched when the video receives a cue point.
		*/
		static public const CUE_POINT:String = "cuePoint";
		
		/**
		*	Event dispatched when the video completes playing.
		*	
		*	Currently unused as onPlayStatus never seems to fire.
		*/		
		static public const PLAY_STATUS:String = "playStatus";
		
		/**
		*	Event dispatched when embedded meta data is received.	
		*/
		static public const META_DATA:String = "metaData";		
		
		/**
		*	Event dispatched when embedded image data is received.	
		*/
		static public const IMAGE_DATA:String = "imageData";
		
		/**
		*	Event dispatched when embedded text data is received.
		*/		
		static public const TEXT_DATA:String = "textData";
		
		/**
		*	Event dispatched when a video completes playback.	
		*/
		static public const COMPLETE:String = "complete";
		
		/**
		*	@private	
		*/
		private var _info:Object;
		
		/**
		*	Creates a <code>VideoStatusEvent</code> instance.	
		*/
		public function VideoStatusEvent(
			type:String, info:Object = null )
		{
			super( type );
			_info = info;
		}
		
		/**
		*	The original data passed to the corresponding callback method.
		*/
		public function get info():Object
		{
			return _info;
		}
	}
}