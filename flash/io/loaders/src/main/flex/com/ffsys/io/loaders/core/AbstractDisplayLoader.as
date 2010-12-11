/**
*	The core classes for the loaders library.
*/
package com.ffsys.io.loaders.core {
	
	import flash.display.Loader;
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
		protected var _loader:Loader;
		
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
			_loader = new Loader();
			_context = new LoaderContext();
		}
		
		/**
		* 	Overrides the default behaviour to add listeners
		* 	to the encapsulated <code>Loader</code>.
		*/
        override protected function addListeners():void
		{
			
			if( loader )
			{
	            loader.contentLoaderInfo.addEventListener(
					Event.COMPLETE, completeHandler, false, 0, true );
				
	            loader.contentLoaderInfo.addEventListener(
					Event.OPEN, openHandler, false, 0, true );
				
	            loader.contentLoaderInfo.addEventListener(
					ProgressEvent.PROGRESS, progressHandler, false, 0, true );
				
	            loader.contentLoaderInfo.addEventListener(
					SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true );
				
	            loader.contentLoaderInfo.addEventListener(
					HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true );
				
	            loader.contentLoaderInfo.addEventListener(
					IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true );
			}
        }

		/**
		* 	Overrides the default behaviour to remove listeners
		* 	from the encapsulated <code>Loader</code>.
		*/
		override protected function removeListeners():void
		{
			if( loader )
			{
	            loader.contentLoaderInfo.removeEventListener(
					Event.COMPLETE, completeHandler );
					
	            loader.contentLoaderInfo.removeEventListener(
					Event.OPEN, openHandler );
					
	            loader.contentLoaderInfo.removeEventListener(
					ProgressEvent.PROGRESS, progressHandler );
					
	            loader.contentLoaderInfo.removeEventListener(
					SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
					
	            loader.contentLoaderInfo.removeEventListener(
					HTTPStatusEvent.HTTP_STATUS, httpStatusHandler );
				
	            loader.contentLoaderInfo.removeEventListener(
					IOErrorEvent.IO_ERROR, ioErrorHandler );
			}			
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get loader():Loader
		{
			return _loader;
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
		override public function load( request:URLRequest ):void
		{
			//trace("AbstractDisplayLoader::load(), " + request.url );
			
			if( loader )
			{
				close();
				unload();
			}
			
			_loader = new Loader();	
			
			this.request = request;
			
			removeListeners();
			
			_loading = true;
			_loaded = false;
			_complete = false;
			
			//
			if( loader )
			{
				addListeners();
				loader.load( request, context );
			}
		}
	}
}