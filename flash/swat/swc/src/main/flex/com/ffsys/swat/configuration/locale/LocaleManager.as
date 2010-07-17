package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.collections.strings.LocaleAwareStringCollection;
	import com.ffsys.utils.collections.strings.IStringCollection;
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	import com.ffsys.io.loaders.core.LoaderQueue;
	import com.ffsys.io.loaders.core.ILoaderQueue;	
	
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.configuration.filters.*;
	import com.ffsys.swat.configuration.rsls.*;
	
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
			
		private var _current:IConfigurationLocale;
		private var _lang:String;
			
		private var _copy:LocaleAwareStringCollection;
		
		private var _settings:ISettings;
		private var _defaults:IDefaults;
		private var _assets:IStringCollection;
		private var _rsls:IRuntimeResourceCollection;
		private var _filters:IFilterCollection;
			
		private var _propertiesQueue:ILoaderQueue;
		private var _fontsQueue:ILoaderQueue;
		
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
		public function get current():IConfigurationLocale
		{
			return _current;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function getPropertiesQueue():ILoaderQueue
		{
			//TODO: add support for loading default messages
			//TODO: add support for concatentating the errors files
			
			if( !_propertiesQueue )
			{
				_propertiesQueue = _current.messages.getLoaderQueue();
			}
			
			return _propertiesQueue;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getFontsQueue():ILoaderQueue
		{
			if( !_fontsQueue )
			{
				_fontsQueue = new LoaderQueue();
			}
			
			return _fontsQueue;
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

				if( copy )
				{
					if( selected )
					{
						_current = IConfigurationLocale( selected );
						copy.locale = selected;
					}else{
						throw new Error( "Could not locate locale for language code '" + lang + "'" );
					}
				}else{
					throw new Error( "Cannot update the language with null copy data." );
				}
			}
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get copy():LocaleAwareStringCollection
		{
			return _copy;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function set copy( value:LocaleAwareStringCollection ):void
		{
			_copy = value;
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
		public function get rsls():IRuntimeResourceCollection
		{
			return _rsls;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set rsls( rsls:IRuntimeResourceCollection ):void
		{
			_rsls = rsls;
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
			if( value is ILocale )
			{
				addLocale( ILocale( value ) );
			}else if( hasOwnProperty( name ) )
			{
				this[ name ] = value;
			}
		}
	}
}