package com.ffsys.ioc.mock
{
	/**
	*	Represents a mock locale manager bean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public class MockLocaleManager extends Object
	{
		//nested circular reference that fails
		//public var application:MockApplicationBean;
		
		/**
		* 	Creates a <code>MockLocaleManager</code> instance.
		*/
		public function MockLocaleManager()
		{
			super();
		}
	}
}