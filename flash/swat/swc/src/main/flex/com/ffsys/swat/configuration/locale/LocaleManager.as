package com.ffsys.swat.configuration.locale {
	
	import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;	
	
	import com.ffsys.utils.collections.strings.IStringCollection;
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;

	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.ILoaderQueue;	
	import com.ffsys.io.loaders.core.LoaderQueue;
	
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.configuration.filters.*;
	import com.ffsys.swat.configuration.rsls.*;
	
	import com.ffsys.io.loaders.resources.*;
	
	import com.ffsys.ui.css.CssStyleCollection;
	import com.ffsys.ui.css.ICssStyleCollection;
	import com.ffsys.ui.css.IStyleManager;
	import com.ffsys.ui.css.StyleManager;
	
	import com.ffsys.utils.properties.IProperties;
	
	import com.ffsys.swat.configuration.rsls.IResourceManager;
	
	/**
	*	Manages all the runtime assets for a collection
	*	of locales.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class LocaleManager extends LocaleCollection
		implements ILocaleManager {
			
		static private var _styleManager:IStyleManager
			= new StyleManager();
		
		private var _lang:String;
		private var _defaultLocale:IConfigurationLocale;
		private var _current:IConfigurationLocale;
			
		private var _resources:IResourceManager;
		
		private var _settings:ISettings;
		private var _defaults:IDefaults;
		private var _assets:IStringCollection;
		private var _filters:IFilterCollection;
			
		//
		private var _messagesQueue:ILoaderQueue;
		private var _errorsQueue:ILoaderQueue;
		private var _fontsQueue:ILoaderQueue;
		private var _rslsQueue:ILoaderQueue;
		private var _cssQueue:ILoaderQueue;
		private var _xmlQueue:ILoaderQueue;
		private var _imagesQueue:ILoaderQueue;
		private var _soundsQueue:ILoaderQueue;
		
		private	var _parent:IConfiguration;
		
		private var _paths:IPaths;
		
		/**
		*	Creates a <code>LocaleManager</code> instance.
		*/
		public function LocaleManager()
		{
			super();
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function get parent():IConfiguration
		{
			return _parent;
		}
		
		public function set parent( parent:IConfiguration ):void
		{
			_parent = parent;
		}

		/**
		*	@inheritDoc	
		*/
		public function get resources():IResourceManager
		{
			return _resources;
		}
		
		public function set resources( value:IResourceManager ):void
		{
			_resources = value;
		}

		/**
		*	@inheritDoc	
		*/
		public function get current():IConfigurationLocale
		{
			return _current;
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function get defaultLocale():IConfigurationLocale
		{
			return _defaultLocale;
		}
		
		public function set defaultLocale( value:IConfigurationLocale ):void
		{
			_defaultLocale = value;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getMessagesQueue():ILoaderQueue
		{
			if( !_messagesQueue )
			{
				_messagesQueue = new LoaderQueue();
				
				//add current properties first
				//so they are retrieved first when locating properties
				if( _current 
					&& _current.resources
					&& _current.resources.messages )
				{
					_messagesQueue.append(
						_current.resources.messages.getLoaderQueue() );
				}
				
				if( defaultLocale
					&& ( defaultLocale != current )
					&& defaultLocale.resources
					&& defaultLocale.resources.messages )
				{
					_messagesQueue.append(
						defaultLocale.resources.messages.getLoaderQueue() );
				}
				
				if( this.resources && this.resources.messages )
				{
					_messagesQueue.append(
						this.resources.messages.getLoaderQueue() );
				}
			}
			
			return _messagesQueue;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getErrorsQueue():ILoaderQueue
		{
			if( !_errorsQueue )
			{
				_errorsQueue = new LoaderQueue();
				
				//add current properties first
				//so they are retrieved first when locating properties
				if( _current
					&& _current.resources
					&& _current.resources.errors )
				{
					_errorsQueue.append(
						_current.resources.errors.getLoaderQueue() );
				}
				
				if( defaultLocale
					&& ( defaultLocale != current )
					&& defaultLocale.resources
					&& defaultLocale.resources.errors )
				{
					_errorsQueue.append(
						defaultLocale.resources.errors.getLoaderQueue() );
				}
				
				if( this.resources && this.resources.errors )
				{
					_errorsQueue.append(
						this.resources.errors.getLoaderQueue() );
				}
			}
			
			return _errorsQueue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getFontsQueue():ILoaderQueue
		{
			if( !_fontsQueue )
			{
				_fontsQueue = new LoaderQueue();
				
				if( this.resources && this.resources.fonts )
				{
					_fontsQueue.append(
						this.resources.fonts.getLoaderQueue() );
				}
				
				if( defaultLocale
					&& ( defaultLocale != current )
					&& defaultLocale.resources
					&& defaultLocale.resources.fonts )
				{
					_fontsQueue.append(
						defaultLocale.resources.fonts.getLoaderQueue() );
				}
				
				if( _current
					&& _current.resources
					&& _current.resources.fonts )
				{
					_fontsQueue.append(
						_current.resources.fonts.getLoaderQueue() );
				}
			}
			
			return _fontsQueue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getRslsQueue():ILoaderQueue
		{
			if( !_rslsQueue )
			{
				_rslsQueue = new LoaderQueue();
				
				if( this.resources && this.resources.rsls )
				{
					_rslsQueue.append(
						this.resources.rsls.getLoaderQueue() );
				}
				
				if( _current
					&& _current.resources
					&& _current.resources.rsls )
				{
					_rslsQueue.append(
						_current.resources.rsls.getLoaderQueue() );
				}
			}
			
			return _rslsQueue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getXmlQueue():ILoaderQueue
		{
			if( !_xmlQueue )
			{
				_xmlQueue = new LoaderQueue();

				if( this.resources && this.resources.xml )
				{
					_xmlQueue.append(
						this.resources.xml.getLoaderQueue() );
				}

				if( _current
					&& _current.resources
					&& _current.resources.xml )
				{
					_xmlQueue.append(
						_current.resources.xml.getLoaderQueue() );
				}
			}

			return _xmlQueue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getCssQueue():ILoaderQueue
		{
			if( !_cssQueue )
			{
				_cssQueue = new LoaderQueue();

				if( this.resources && this.resources.css )
				{
					_cssQueue.append(
						this.resources.css.getLoaderQueue() );
				}

				if( _current
					&& _current.resources
					&& _current.resources.css )
				{
					_cssQueue.append(
						_current.resources.css.getLoaderQueue() );
				}
				
			
				//massage the css queue so that it uses the style manager
				//for loading, ensuring that style dependencies are resolved
				var loader:ILoader = null;
				var css:ICssStyleCollection = null;
				for( var i:int = 0;i < _cssQueue.getLength();i++ )
				{
					loader = ILoader( _cssQueue.getLoaderAt( i ) );
					css = new CssStyleCollection();
					if( loader.id )
					{
						css.id = loader.id;
					}
					_styleManager.addStyleSheet( loader.request, css );
				}
				
				//update our queue with the queue that the
				//style manager will use
				_cssQueue = _styleManager.load();
			}

			return _cssQueue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImagesQueue():ILoaderQueue
		{
			if( !_imagesQueue )
			{
				_imagesQueue = new LoaderQueue();
				
				if( _current
					&& _current.resources
					&& _current.resources.images )
				{
					_imagesQueue.append(
						_current.resources.images.getLoaderQueue() );
				}				
				
				if( this.resources
					&& this.resources.images )
				{
					_imagesQueue.append(
						this.resources.images.getLoaderQueue() );
				}
			}
			
			return _imagesQueue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getSoundsQueue():ILoaderQueue
		{
			if( !_soundsQueue )
			{
				_soundsQueue = new LoaderQueue();
				
				if( _current
					&& _current.resources
					&& _current.resources.sounds )
				{
					_soundsQueue.append(
						_current.resources.sounds.getLoaderQueue() );
				}				
				
				if( this.resources && this.resources.sounds )
				{
					_soundsQueue.append(
						this.resources.sounds.getLoaderQueue() );
				}
			}
			
			return _soundsQueue;
		}								
		
		/**
		*	@inheritDoc	
		*/
		public function getMessage( id:String, ... replacements ):String
		{
			return getMessageFromQueue(
				getMessagesQueue(), id, replacements );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getError( id:String, ... replacements ):String
		{
			return getMessageFromQueue(
				getErrorsQueue(), id, replacements );
		}
		
		/**
		*	@inheritDoc
		*/
		public function getImage( id:String ):Bitmap
		{
			var resource:IResource = getResourceById(
				_imagesQueue, id, ImageResource );
			
			if( resource )
			{
				return new Bitmap(
					ImageResource( resource ).bitmapData );
			}
			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getXmlDocument( id:String ):XML
		{
			var x:XML = null;
			
			var queue:ILoaderQueue = getXmlQueue();
			var resource:XmlResource = 
				queue.resources.getResourceById( id ) as XmlResource;
				
			if( resource )
			{
				x = resource.xml;
			}
			
			return x;
		}
			
		/**
		*	@inheritDoc
		*/
		public function get styleManager():IStyleManager
		{
			return _styleManager;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getStyleSheet( id:String ):ICssStyleCollection
		{
			return _styleManager.getStyleSheet( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStyle( id:String ):Object
		{
			return _styleManager.getStyle( id );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStyle( styleName:String, style:Object ):void
		{
			_styleManager.setStyle( styleName, style );
		}		
		
		/**
		*	@inheritDoc
		*/
		public function getSound( id:String ):Sound
		{
			var resource:IResource = getResourceById(
				_soundsQueue, id, SoundResource );
			
			if( resource )
			{
				return SoundResource( resource ).sound;
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getFilter( id:String ):BitmapFilter
		{
			return _styleManager.getFilter( id );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get lang():String
		{
			return _lang;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set lang( lang:String ):void
		{
			_lang = lang;
			
			var parts:Array = null;
			var delimiters:Array = [ "_", "-" ];
			var delimiter:String = null;
			var country:String = null;
			
			if( length == 0 )
			{
				throw new Error(
					"Cannot update the language with no locale data." );
			}
			
			if( lang )
			{
				var selected:ILocale = null;
				var hasDelimiter:Boolean = false;
				
				for( var i:int = 0;i < delimiters.length;i++ )
				{
					delimiter = delimiters[ i ];
					
					hasDelimiter = ( lang.indexOf( delimiter ) > -1 );
					
					if( hasDelimiter )
					{
						parts = lang.split( delimiter );
						selected = getLocaleByLanguageAndCountry(
							parts[ 0 ], parts[ 1 ] );
						break;
					}
				}
				
				if( !hasDelimiter )
				{
					selected = getLocaleByLanguage( lang );
				}

				if( selected )
				{
					_current = IConfigurationLocale( selected );
				}else{
					throw new Error( "Could not locate locale for language code '" + lang + "'" );
				}
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get settings():ISettings
		{
			return _settings;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set settings( settings:ISettings ):void
		{
			_settings = settings;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get defaults():IDefaults
		{
			return _defaults;
		}

		/**
		*	@inheritDoc	
		*/
		public function set defaults( defaults:IDefaults ):void
		{
			_defaults = defaults;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get assets():IStringCollection
		{
			return _assets;
		}

		/**
		*	@inheritDoc
		*/		
		public function set assets( assets:IStringCollection ):void
		{
			_assets = assets;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get filters():IFilterCollection
		{
			return _filters;
		}

		/**
		*	@inheritDoc
		*/
		public function set filters( filters:IFilterCollection ):void
		{
			_filters = filters;
		}
		
		/**
		*	@private
		*/
		public function setDeserializedProperty(
			name:String, value:Object ):void
		{
			if( hasOwnProperty( name ) )
			{
				this[ name ] = value;
			}else if( value is ILocale )
			{
				addLocale( ILocale( value ) );
			}
		}
		
		/**
		*	@private
		*/
		public function deserialized():void
		{
			if( defaultLocale )
			{
				var exists:Boolean = hasLocale( defaultLocale );
				
				if( !exists )
				{
					throw new Error(
						"The default locale does not exist in the available locales." );
				}
				
				//override the default locale with the loaded locale
				defaultLocale = IConfigurationLocale(
					getLocaleByLanguageAndCountry(
						defaultLocale.lang,
						defaultLocale.country ) );
			}
		}
		
		/**
		*	@private
		*/
		private function getMessageFromQueue(
			queue:ILoaderQueue, id:String, replacements:Array ):String
		{
			var output:String = null;
			var list:IResourceList = queue.resources;
			var resource:PropertiesResource = null;
			var properties:IProperties = null;
			
			replacements.unshift( id );
			
			for( var i:int = 0;i < list.getLength();i++ )
			{
				resource = PropertiesResource( list.getResourceAt( i ) );
				properties = resource.properties;
				
				if( properties )
				{
					output = properties.getProperty.apply(
						properties, replacements );
				
					if( output )
					{
						return output;
					}
				}
			}
			
			return output;
		}
		
		/**
		*	@private	
		*/
		private function getResourceById(
			queue:ILoaderQueue, id:String, type:Class ):IResource
		{
			var output:IResource = null;
			var list:IResourceList = null;
			
			if( queue )
			{
				list = queue.resources;
			}
			
			if( list )
			{
				list = list.getResourcesByType( type );
				output = list.getResourceById( id );
			}
			
			return output;
		}
	}
}