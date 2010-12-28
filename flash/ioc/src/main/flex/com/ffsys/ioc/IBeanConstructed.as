package com.ffsys.ioc
{
	
	/**
	*	Describes the contract for bean implementations that wish to be
	* 	notified when they are fully constructed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.12.2010
	*/
	public interface IBeanConstructed
	{
		/**
		* 	Invoked after a bean is fully constructed.
		*/
		function constructed():void;
	}
}