package com.ffsys.swat.core
{
	import com.ffsys.utils.properties.IProperties;
		
	/**
	*	Describes the contract for implementations that are aware
	* 	of the application messages.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IMessagesAware
	{
		/**
		* 	The application messages.
		*/
		function get messages():IProperties;
		function set messages( value:IProperties ):void;
	}
}