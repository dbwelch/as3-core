package com.ffsys.io.loaders.display {

	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;	
	
	import com.ffsys.io.loaders.events.VideoStatusEvent;
	import com.ffsys.io.loaders.types.VideoLoader;
	
	/**
	*	Encapsulates a loaded video that can
	*	be added to the display list of a Flex application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public class FlexVideoDisplay extends FlexAbstractDisplay
		implements IDisplayVideo {
		
		/**
		*	@private	
		*/
		private var _netConnection:NetConnection;
		
		/**
		*	@private	
		*/	
		private var _netStream:NetStream;
		
		/**
		*	@private	
		*/
		private var _video:Video;
		
		/**
		*	@private	
		*/
		private var _duration:Number;
		
		/**
		*	Creates a <code>FlexVideoDisplay</code> instance.	
		*/
		public function FlexVideoDisplay()
		{
			super();
			
			_video = new Video(
				VideoDisplay.DEFAULT_VIDEO_WIDTH,
				VideoDisplay.DEFAULT_VIDEO_HEIGHT );
				
			this.width = VideoDisplay.DEFAULT_VIDEO_WIDTH;
			this.height = VideoDisplay.DEFAULT_VIDEO_HEIGHT;
				
			addChild ( _video );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set duration( val:Number ):void
		{
			_duration = val;
		}
		
		public function get duration():Number
		{
			return _duration;
		}		

		/**
		*	@inheritDoc	
		*/
		public function set netConnection( val:NetConnection ):void
		{
			_netConnection = val;
		}
		
		public function get netConnection():NetConnection
		{
			return _netConnection;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set netStream( val:NetStream ):void
		{
			
			if( _netStream )
			{
				_netStream.removeEventListener(
					NetStatusEvent.NET_STATUS, netStatusHandler );
			}
			
			_netStream = val;
			
			_netStream.addEventListener(
				NetStatusEvent.NET_STATUS, netStatusHandler, false, 0, true );
		}		
		
		public function get netStream():NetStream
		{
			return _netStream;
		}		
		
		/**
		*	@inheritDoc	
		*/
		public function get video():Video
		{
			return _video;
		}
		
		override public function set width( val:Number ):void
		{
			super.width = val;
			_video.width = val;
		}
		
		override public function set height( val:Number ):void
		{
			super.height = val;
			_video.height = val;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function close():void
		{
			_netStream.close();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function pause():void
		{
			_netStream.pause();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function play( ...args ):void
		{
			_netStream.play( args );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function resume():void
		{
			_netStream.resume();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function seek( offset:Number ):void
		{
			_netStream.seek( offset );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function togglePause():void
		{
			_netStream.togglePause();
		}		
		
		/**
		*	@private
		*/
        private function netStatusHandler( event:NetStatusEvent ):void
		{
			/*
            trace ( "Net status : " + event.info.code );
			trace ( "Net status duration : " + duration );
			trace ( "Net status time : " + _netStream.time );
			*/
			
			if( event.info.code == VideoLoader.STREAM_STOP
			 	&& !isNaN( duration )
				&& _netStream.time >= duration )
			{
				
				var evt:VideoStatusEvent =
					new VideoStatusEvent( VideoStatusEvent.COMPLETE, event.info );
				
				//trace( "Video complete " + evt );
				
				dispatchEvent( evt );
			}
        }		
	}
	
}
