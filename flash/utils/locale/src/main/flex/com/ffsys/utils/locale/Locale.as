package com.ffsys.utils.locale {
	
	/**
	*	Encapsulates information about
	*	a locale.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.05.2008
	*/
	public class Locale extends Object
		implements ILocale {
			
		/**
		*	The English (British) locale.	
		*/
		public static const EN_GB:ILocale = new Locale( "en", "GB" );
		
		/**
		*	The English (United States) locale. 	
		*/
		public static const EN_US:ILocale = new Locale( "en", "US" );

		private var _lang:String;
		private var _country:String;
		
		/**
		*	Creates a <code>Locale</code> instance.
		*	
		*	@param lang The language code.
		*	@param country The country code.
		*/
		public function Locale(
			lang:String = null,
			country:String = null )
		{
			super();
			this.lang = lang;
			this.country = country;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set lang( val:String ):void
		{
			_lang = val;
		}
		
		public function get lang():String
		{
			return _lang;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set country( val:String ):void
		{
			_country = val;
		}
		
		public function get country():String
		{
			return _country;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function equals( locale:ILocale ):Boolean
		{
			return ( locale != null ) &&
				( this.lang == locale.lang ) && ( this.country == locale.country );
		}
	}
}