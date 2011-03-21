package org.flashx.swat.configuration.locale {
	
	import org.flashx.utils.locale.Locale;
	
	import org.flashx.swat.configuration.rsls.IResourceDefinitionManager;
	
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
			
		private var _resources:IResourceDefinitionManager;
		private var _prefix:String;
		
		/**
		*	Creates a <code>ConfigurationLocale</code> instance.
		* 
		*	@param lang The language code.
		*	@param country The country code.
		*/
		public function ConfigurationLocale(
			lang:String = null,
			country:String = null )
		{
			super( lang, country );
		}
		
		/**
		*	@inheritDoc	
		*/
		public function get resources():IResourceDefinitionManager
		{
			return _resources;
		}
		
		public function set resources( value:IResourceDefinitionManager ):void
		{
			_resources = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getPrefix( delimiter:String = "-" ):String
		{
			return this.lang + delimiter + this.country;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get prefix():String
		{
			if( _prefix == null )
			{
				return getPrefix();
			}
			
			return _prefix;
		}
		
		public function set prefix( prefix:String ):void
		{
			_prefix = prefix;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clone():IConfigurationLocale
		{
			var output:IConfigurationLocale = new ConfigurationLocale(
				this.lang, this.country );
			output.resources = this.resources;
			output.prefix = _prefix;
			return output;
		}
	}
}