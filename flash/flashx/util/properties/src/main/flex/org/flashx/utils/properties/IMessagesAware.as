package org.flashx.utils.properties
{		
	/**
	*	Describes the contract for implementations that are aware
	* 	of a collection of properties that represent messages.
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
		* 	The message properties.
		*/
		function get messages():IProperties;
		function set messages( value:IProperties ):void;
	}
}