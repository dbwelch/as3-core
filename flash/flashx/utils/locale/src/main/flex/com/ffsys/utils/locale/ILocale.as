package com.ffsys.utils.locale {
	
	/**
	*	Describes the contract for instances
	*	that represent a locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.05.2008
	*/
	public interface ILocale {
		
		/**
		*	The ISO 639-1 language code.	
		*/
		function set lang( val:String ):void;
		function get lang():String;
		
		/**
		*	The ISO 3166-1 alpha-2 two character
		*	country code.	
		*/
		function set country( val:String ):void;
		function get country():String;
		
		/**
		*	Gets the language string consisting of concatenating
		*	the language with the country.
		*	
		*	@param delimiter The delimiter to use when concatenating.
		*	
		*	@return The language string representation of this locale.
		*/
		function getLanguage( delimiter:String = "_" ):String;		
		
		/**
		*	Determines whether two locales are equal.
		*	
		*	@param locale The locale to compare against.
		*	
		*	@return A boolean indicating whether they are equal.	
		*/
		function equals( locale:ILocale ):Boolean;
	}
}