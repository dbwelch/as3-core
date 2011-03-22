package org.flashx.ioc.mock
{
	
	/**
	*	Represents a mock abstract controller.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public class MockAbstractController extends Object
		implements IMockController
	{
		private var _messages:MockMessagesBean;
		private var _configuration:MockConfigurationBean;
		
		/**
		* 	Creates a <code>MockAbstractController</code> instance.
		*/
		public function MockAbstractController()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
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
		* 	@inheritDoc
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