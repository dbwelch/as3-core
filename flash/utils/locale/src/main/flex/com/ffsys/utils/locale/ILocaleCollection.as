package com.ffsys.utils.locale {
	
	/**
	*	Describes the contract for collections of locales.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public interface ILocaleCollection {
		
		/**
		*	Attempts to find a locale by language identifier.
		*	
		*	@param lang The language code.
		*	
		*	@return The locale if found otherwise null.
		*/
		function getLocaleByLanguage( lang:String ):ILocale;
		
		/**
		*	Attempts to find a locale by language identifier and country.
		*	
		*	@param lang The language code.
		*	@param country The country identifier.
		*	
		*	@return The locale if found otherwise null.
		*/
		function getLocaleByLanguageAndCountry(
			lang:String, country:String ):ILocale;
		
		/**
		*	Determines whether a locale is already stored in this collection.
		*	
		*	Note that this method does not compare on an instance level but
		*	uses the <code>equals</code> method of <code>ILocale</code> for
		*	comparison.
		*	
		*	@param locale The locale to test for existence.
		*	
		*	@return A boolean indicating whether the locale exists in this
		*	collection.
		*/
		function hasLocale( locale:ILocale ):Boolean;
		
		/**
		*	Adds a locale to this collection. If the locale is already
		*	present in the collection it will not be added.
		*	
		*	@param locale The locale to add.
		*	
		*	@return The number of locales in the collection.
		*/
		function addLocale( locale:ILocale ):int;
		
		/**
		*	Removes a locale from this collection.
		*	
		*	@param locale The locale to remove.
		*	
		*	@return The number of locales in the collection.	
		*/
		function removeLocale( locale:ILocale ):int;
		
		/**
		*	Clears all locales stored in this collection.	
		*/
		function clear():void;
		
		/**
		*	Gets the number of locales in this collection.
		*	
		*	@return The number of locales in this collection.	
		*/
		function get length():int;
		
		/**
		*	Gets a copy of the underlying array of locales.
		*/
		function getLocales():Array;
	}
}