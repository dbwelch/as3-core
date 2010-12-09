package com.ffsys.ui.css {
	
	import flash.events.EventDispatcher;
	import flash.filters.BitmapFilter;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	import com.ffsys.io.loaders.core.*;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.StyleSheetResource;
	
	import com.ffsys.utils.substitution.*;	
	
	/**
	*	Responsible for managing a collection of style sheets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public class StyleManager extends CssStyleSheet
		implements IStyleManager {
			
		private var _queue:ILoaderQueue;
		private var _dependencyQueue:ILoaderQueue;
		private var _styleSheets:Vector.<StyleSheetEntry> = new Vector.<StyleSheetEntry>();	
		
		/**
		*	Creates a <code>StyleManager</code> instance.
		*/
		public function StyleManager()
		{
			super();
			this.bindings = new BindingCollection();
		}		
		
		/**
		*	@inheritDoc
		*/
		public function addStyleSheet(
			sheet:ICssStyleSheet = null,
			request:URLRequest = null ):ICssStyleSheet
		{
			if( sheet == null )
			{
				sheet = StyleSheetFactory.create();
			}
				
			var entry:StyleSheetEntry = new StyleSheetEntry( request, sheet );
			
			if( request && sheet )
			{
				//_styleSheets[ sheet ] = request;
				
				if( this.bindings )
				{
					if( !sheet.bindings )
					{
						sheet.bindings = this.bindings;
					}else{
						for( var i:int = 0;i < this.bindings.getLength();i++ )
						{
							sheet.bindings.addBinding(
								bindings.getBindingAt( i ) );
						}
					}
				}
			}
			
			_styleSheets.push( entry );
			return sheet;
		}
			
		/**
		*	@inheritDoc
		*/
		public function removeStyleSheet(
			sheet:ICssStyleSheet ):Boolean
		{
			var entry:StyleSheetEntry = null;
			for( var i:int = 0;i < _styleSheets.length;i++ )
			{
				entry = _styleSheets[ i ];
				if( entry.sheet == sheet )
				{
					_styleSheets.splice( i, 1 );
					return true;
				}
			}
			
			return false;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyleSheet( id:String ):ICssStyleSheet
		{
			if( id )
			{
				var css:ICssStyleSheet = null;
				var entry:StyleSheetEntry = null;
				for each( entry in _styleSheets )
				{
					css = ICssStyleSheet( entry.sheet );
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
			var css:ICssStyleSheet = null;
			var style:Object = null;
			var entry:StyleSheetEntry = null;
			for each( entry in _styleSheets )
			{
				css = ICssStyleSheet( entry.sheet );
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
			var css:ICssStyleSheet = null;
			var styles:Array = null;
			var entry:StyleSheetEntry = null;
			for each( entry in _styleSheets )
			{
				css = ICssStyleSheet( entry.sheet );
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
			
			var css:ICssStyleSheet = null;
			var entry:StyleSheetEntry = null;
			var styles:Array = null;
			for each( entry in _styleSheets )
			{
				css = ICssStyleSheet( entry.sheet );
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
			var css:ICssStyleSheet = null;
			var filter:BitmapFilter = null;
			var entry:StyleSheetEntry = null;
			for each( entry in _styleSheets )
			{
				css = ICssStyleSheet( entry.sheet );
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
			var css:ICssStyleSheet = null;
			var entry:StyleSheetEntry = null;
			for each( entry in _styleSheets )
			{
				css = ICssStyleSheet( entry.sheet );
				loader = new CssLoader( entry.request );
				loader.css = css;
				loader.addEventListener( LoadEvent.DATA, itemLoaded );	
				_queue.addLoader( loader );
			}
			
			_queue.load();
			
			return _queue;
		}
		
		private var _current:ICssStyleSheet;
		
		/**
		*	@private
		*/
		private function itemLoaded( event:LoadEvent ):void
		{
			_current = ICssStyleSheet(
				StyleSheetResource( event.resource ).styleSheet );
				
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
					_dependencyQueue = _current.dependencies;
					_dependencyQueue.addEventListener( LoadEvent.DATA, dependencyDispatchProxy );
					_dependencyQueue.addEventListener( LoadEvent.LOAD_START, dependencyDispatchProxy );
					_dependencyQueue.addEventListener( LoadEvent.LOAD_PROGRESS, dependencyDispatchProxy );
					_dependencyQueue.addEventListener( LoadEvent.RESOURCE_NOT_FOUND, dependencyDispatchProxy );
					_dependencyQueue.addEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
					_dependencyQueue.load();
				}
			}
		}
		
		/**
		*	@private
		*/
		override protected function dependenciesLoaded( event:LoadEvent ):void
		{
			_dependencyQueue.removeEventListener( LoadEvent.DATA, dependencyDispatchProxy );
			_dependencyQueue.removeEventListener( LoadEvent.LOAD_START, dependencyDispatchProxy );
			_dependencyQueue.removeEventListener( LoadEvent.LOAD_PROGRESS, dependencyDispatchProxy );
			_dependencyQueue.removeEventListener( LoadEvent.RESOURCE_NOT_FOUND, dependencyDispatchProxy );
			
			_dependencyQueue.removeEventListener( LoadEvent.LOAD_COMPLETE, dependenciesLoaded );
			
			//resume the main css queue
			_queue.resume();
			_current = null;
		}
		
		/**
		*	@private	
		*/
		private function dependencyDispatchProxy( event:LoadEvent ):void
		{
			//proxy the events through the main loader queue
			_queue.dispatchEvent( event );
		}
	}	
}

import flash.net.URLRequest;
import com.ffsys.ui.css.ICssStyleSheet;

class StyleSheetEntry extends Object {

	/**
	*	The url request for the entry.
	*/
	public var request:URLRequest;

	/**
	*	The style sheet for the entry.
	*/
	public var sheet:ICssStyleSheet;

	/**
	*	Creates a <code>StyleSheetEntry</code> instance.
	*
	*	@param request The url request.
	*	@param sheet The style sheet implementation.
	*/
	public function StyleSheetEntry(
		request:URLRequest = null,
		sheet:ICssStyleSheet = null )
	{
		super();
		this.request = request;
		this.sheet = sheet;
	}
}