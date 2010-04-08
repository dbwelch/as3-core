package com.ffsys.utils.locale {
	
	/**
	*	Encapsulates information about the
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
		*	@private
		*/
		private var _lang:String;
		
		/**
		*	@private
		*/
		private var _country:String;
		
		/**
		*	@private
		*/
		private var _uriNode:String;
		
		/**
		*	Creates a <code>Locale</code> instance.
		*/
		public function Locale()
		{
			super();
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
			return ( this.lang == locale.lang ) && ( this.country == locale.country );
		}
		
		/**
		*	@inheritDoc	
		*/		
		public function set uriNode( val:String ):void
		{
			_uriNode = val;
		}
		
		public function get uriNode():String
		{
			return _uriNode;
		}			
	}
}