package com.ffsys.ioc
{
	/**
	*	Describes the contract for implementations that provide
	* 	access to stored beans.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  12.12.2010
	*/
	public interface IBeanAccess
	{
		/**
		* 	Attempts to retrieve an instance of a bean.
		* 	
		* 	@param beanName The bean descriptor identifier.
		* 
		* 	@return An instance of the bean or null if no matching
		* 	bean descriptor was located.
		*/
		function getBean( beanName:String ):Object;		
	}
}