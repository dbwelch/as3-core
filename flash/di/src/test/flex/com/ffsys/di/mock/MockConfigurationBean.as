package com.ffsys.di.mock
{
	/**
	*	Represents a mock configuration bean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public class MockConfigurationBean extends Object
	{
		private var _locales:MockLocaleManager;
		
		/**
		* 	Creates a <code>MockConfigurationBean</code> instance.
		*/
		public function MockConfigurationBean()
		{
			super();
		}
		
		/**
		* 	A mock locale manager bean.
		*/
		public function get locales():MockLocaleManager
		{
			return _locales;
		}
		
		public function set locales( value:MockLocaleManager ):void
		{
			_locales = value;
		}
	}
}