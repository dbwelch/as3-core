package org.flashx.io.loaders.types {
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.URLRequest;
	
	import flash.utils.Timer;
	
	import org.flashx.events.Notifier;
	
	import org.flashx.io.loaders.core.AbstractStreamLoader;
	import org.flashx.io.loaders.core.ILoadOptions;
	import org.flashx.io.loaders.events.LoadEvent;
	import org.flashx.io.loaders.events.VideoStatusEvent;	
	import org.flashx.io.loaders.resources.VideoResource;
	
	/**
	*	Loads a video file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public class VideoLoader extends AbstractStreamLoader {
		
		/**
		*	The default width for loaded videos.	
		*/
		static public const DEFAULT_VIDEO_WIDTH:int = 320;
		
		/**
		*	The default height for loaded videos.	
		*/
		static public const DEFAULT_VIDEO_HEIGHT:int = 240;		
	
		static public const STREAM_NOT_FOUND:String = "NetStream.Play.StreamNotFound";
		static public const STREAM_COMPLETE:String = "NetStream.Play.Complete";
		static public const STREAM_START:String = "NetStream.Play.Start";
		static public const STREAM_STOP:String = "NetStream.Play.Stop";
		static public const STREAM_BUFFER_FULL:String = "NetStream.Buffer.Full";
		static public const STREAM_BUFFER_EMPTY:String = "NetStream.Buffer.Empty";
		
		
		private var _timer:Timer;
		private var _netConnection:NetConnection;
		private var _netStream:NetStream;
		private var _display:Video;
		
		private var _duration:Number;
		
		/**
		* 	Creates a <code>VideoLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function VideoLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			initialize();
		}
		
		public function get duration():Number
		{
			return _duration;
		}
		
		/**
		* 	@private
		*/
		private function initialize():void
		{
			_netConnection = new NetConnection();
			_netConnection.connect( null );
			
			_netStream = new NetStream( _netConnection );
			
			_netStream.addEventListener(
				IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
			_netStream.addEventListener(
				NetStatusEvent.NET_STATUS, netStatusHandler, false, 0, true );
			_netStream.addEventListener(
				AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler, false, 0, true );

			_netStream.client = this;
			
			_display = new Video();
			_display.width = DEFAULT_VIDEO_WIDTH;
			_display.height = DEFAULT_VIDEO_HEIGHT;
			
			//_display.netStream = _netStream;
			//_display.netConnection = _netConnection;
			
			_display.attachNetStream( _netStream );
		}

		public function get netStream():NetStream
		{
			return _netStream;
		}
		
		override public function load():void
		{
			this.resource = new VideoResource( _display, this.uri );
			
			//documentation says that the play method should
			//accept a URLRequest instance - this does not seem
			//to be the case so we use the underlying String
			_netStream.play( this.uri );
			
			startPreload();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function close():void
		{
			if( _netStream )
			{
				stopPreload();
				_netStream.close();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
        override protected function ioErrorHandler( event:IOErrorEvent ):void
		{
            //trace ( "IO Error : " + event );
			
			clearTimer();

			//dispatchEvent( event );
			
			dispatchResourceNotFoundEvent( event, this );
        }
		
		/**
		* 	@private
		*/
        private function netStatusHandler( event:NetStatusEvent ):void
		{
			
			/*
            trace ( "Net status : " + event.info.code );
			trace ( "Net status duration : " + duration );
			trace ( "Net status time : " + _netStream.time );
			*/
			
			//if there is no meta data this starts the load
			if( event.info.code == STREAM_START )
			{
				startPreload();
			}
			
			if( event.info.code == STREAM_NOT_FOUND )
			{
				//trace( "Video resource not found!!!!" );
				
				clearTimer();
				
				dispatchResourceNotFoundEvent( event, this );
			}
			
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
			
			/*
			if( event.info.code == STREAM_STOP
			 	&& !isNaN( duration )
				&& _netStream.time >= duration )
			{
				
				var evt:VideoStatusEvent =
					new VideoStatusEvent( VideoStatusEvent.COMPLETE, event.info );
				
				trace( "Video complete " + evt );
				
				dispatchEvent( evt );
			}
			*/
        }
		
        private function asyncErrorHandler( event:AsyncErrorEvent ):void
		{
            trace ( "Async error : " + event );

			//dispatchEvent( event );
        }
		
		private function startPreload():void
		{
			if( !_timer )
			{
				var event:Event = new Event( Event.OPEN );
				//dispatchEvent( event );
				
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.LOAD_START, event, this );
				dispatchEvent( evt );
			
				_timer = new Timer( 50 );
				_timer.addEventListener( TimerEvent.TIMER, preload, false, 0, true );
				_timer.start();
			}
		}
		
		private function preload( event:TimerEvent ):void
		{
			var bytesLoaded:uint = _netStream.bytesLoaded;
			var bytesTotal:uint = _netStream.bytesTotal;
			
			//pauses non-streaming instances
			//when no meta data handler has been fired
			//note that the video still loads
			//in a streaming manner as we can't force the bufferTime
			//to the duration
			if( !streaming )
			{
				_netStream.pause();
				_netStream.seek( 0 );
			}
			
			var progressEvent:ProgressEvent = new ProgressEvent( ProgressEvent.PROGRESS );
			progressEvent.bytesLoaded = bytesLoaded;
			progressEvent.bytesTotal = bytesTotal;
			
			var loadProgressEvent:LoadEvent = new LoadEvent(
				LoadEvent.LOAD_PROGRESS, progressEvent, this );
			dispatchEvent( loadProgressEvent );
			
			if( bytesLoaded >= bytesTotal )
			{
				stopPreload();
			}
		}
		
		/**
		* 	@private
		*/
		private function clearTimer():void
		{
			if( _timer )
			{
				_timer.removeEventListener( TimerEvent.TIMER, preload );
				_timer.stop();
				_timer = null;
			}			
		}
		
		/**
		* 	@private
		*/		
		private function stopPreload():void
		{
			clearTimer();
			
			_loaded = true;
			
			var completeEvent:Event = new Event( Event.COMPLETE );
			
			dispatchEvent( completeEvent );
			
			var evt:LoadEvent =
				new LoadEvent(
					LoadEvent.DATA,
					completeEvent,
					this,
					resource as VideoResource
				);
			
			dispatchEvent( evt );
			Notifier.dispatchEvent( evt );
			
			_netStream.removeEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			_netStream.removeEventListener( NetStatusEvent.NET_STATUS, netStatusHandler );
			_netStream.removeEventListener( AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler );
			_netStream.client = new Object();
			
			/*
			//clean up our references
			_display = null;			
			_netStream = null;
			_netConnection = null;
			*/
			
			//dispatchLoadCompleteEvent();
			
			evt = new LoadEvent(
				LoadEvent.LOAD_FINISHED,
				completeEvent,
				this,
				this.resource
			);
			dispatchEvent( evt );
		}
		
        public function onMetaData( info:Object ):void
		{
            //trace ( "Video meta data (duration) : " + info.duration );
            
            /*explicitly sets the video width and height using the meta data values,
            due to the fact that video.videoWidth and video.videoHeight on the
            flash Video Class sometimes unexpectedly return 0*/
            if( info.width ) DisplayObject( _display ).width = info.width;
           	if( info.height ) DisplayObject( _display ).height = info.height;
           	
           	//trace( "video.width: " + info.width );
           	//trace( "video.height: " + info.height );

			_duration = info.duration;

			if( !streaming )
			{
				//force the whole video to load
				//before displaying the stream
				_netStream.bufferTime = duration;
			
				//pause the stream as we don't want it to attempt to display anything
				_netStream.pause();
			
				//send it to the beginning so it's ready to play
				_netStream.seek( 0 );
			}
			
			var event:VideoStatusEvent =
				new VideoStatusEvent( VideoStatusEvent.META_DATA, info );
				
			dispatchEvent( event );
        }
		
		/**
		*	This callback method never fires, this seems
		*	to be a flash bug.	
		*/
        public function onPlayStatus( info:Object ):void
		{
            //trace ( "Video play status : " + info );

			var event:VideoStatusEvent =
				new VideoStatusEvent( VideoStatusEvent.PLAY_STATUS, info );
				
			dispatchEvent( event );
        }
		
        public function onCuePoint( info:Object ):void
		{
            //trace ( "Video cue point : " + info );

			var event:VideoStatusEvent =
				new VideoStatusEvent( VideoStatusEvent.CUE_POINT, info );
				
			dispatchEvent( event );
        }
		
        public function onImageData( info:Object ):void
		{
            //trace ( "Video image data : " + info );

			var event:VideoStatusEvent =
				new VideoStatusEvent( VideoStatusEvent.IMAGE_DATA, info );
				
			dispatchEvent( event );
        }

        public function onTextData( info:Object ):void
		{
            //trace ( "Video text data : " + info );

			var event:VideoStatusEvent =
				new VideoStatusEvent( VideoStatusEvent.TEXT_DATA, info );
				
			dispatchEvent( event );
        }
	}
}