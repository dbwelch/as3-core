package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.collections.strings.IStringCollection;
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.core.ILoaderQueue;	
	
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.configuration.filters.*;
	import com.ffsys.swat.configuration.rsls.*;
	
	import com.ffsys.io.loaders.resources.IResourceList;
	import com.ffsys.io.loaders.resources.PropertiesResource;
	
	import com.ffsys.utils.properties.IProperties;
	
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
		
		private var _lang:String;
		private var _defaultLocale:IConfigurationLocale;
		private var _current:IConfigurationLocale;
			
		private var _messages:IRuntimeResourceCollection;
		private var _errors:IRuntimeResourceCollection;
		private var _fonts:IRuntimeResourceCollection;
		private var _rsls:IRuntimeResourceCollection;
		
		private var _settings:ISettings;
		private var _defaults:IDefaults;
		private var _assets:IStringCollection;
		private var _filters:IFilterCollection;
			
		//
		private var _messagesQueue:ILoaderQueue;
		private var _errorsQueue:ILoaderQueue;
		private var _fontsQueue:ILoaderQueue;
		private var _rslsQueue:ILoaderQueue;
		
		/**
		*	Creates a <code>LocaleManager</code> instance.
		*/
		public function LocaleManager()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get messages():IRuntimeResourceCollection
		{
			return _messages;
		}
		
		public function set messages( value:IRuntimeResourceCollection ):void
		{
			_messages = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get errors():IRuntimeResourceCollection
		{
			return _errors;
		}
		
		public function set errors( value:IRuntimeResourceCollection ):void
		{
			_errors = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get fonts():IRuntimeResourceCollection
		{
			return _fonts;
		}
		
		public function set fonts( value:IRuntimeResourceCollection ):void
		{
			_fonts = value;
		}	
		
		/**
		*	@inheritDoc
		*/
		public function get rsls():IRuntimeResourceCollection
		{
			return _rsls;
		}
		
		public function set rsls( rsls:IRuntimeResourceCollection ):void
		{
			_rsls = rsls;
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
				if( _current && _current.messages )
				{
					_messagesQueue.append( _current.messages.getLoaderQueue() );
				}
				
				if( defaultLocale
					&& ( defaultLocale != current )
					&& defaultLocale.messages )
				{
					_messagesQueue.append(
						defaultLocale.messages.getLoaderQueue() );
				}
				
				if( this.messages )
				{
					_messagesQueue.append( this.messages.getLoaderQueue() );
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
				if( _current && _current.errors )
				{
					_errorsQueue.append( _current.errors.getLoaderQueue() );
				}
				
				if( defaultLocale
					&& ( defaultLocale != current )
					&& defaultLocale.errors )
				{
					_errorsQueue.append(
						defaultLocale.errors.getLoaderQueue() );
				}
				
				if( this.errors )
				{
					_errorsQueue.append( this.errors.getLoaderQueue() );
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
				
				if( this.fonts )
				{
					_fontsQueue.append( this.fonts.getLoaderQueue() );
				}
				
				if( defaultLocale
					&& ( defaultLocale != current )
					&& defaultLocale.fonts )
				{
					_fontsQueue.append(
						defaultLocale.fonts.getLoaderQueue() );
				}
				
				if( _current && _current.fonts )
				{
					_fontsQueue.append( _current.fonts.getLoaderQueue() );
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
				
				if( this.rsls )
				{
					_rslsQueue.append( this.rsls.getLoaderQueue() );
				}
				
				if( _current && _current.rsls )
				{
					_rslsQueue.append( _current.rsls.getLoaderQueue() );
				}
			}
			
			return _rslsQueue;
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
			
			if( !locales )
			{
				throw new Error( "Cannot update the language with null locales data." );
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
						selected = getLocaleByLanguageAndCountry( parts[ 0 ], parts[ 1 ] );
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
		*	@inheritDoc
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
		*	@inheritDoc
		*/
		public function deserialized():void
		{
			trace("LocaleManager::deserialized(), ", defaultLocale );
			
			if( defaultLocale )
			{
				var exists:Boolean = hasLocale( defaultLocale );
				
				if( !exists )
				{
					throw new Error(
						"The default locale does not exist in the available locales." );
				}
				
				//override the default locale with the loaded locale
				defaultLocale = IConfigurationLocale( getLocaleByLanguageAndCountry(
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
	}
}