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
		*	Determines whether two locales are equal.
		*	
		*	@param locale The locale to compare against.
		*	
		*	@return A boolean indicating whether they are equal.	
		*/
		function equals( locale:ILocale ):Boolean;	
		
		/**
		*	The value to use when building
		*	locale specific links.
		*/
		function set uriNode( val:String ):void;
		function get uriNode():String;
	}
}