package com.ffsys.swat.configuration
{
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
	}
}