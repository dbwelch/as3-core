package org.flashx.ioc.mock
{

	public class MockLoaderBean extends Object
	{
		private var _type:String;
		
		/**
		* 	Creates a <code>MockLoaderBean</code> instance.
		*/
		public function MockLoaderBean( type:String )
		{
			super();
			_type = type;
		}
		
		public function get type():String
		{
			return _type;
		}
	}
}