package org.flashx.swat.configuration
{	
	import org.flashx.swat.configuration.locale.ILocaleManager;
	
	/**
	*	Represents the configuration for a module.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.12.2010
	*/
	public class ModuleConfiguration extends ConfigurationElement
		implements IModuleConfiguration
	{
		private var _configuration:IConfigurationElement;
		private var _moduleLocales:ILocaleManager;
		
		/**
		* 	Creates a <code>ModuleConfiguration</code> instance.
		*/
		public function ModuleConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get configuration():IConfigurationElement
		{
			return _configuration;
		}
		
		public function set configuration( value:IConfigurationElement ):void
		{
			_configuration = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get moduleLocales():ILocaleManager
		{
			return _moduleLocales;
		}
		
		public function set moduleLocales( value:ILocaleManager ):void
		{
			_moduleLocales = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			_configuration = null;
			_moduleLocales = null;
		}
	}
}