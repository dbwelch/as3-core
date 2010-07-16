package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	
	import flash.net.URLRequest;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractStreamLoader;
	import com.ffsys.io.loaders.core.LoadOptions;	
	
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.resources.SoundResource;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Encapsulates loading an external sound file (mp3).
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class SoundLoader extends AbstractStreamLoader {
		
		private var _sound:Sound;
		private var _context:SoundLoaderContext;
		
		public function SoundLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			_sound = new Sound();
			//_context = new SoundLoaderContext();
			
			super( request, options );
		}
		
		override protected function addListeners():void
		{
			_sound.addEventListener(
				Event.COMPLETE, completeHandler, false, 0, true );
			_sound.addEventListener(
				Event.OPEN, openHandler, false, 0, true );
			_sound.addEventListener(
				ProgressEvent.PROGRESS, progressHandler, false, 0, true );
			_sound.addEventListener(
				IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );			
		}
		
		override protected function removeListeners():void
		{
			_sound.removeEventListener(
				Event.COMPLETE, completeHandler );
			_sound.removeEventListener(
				Event.OPEN, openHandler );
			_sound.removeEventListener(
				ProgressEvent.PROGRESS, progressHandler );
			_sound.removeEventListener(
				IOErrorEvent.IO_ERROR, ioErrorHandler );
		}
		
		public function set context( val:SoundLoaderContext ):void
		{
			_context = val;
		}		

		public function get context():SoundLoaderContext
		{
			return _context;
		}
		
		public function get sound():Sound
		{
			return _sound;
		}
		
		override public function load( request:URLRequest ):void
		{
			removeListeners();
			addListeners();
			this.request = request;
			_sound.load( request, _context );
		}
		
		override public function close():void
		{
			try {
				_sound.close();
			}catch( e:Error )
			{
				//
			}
		}
		
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			resource = new SoundResource( _sound, uri );		
			
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.DATA,
				event,
				this,
				resource as SoundResource
			);
			
			if( queue )
			{
				queue.addResource( this );
			}
			
			dispatchEvent( evt );
			
			Notifier.dispatchEvent( evt );
			
			dispatchLoadCompleteEvent();
			
			_sound = null;
        }
		
	}
	
}
