/**
*	The core classes for the loaders library.
*/
package com.ffsys.io.loaders.core {
	
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.system.LoaderContext;	
	import flash.system.ApplicationDomain;
	
	import flash.net.URLRequest;
	
	import flash.events.Event;
	import flash.events.SecurityErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.IDisplayLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Abstract super class for loaders that load data
	*	that can be added to the display list.
	* 
	* 	These implementations use an underlying <code>Loader</code>
	* 	to load the display data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.12.2007
	*/
	public class AbstractDisplayLoader extends AbstractLoader
		implements IDisplayLoader {
		
		/**
		*	@private	
		*/		
		protected var _context:LoaderContext;
		
		/**
		* 	Creates an <code>AbstractDisplayLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function AbstractDisplayLoader(
			request:URLRequest,
			options:ILoadOptions = null )
		{
			super( request, options );
			_composite = new Loader();
			_context = new LoaderContext();
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get loader():Loader
		{
			return Loader( _composite );
		}
		
		/**
		*	@inheritDoc
		*/
		public function get context():LoaderContext
		{
			return _context;
		}
				
		public function set context( val:LoaderContext ):void
		{
			_context = val;
		}
		
		/**
		*	@inheritDoc	
		*/		
		override public function close():void
		{
			if( loader )
			{
				try {
					loader.close();
				}catch( e:Error )
				{
					//fail silently for the moment
					//--> we should add an ILoadOptions.strictStreamClose option
				}
			}
		}
		
		/**
		*	@inheritDoc
		*/
		public function unload():void
		{
			if( loader )
			{
				loader.unload();
			}
		}
		
		/**
		*	@inheritDoc	
		*/		
		override public function load():void
		{
			//trace("AbstractDisplayLoader::load(), " + request.url );
			if( this.request == null )
			{
				throw new Error( "Cannot load with a null url request." );
			}			
			
			if( loader )
			{
				close();
				unload();
				
				removeCompositeListeners( loader.contentLoaderInfo );
			}
			
			_composite = new Loader();
			_loading = true;
			_loaded = false;
			_complete = false;
			
			//
			if( loader )
			{
				addCompositeListeners( loader.contentLoaderInfo );
				loader.load( this.request, context );
			}
		}
		
		
		/**
		*	@private	
		*/		
		protected function getLoadedApplication( loader:Loader ):Sprite
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