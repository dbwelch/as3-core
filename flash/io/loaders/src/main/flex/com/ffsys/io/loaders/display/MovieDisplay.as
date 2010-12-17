package com.ffsys.io.loaders.display {

	import flash.display.Loader;
	import flash.display.Sprite;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	/**
	*	Encapsulates a loaded swf movie that can
	*	be added to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.07.2007
	*/
	public class MovieDisplay extends AbstractDisplay
		implements IDisplayMovie {
		
		/**
		*	@private	
		*/
		protected var _uri:String;
		
		/**
		*	@private	
		*/		
		protected var _loader:Loader;
		
		/**
		*	@private	
		*/
		protected var _bytesTotal:uint;
		
		/**
		*	Creates a <code>MovieDisplay</code> instance.
		*	
		*	@param uri The uniform resource indicator the swf
		*	movie was loaded from.
		*	
		*	@param loader The <code>Loader</code> used to load
		*	the swf movie.
		*	
		*	@param bytesTotal The total number of bytes for the
		*	loaded swf movie.
		*/		
		public function MovieDisplay(
			uri:String = null,
			loader:Loader = null,
			bytesTotal:uint = 0 )
		{
			super();
			
  			if( !loader )
			{
				loader = new Loader();
			}
			
			this.uri = uri;
			this.loader = loader;
			this.bytesTotal = bytesTotal;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set uri( val:String ):void
		{
			_uri = val;
		}
		
		public function get uri():String
		{
			return _uri;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set bytesTotal( val:uint ):void
		{
			_bytesTotal = val;
		}
		
		public function get bytesTotal():uint
		{
			return _bytesTotal;
		}
		
		/**
		*	@inheritDoc	
		*/		
		override public function destroy():void
		{
			if( loader && contains( loader ) )
			{
				removeChild( loader );
			}
			
			_loader = null;
			
			super.destroy();
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function unload():void
		{
			if( loader )
			{
				/*
				trace("MovieDisplay::unload(), loader: " + loader );
				trace("MovieDisplay::unload(), this: " + this );
				*/
				
				loader.unload();
			}
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set loader( val:Loader ):void
		{
			_loader = val;
			
			if( loader )
			{
				addChild( loader );
			}			
			
			if( application )
			{
				this.width = application.width;
				this.height = application.height;	
			}			
		}		
		
		public function get loader():Loader
		{
			return _loader;
		}		
		
		/**
		*	@inheritDoc	
		*/		
		public function get application():Sprite
		{
			if( loader &&
			 	loader.content &&
				( loader.content is Sprite ) )	//catches AVM1 Movies, where the cast below will fail
			{
				return Sprite( loader.content );
			}
			
			return null;
		}
	}
}