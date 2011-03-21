package org.flashx.swat.core
{
	import org.flashx.utils.properties.IProperties;
		
	/**
	*	Describes the contract for implementations that are aware
	* 	of the application error messages.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IErrorMessagesAware
	{
		/**
		* 	The application error messages.
		*/
		function get errors():IProperties;
		function set errors( value:IProperties ):void;
	}
}