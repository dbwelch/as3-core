package com.ffsys.ioc.mock
{

	public class MockFactoryBean extends Object
	{
		
		/**
		* 	Creates a <code>MockFactoryBean</code> instance.
		*/
		public function MockFactoryBean()
		{
			super();
		}
		
		/**
		* 	Creates a mock loader bean.
		*/
		public static function getLoaderInstance():MockLoaderBean
		{
			//trace("MockFactoryBean::getLoaderInstance()" );
			return new MockLoaderBean( "test" );
		}
	}
}