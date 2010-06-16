package com.ffsys.swat.configuration {
	
	import com.ffsys.core.IFlashVariables;
	
	import com.ffsys.utils.collections.strings.LocaleAwareStringCollection;
	import com.ffsys.utils.collections.strings.StringCollection;
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.LocaleCollection;
	
	/**
	*	Represents the application configuration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public class Configuration extends Object 
		implements IConfiguration {
			
		private var _flashvars:IFlashVariables;
		private var _lang:String;
		private var _locales:LocaleCollection;
		private var _copy:LocaleAwareStringCollection;
		private var _settings:Settings;
		private var _defaults:Defaults;
		private var _assets:StringCollection;
		private var _assetManager:AssetManager;
		private var _rsls:RuntimeSharedLibraryCollection;
		
		/**
		*	Create a <code>Configuration</code> instance.
		*/
		public function Configuration()
		{
			super();
			_assetManager = new AssetManager( this );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get flashvars():IFlashVariables
		{
			return _flashvars;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function set flashvars( flashvars:IFlashVariables ):void
		{
			_flashvars = flashvars;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get locale():ILocale
		{
			return copy.locale;
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
						selected = locales.getLocaleByLanguageAndCountry( parts[ 0 ], parts[ 1 ] );
						break;
					}
				}
				
				if( !hasDelimiter )
				{
					selected = locales.getLocaleByLanguage( lang );
				}

				if( copy )
				{
					if( selected )
					{
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
		public function get locales():LocaleCollection
		{
			return _locales;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set locales( locales:LocaleCollection ):void
		{
			_locales = locales;
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
		public function set copy( copy:LocaleAwareStringCollection ):void
		{
			_copy = copy;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get settings():Settings
		{
			return _settings;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set settings( settings:Settings ):void
		{
			_settings = settings;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get defaults():Defaults
		{
			return _defaults;
		}

		/**
		*	@inheritDoc	
		*/
		public function set defaults( defaults:Defaults ):void
		{
			_defaults = defaults;
		}		
		
		/**
		*	@inheritDoc
		*/
		public function get assets():StringCollection
		{
			return _assets;
		}

		/**
		*	@inheritDoc
		*/		
		public function set assets( assets:StringCollection ):void
		{
			_assets = assets;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get assetManager():AssetManager
		{
			return _assetManager;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set assetManager( assetManager:AssetManager ):void
		{
			_assetManager = assetManager;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get rsls():RuntimeSharedLibraryCollection
		{
			return _rsls;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set rsls( rsls:RuntimeSharedLibraryCollection ):void
		{
			_rsls = rsls;
		}
	}
}