package com.ffsys.ioc.mock
{
	/**
	*	Describes the contract for mock controllers.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public interface IMockController
	{
		
		/**
		* 	The messages for the application are exposed to all controllers.
		*/
		function get messages():MockMessagesBean;
		function set messages( value:MockMessagesBean ):void;
		
		/**
		* 	The application configuration is exposed to all controllers.
		*/
		function get configuration():MockConfigurationBean;
		function set configuration( value:MockConfigurationBean ):void;		
	}
}