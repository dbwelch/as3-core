package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.Locale;
	
	/**
	*	Represents a locale with additional configuration
	*	information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.07.2010
	*/
	public class ConfigurationLocale extends Locale
		implements IConfigurationLocale {
			
		private var _messages:String;
		private var _errors:String;
		private var _fonts:String;
		
		/**
		*	Creates a <code>ConfigurationLocale</code> instance.
		*/
		public function ConfigurationLocale()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get messages():String
		{
			return _messages;
		}
		
		public function set messages( value:String ):void
		{
			_messages = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get errors():String
		{
			return _errors;
		}
		
		public function set errors( value:String ):void
		{
			_errors = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get fonts():String
		{
			return _fonts;
		}
		
		public function set fonts( value:String ):void
		{
			_fonts = value;
		}
	}
}