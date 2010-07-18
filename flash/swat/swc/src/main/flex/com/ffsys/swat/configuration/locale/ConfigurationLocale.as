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
			
		private var _resources:ILocaleResources;
		
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
		public function get resources():ILocaleResources
		{
			return _resources;
		}
		
		public function set resources( value:ILocaleResources ):void
		{
			_resources = value;
		}
	}
}