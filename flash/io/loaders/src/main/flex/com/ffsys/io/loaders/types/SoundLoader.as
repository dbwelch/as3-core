package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	
	import flash.net.URLRequest;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractStreamLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.SoundResource;
	
	/**
	*	Loads a sound file.
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
		
		/**
		* 	Creates a <code>SoundLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function SoundLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			_sound = new Sound();
			super( request, options );
		}
		
		/**
		* 	@inheritDoc
		*/
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
		
		/**
		* 	@inheritDoc
		*/		
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
		
		/**
		* 	The sound loader context used to load the sound.
		*/
		public function get context():SoundLoaderContext
		{
			return _context;
		}
		
		public function set context( val:SoundLoaderContext ):void
		{
			_context = val;
		}
		
		/**
		* 	The sound used to load the sound file.
		*/
		public function get sound():Sound
		{
			return _sound;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function load( request:URLRequest ):void
		{
			removeListeners();
			addListeners();
			this.request = request;
			_sound.load( request, _context );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function close():void
		{
			try {
				_sound.close();
			}catch( e:Error )
			{
				//
			}
		}
		
		/**
		* 	@inheritDoc
		*/
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
			
			dispatchEvent( evt );
			Notifier.dispatchEvent( evt );
			_sound = null;
        }
	}
}