package com.ffsys.utils.locale {
	
	/**
	*	Represents a collection of locales, behaves as a set.
	*	
	*	Duplicates and null values are not allowed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.04.2010
	*/
	public class LocaleCollection extends Object
		implements ILocaleCollection {
		
		private var _locales:Array;
		
		/**
		*	Creates a <code>LocaleCollection</code> instance.	
		*/
		public function LocaleCollection()
		{
			super();
			_locales = new Array();
		}
		
		/**
		*	@inheritDoc
		*/
		public function getLocaleByLanguage( lang:String ):ILocale
		{
			var locale:ILocale = null;
			for( var i:int = 0;i < _locales.length;i++ )
			{
				locale = ILocale( _locales[ i ] );
				if( locale.lang == lang )
				{
					return locale;
				}
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function getLocaleByLanguageAndCountry(
			lang:String, country:String ):ILocale
		{
			var locale:ILocale = null;
			for( var i:int = 0;i < _locales.length;i++ )
			{
				locale = ILocale( _locales[ i ] );
				if( locale.lang == lang && locale.country == country )
				{
					return locale;
				}
			}
			
			return null;
		}
		
		/**
		*	@inheritDoc
		*/
		public function hasLocale( locale:ILocale ):Boolean
		{
			var stored:ILocale = null;
			for( var i:int = 0;i < _locales.length;i++ )
			{
				stored = ILocale( _locales[ i ] );
				if( stored.equals( locale ) )
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		*	@inheritDoc
		*/
		public function addLocale( locale:ILocale ):int
		{
			if( locale != null && !hasLocale( locale ) )
			{
				_locales.push( locale );
			}
			
			return length;
		}
		
		/**
		*	@inheritDoc
		*/
		public function removeLocale( locale:ILocale ):int
		{
			for( var i:int = 0;i < _locales.length;i++ )
			{
				if( locale === _locales[ i ] )
				{
					_locales.splice( i, 1 );
				}
			}
			
			return length;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function clear():void
		{
			_locales = new Array();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get length():int
		{
			return _locales.length;
		}
	}
}