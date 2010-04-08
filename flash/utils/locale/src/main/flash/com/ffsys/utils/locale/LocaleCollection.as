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
	public class LocaleCollection extends Object {
		
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
		*	Attempts to find a locale by language identifier.
		*	
		*	@param lang The language code.
		*	
		*	@return The locale if found otherwise null.
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
		*	Determines whether a locale is already stored in this collection.
		*	
		*	@param locale The locale to test for existence.
		*	
		*	@return A boolean indicating whether the locale exists in this
		*	collection.
		*/
		public function hasLocale( locale:ILocale ):Boolean
		{
			for( var i:int = 0;i < _locales.length;i++ )
			{
				if( locale === _locales[ i ] )
				{
					return true;
				}
			}
			
			return false;
		}
		
		/**
		*	Adds a locale to this collection. If the locale is already
		*	present in the collection it will not be added.
		*	
		*	@param locale The locale to add.
		*	
		*	@return The number of locales in the collection.
		*/
		public function addLocale( locale:ILocale ):int
		{
			if( locale != null && !hasLocale( locale ) )
			{
				_locales.push( locale );
			}
			
			return getLength();
		}
		
		/**
		*	Removes a locale from this collection.
		*	
		*	@param locale The locale to remove.
		*	
		*	@return The number of locales in the collection.	
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
			
			return getLength();
		}
		
		/**
		*	Gets the number of locales in this collection.
		*	
		*	@return The number of locales in this collection.	
		*/
		public function getLength():int
		{
			return _locales.length;
		}
	}
}