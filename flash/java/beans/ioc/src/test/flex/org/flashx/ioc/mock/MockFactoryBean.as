package org.flashx.ioc.mock
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
		public static function getLoaderInstance( type:String = null ):MockLoaderBean
		{
			if( type == null )
			{
				type = "test";
			}
			//trace("MockFactoryBean::getLoaderInstance()" );
			return new MockLoaderBean( type );
		}
	}
}