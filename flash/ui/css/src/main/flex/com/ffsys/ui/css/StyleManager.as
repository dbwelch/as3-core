package com.ffsys.ui.css {
	
	import flash.events.EventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.StylesheetResource;
	
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
		public function getStyleSheet( id:String ):ICssStyleCollection
		{
			if( id )
			{
				var css:ICssStyleCollection = null;
				for( var obj:Object in _styleSheets )
				{
					css = ICssStyleCollection( obj );
					if( id == css.id )
					{
						return css;
					}
				}
			}
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function getStyle( styleName:String ):Object
		{
			var css:ICssStyleCollection = null;
			var style:Object = null;
			for( var obj:Object in _styleSheets )
			{
				css = ICssStyleCollection( obj );
				style = css.getStyle( styleName );
				if( style )
				{
					return style;
				}
			}
			
			return super.getStyle( styleName );
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getStyles( styleName:String ):Array
		{
			var output:Array = new Array();
			var css:ICssStyleCollection = null;
			var styles:Array = null;
			for( var obj:Object in _styleSheets )
			{
				css = ICssStyleCollection( obj );
				styles = css.getStyles( styleName );
				if( styles && styles.length > 0 )
				{
					output = output.concat( styles );
				}
			}
			
			return output;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get styleNames():Array
		{
			var output:Array = super.styleNames;
			
			var css:ICssStyleCollection = null;
			var styles:Array = null;
			for( var obj:Object in _styleSheets )
			{
				css = ICssStyleCollection( obj );
				styles = css.styleNames;
				if( styles )
				{
					output = output.concat( styles );
				}
			}
			
			return output;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function getFilter( styleName:String ):BitmapFilter
		{
			var css:ICssStyleCollection = null;
			var filter:BitmapFilter = null;
			for( var obj:Object in _styleSheets )
			{
				css = ICssStyleCollection( obj );
				filter = css.getFilter( styleName );
				if( filter )
				{
					return filter;
				}
			}
			
			return super.getFilter( styleName );
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
				loader = new CssLoader( URLRequest( _styleSheets[ obj ] ) );
				loader.css = css;
				loader.addEventListener( LoadEvent.DATA, itemLoaded );
				_queue.addLoader( loader );
			}
			
			_queue.load();
			
			return _queue;
		}
		
		private var _current:ICssStyleCollection;
		
		/**
		*	@private
		*/
		private function itemLoaded( event:LoadEvent ):void
		{
			_current = ICssStyleCollection(
				StylesheetResource( event.resource ).styleSheet );
				
			//trace("StyleManager::itemLoaded(), ", event.loader, event.loader.id, _current );
			
			if( _current )
			{
				//assign a default id based on the loader id
				if( !_current.id && event.loader && event.loader.id )
				{
					_current.id = event.loader.id;
				}
				
				if( _current.dependencies && _current.dependencies.getLength() > 0 )
				{
					_queue.paused = true;
					_current.dependencies.addEventListener( LoadEvent.DATA, dependencyLoaded );
					_current.dependencies.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, dependencyResourceNotFound );
					_current.dependencies.addEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
					_current.dependencies.load();
				}
			}
		}
		
		/**
		*	@private
		*/
		override protected function dependenciesLoaded( event:LoadEvent ):void
		{
			_queue.resume();
			_current = null;
		}
		
		/**
		*	@private	
		*/
		private function dependencyLoaded( event:LoadEvent ):void
		{
			//trace("StyleManager::dependencyLoaded(): ", event.resource );
		}
		
		private function dependencyResourceNotFound( event:LoadEvent ):void
		{
			//trace("StyleManager::dependencyResourceNotFound(), ", this, event.loader, event.uri );
		}
	}
}