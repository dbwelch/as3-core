package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
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
			super( request, options );
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
			return Sound( _composite );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function load():void
		{
			if( _composite )
			{
				close();
				removeCompositeListeners( IEventDispatcher( _composite ) );				
			}
			
			_composite = new Sound();
			addCompositeListeners( IEventDispatcher( _composite ) );
			
			//start the load operation on the composite
			this.sound.load( this.request, _context );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function close():void
		{
			try {
				_composite.close();
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
			resource = new SoundResource( this.sound, uri );
			
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.DATA,
				event,
				this,
				resource as SoundResource
			);
			
			dispatchEvent( evt );
			Notifier.dispatchEvent( evt );
        }
	}
}