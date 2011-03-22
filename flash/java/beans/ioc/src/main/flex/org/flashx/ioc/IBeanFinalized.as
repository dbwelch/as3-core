package org.flashx.ioc
{
	/**
	*	Describes the contract for bean implementations that wish to be
	* 	notified when they are fully constructed and finalized.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.12.2010
	*/
	public interface IBeanFinalized
	{
		/**
		* 	Invoked after a bean is finalized.
		*/
		function finalized():void;
	}
}