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
		private var _configuration:IConfiguration;
		
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
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
		
		public function set configuration( value:IConfiguration ):void
		{
			_configuration = value;
		}
	}
}