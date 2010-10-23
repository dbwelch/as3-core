package com.ffsys.ui.css {
	
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.ffsys.io.loaders.core.*;	
	
	/**
	*	Responsible for managing a collection of style sheets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public class StyleManager extends CssStyleCollection
		implements IStyleManager {
			
		private var _queue:ILoaderQueue;
		private var _styleSheets:Dictionary = new Dictionary();
		
		/**
		*	Creates a <code>StyleManager</code> instance.
		*/
		public function StyleManager()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function addStyleSheet(
			request:URLRequest,
			sheet:ICssStyleCollection ):void
		{
			if( request && sheet )
			{
				_styleSheets[ sheet ] = request;
			}
		}
			
		/**
		*	@inheritDoc
		*/
		public function removeStyleSheet(
			sheet:ICssStyleCollection ):Boolean
		{
			delete _styleSheets[ sheet ];
			return ( sheet && _styleSheets[ sheet ] == null );
		}

		/**
		*	@inheritDoc
		*/
		public function load():ILoaderQueue
		{
			if( _queue )
			{
				_queue.destroy();
			}
			
			_queue = new LoaderQueue();
			
			var loader:CssLoader = null;
			var css:ICssStyleCollection = null;
			for( var obj:Object in _styleSheets )
			{
				css = ICssStyleCollection( obj );
				trace("StyleManager::load(), ", css, URLRequest( _styleSheets[ obj ] ) );
				loader = new CssLoader( URLRequest( _styleSheets[ obj ] ) );
				loader.css = css;
				_queue.addLoader( loader );
			}
			
			_queue.load();
			
			return _queue;
		}
	}
}