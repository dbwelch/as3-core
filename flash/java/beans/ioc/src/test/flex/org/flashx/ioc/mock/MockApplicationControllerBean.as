package org.flashx.ioc.mock
{
	
	/**
	*	Represents a mock application controller bean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public class MockApplicationControllerBean extends Object
	{
		private var _controller:IMockController;
		
		/**
		* 	Creates a <code>MockApplicationControllerBean</code> instance.
		*/
		public function MockApplicationControllerBean()
		{
			super();
		}
		
		/**
		* 	The current top level controller.
		*/
		public function get controller():IMockController
		{
			return _controller;
		}
		
		public function set controller( value:IMockController ):void
		{
			_controller = value;
		}
	}
}