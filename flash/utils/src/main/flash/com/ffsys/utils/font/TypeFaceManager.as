package com.ffsys.utils.font {

	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	
	//-->debug
	//import flash.text.Font;
	
	import com.ffsys.io.xml.IDeserializeProperty;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.ILoaderQueue;
	import com.ffsys.io.loaders.core.LoaderQueue;
	
	import com.ffsys.io.loaders.events.ResourceNotFoundEvent;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.LoadStartEvent;
	import com.ffsys.io.loaders.events.LoaderQueueStartEvent;
	import com.ffsys.io.loaders.events.LoadCompleteEvent;
	import com.ffsys.io.loaders.events.MovieLoadEvent;
	import com.ffsys.io.loaders.events.XmlLoadEvent;
	import com.ffsys.io.loaders.types.XmlLoader;
	import com.ffsys.io.loaders.types.MovieLoader;
	
	import com.ffsys.utils.locale.ILocale;
	
	import com.ffsys.utils.font.parser.ITypeFaceParser;
	import com.ffsys.utils.font.parser.TypeFaceParser;
	
	/**
	*	Responsible for loading the font XML definition
	*	document and the referenced font libraries
	*	depending upon the locale associated with this
	*	instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.05.2008
	*/
	public class TypeFaceManager extends EventDispatcher
		implements 	ITypeFaceManager,
		 			IDeserializeProperty {
		
		/**
		*	@private
		*	
		*	The <code>ILocale</code> implementation that determines
		*	which group of fonts should be loaded.
		*/
		private var _locale:ILocale;
		
		/**
		*	@private
		*	
		*	The <code>ILoader</code> used to load the XML
		*	font definition file.
		*/
		private var _loader:XmlLoader;
		
		/**
		*	@private
		*	
		*	The queue used to load the swf libraries.	
		*/
		private var _queue:ILoaderQueue;
		
		/**
		*	@private
		*	
		*	The collection of font groups.	
		*/
		private var _groups:Array;	
		
		/**
		*	Creates a <code>FontManager</code> instance.
		*	
		*	@param locale The locale used to determine
		*	which set of fonts should be loaded.
		*/
		public function TypeFaceManager( locale:ILocale = null )
		{
			super();
			this.locale = locale;
			_loader = new XmlLoader();
			_groups = new Array();
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set locale( val:ILocale ):void
		{
			_locale = val;
		}
		
		public function get locale():ILocale
		{
			return _locale;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get groups():Array
		{
			return _groups;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getLength():int
		{
			return _groups.length;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getGroupAt( index:int ):ITypeFaceGroup
		{
			if( index < 0 || index >= getLength() )
			{
				return null;
			}
			
			return _groups[ index ];
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getGroupByLang( lang:String = null ):ITypeFaceGroup
		{
			if( !lang )
			{
				lang = locale.lang;
			}
			
			var i:int = 0;
			var l:int = getLength();
			
			var group:ITypeFaceGroup = null;
			
			for( ;i < l; i++ )
			{
				group = getGroupAt( i );
				
				if( group.lang == lang )
				{
					return group;
				}
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getPathsByLang( lang:String = null ):Array
		{
			if( !lang )
			{
				lang = locale.lang;
			}
			
			var output:Array = new Array();
			
			var group:ITypeFaceGroup = getGroupByLang( lang );
			
			if( group )
			{
				output.push( group.path );
			}
			
			return output;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyleById(
			id:String,
			lang:String = null,
			typeFaceId:String = null ):ITypeFaceStyle
		{
			var group:ITypeFaceGroup = null;
			
			if( lang )
			{
				group = getGroupByLang( lang );
			}
			
			//looking in a particular group
			if( group )
			{
				return group.getStyleById( id, typeFaceId );
			}
			
			var style:ITypeFaceStyle = null;
			
			//otherwise search all groups
			//and return the first found
			var i:int = 0;
			var l:int = getLength();
			
			for( ;i < l; i++ )
			{
				group = getGroupAt( i );
				style = group.getStyleById( id, typeFaceId );
				
				if( style )
				{
					return style;
				}
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function getTextFormatById(
			id:String,
			lang:String = null,
			typeFaceId:String = null ):TextFormat
		{
			return getStyleById( id, lang, typeFaceId ) as TextFormat;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function load( path:String ):void
		{
			if( !locale || ( locale && !locale.lang ) )
			{
				throw new TypeFaceError( TypeFaceError.INVALID_LOCALE );
			}
			
			_loader.addEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND,
				definitionResourceNotFound, false, 0, true );
			
			_loader.addEventListener(
				LoadStartEvent.LOAD_START, definitionLoadStart, false, 0, true );
				
			_loader.addEventListener(
				LoadProgressEvent.LOAD_PROGRESS, definitionLoadProgress, false, 0, true );
			
			_loader.addEventListener(
				LoadEvent.DATA, definitionLoadComplete, false, 0, true );
			
			var request:URLRequest = new URLRequest( path );
			_loader.load( request );
		}
		
		/**
		*	@private
		*/
		private function definitionResourceNotFound(
			event:ResourceNotFoundEvent ):void
		{
			//explicitly clone so that the default
			//behaviour can be cancelled
			var evt:ResourceNotFoundEvent =
				ResourceNotFoundEvent( event.clone() );
			dispatchEvent( evt );
			
			//the user can listen for this event
			//and call preventDefault() to stop
			//the runtime error being thrown
			if( !evt.isDefaultPrevented() )
			{
				throw new TypeFaceError(
					TypeFaceError.DEFINITION_RESOURCE_NOT_FOUND, evt.loader.uri );
			}
		}
		
		/**
		*	@private
		*/
		private function definitionLoadStart( event:LoadStartEvent ):void
		{
			dispatchEvent( event );
		}
		
		/**
		*	@private
		*/		
		private function definitionLoadProgress( event:LoadProgressEvent ):void
		{
			dispatchEvent( event );
		}
		
		/**
		*	@private
		*/		
		private function definitionLoadComplete( event:XmlLoadEvent ):void
		{	
			
			var parser:ITypeFaceParser =
				new TypeFaceParser();
				
			parser.parse( event.xml, this );
			
			//cleanup
			_loader.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND, definitionResourceNotFound );			
			
			_loader.removeEventListener(
				LoadStartEvent.LOAD_START, definitionLoadStart );
			
			_loader.removeEventListener(
				LoadProgressEvent.LOAD_PROGRESS, definitionLoadProgress );
			
			_loader.removeEventListener(
				LoadEvent.DATA, definitionLoadComplete );
				
			_loader = null;
			
			dispatchEvent( event );
			
			//var style:ITypeFaceStyle = getStyleById( "main" );
			//var format:TextFormat = getTextFormatById( "main", "en" );
			
			//trace("TypeFaceManager::definitionLoadComplete(), " + format.font );
			
			//now load the font libraries
			loadLibraries();
		}
		
		/**
		*	@private
		*	
		*	Loads the swf font libraries.
		*/
		private function loadLibraries():void
		{
			var paths:Array = getPathsByLang();
			
			//trace("TypeFaceManager::loadLibraries(), " + paths );
			
			_queue = new LoaderQueue();
			
			//trace("TypeFaceManager::queue silent (), " + _queue.silent );
			
			var i:int = 0;
			var l:int = paths.length;
			
			var path:String = null;
			var loader:ILoader = null;
			
			for( ;i < l; i++ )
			{
				path = paths[ i ];
				loader = new MovieLoader( new URLRequest( path ) );
				_queue.addLoader( loader.request, loader );
			}
			
			_queue.addEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND, libraryResourceNotFound, false, 0, true );
			
			_queue.addEventListener(
				LoaderQueueStartEvent.LOAD_ITEM_START, libraryLoadStart, false, 0, true );
				
			_queue.addEventListener(
				LoadProgressEvent.LOAD_PROGRESS, libraryLoadProgress, false, 0, true );
				
			_queue.addEventListener(
				LoadEvent.DATA, libraryLoaded, false, 0, true );
				
			_queue.addEventListener(
				LoadCompleteEvent.LOAD_COMPLETE, libraryLoadComplete, false, 0, true );
			
			_queue.load();
		}
		
		/**
		*	@private	
		*/
		private function libraryResourceNotFound( event:ResourceNotFoundEvent ):void
		{
			//explicitly clone so that the default
			//behaviour can be cancelled
			var evt:ResourceNotFoundEvent =
				ResourceNotFoundEvent( event.clone() );
			dispatchEvent( evt );
			
			//the user can listen for this event
			//and call preventDefault() to stop
			//the runtime error being thrown
			if( !evt.isDefaultPrevented() )
			{
				throw new TypeFaceError(
					TypeFaceError.LIBRARY_RESOURCE_NOT_FOUND, evt.loader.uri );
			}
		}
		
		/**
		*	@private	
		*/
		private function libraryLoadStart( event:LoaderQueueStartEvent ):void
		{
			//trace("TypeFaceManager::libraryLoadStart(), " + event );
			dispatchEvent( event );
		}
		
		/**
		*	@private	
		*/		
		private function libraryLoadProgress( event:LoadProgressEvent ):void
		{
			//trace("TypeFaceManager::libraryLoadProgress(), " + event );
			dispatchEvent( event );
		}
		
		/**
		*	@private	
		*/		
		private function libraryLoaded( event:MovieLoadEvent ):void
		{
			//trace("TypeFaceManager::libraryLoaded(), " + event );
			dispatchEvent( event );
		}
		
		/**
		*	@private	
		*/		
		private function libraryLoadComplete( event:LoadCompleteEvent ):void
		{
			//trace("TypeFaceManager::libraryLoadComplete(), " + event );

			dispatchEvent( event );
			
			//cleanup the listeners
			_queue.removeEventListener(
				ResourceNotFoundEvent.RESOURCE_NOT_FOUND, libraryResourceNotFound );
			
			_queue.removeEventListener(
				LoaderQueueStartEvent.LOAD_ITEM_START, libraryLoadStart );
				
			_queue.removeEventListener(
				LoadProgressEvent.LOAD_PROGRESS, libraryLoadProgress );
				
			_queue.removeEventListener(
				LoadEvent.DATA, libraryLoaded );
				
			_queue.removeEventListener(
				LoadCompleteEvent.LOAD_COMPLETE, libraryLoadComplete );
				
			_queue = null;
			
			//-->debug
			
			/*
			var fonts:Array = Font.enumerateFonts();
			
			var i:int = 0;
			var l:int = fonts.length;
			
			for( ;i < l; i++ )
			{
				trace("TypeFaceManager::libraryLoadComplete(), " + fonts[ i ] );
				trace("TypeFaceManager::libraryLoadComplete(), " + fonts[ i ].fontName );
			}
			*/
		}
		
		/**
		*	@private	
		*/
		public function setDeserializedProperty(
			name:String, value:Object ):void
		{
			if( this.hasOwnProperty( name ) )
			{
				this[ name ] = value;
				return;
			}
			
			_groups.push( ITypeFaceGroup( value ) );
		}
	}
}