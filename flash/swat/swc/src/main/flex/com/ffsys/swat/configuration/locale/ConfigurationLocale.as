package com.ffsys.swat.configuration.locale {
	
	import com.ffsys.utils.locale.Locale;
	import com.ffsys.swat.configuration.rsls.IRuntimeResourceCollection;
	
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
			
		private var _messages:IRuntimeResourceCollection;
		private var _errors:IRuntimeResourceCollection;
		private var _fonts:IRuntimeResourceCollection;
		
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
		public function get messages():IRuntimeResourceCollection
		{
			return _messages;
		}
		
		public function set messages( value:IRuntimeResourceCollection ):void
		{
			_messages = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get errors():IRuntimeResourceCollection
		{
			return _errors;
		}
		
		public function set errors( value:IRuntimeResourceCollection ):void
		{
			_errors = value;
		}
		
		/**
		*	@inheritDoc
		*/
		public function get fonts():IRuntimeResourceCollection
		{
			return _fonts;
		}
		
		public function set fonts( value:IRuntimeResourceCollection ):void
		{
			_fonts = value;
		}
	}
}