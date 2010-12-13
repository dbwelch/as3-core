package com.ffsys.di.mock
{

	/**
	*	Represents a mock application bean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public class MockApplicationBean extends Object
	{
		private var _configuration:MockConfigurationBean;
	
		/**
		* 	Creates a <code>MockApplicationBean</code> instance.
		*/
		public function MockApplicationBean()
		{
			super();
		}
		
		/**
		* 	A mock application configuration.
		*/
		public function get configuration():MockConfigurationBean
		{
			return _configuration;
		}
		
		public function set configuration( value:MockConfigurationBean ):void
		{
			_configuration = value;
		}
	}
}