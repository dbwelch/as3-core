package com.ffsys.ioc.mock
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
		private	var _messages:MockMessagesBean;
		private var _applicationController:MockApplicationControllerBean;
	
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
		
		/**
		* 	A mock bean for the application messages.
		*/
		public function get messages():MockMessagesBean
		{
			return _messages;
		}
		
		public function set messages( value:MockMessagesBean ):void
		{
			_messages = value;
		}
		
		/**
		* 	A mock bean for the main application controller.
		*/
		public function get applicationController():MockApplicationControllerBean
		{
			return _applicationController;
		}
		
		public function set applicationController( value:MockApplicationControllerBean ):void
		{
			_applicationController = value;
		}
	}
}