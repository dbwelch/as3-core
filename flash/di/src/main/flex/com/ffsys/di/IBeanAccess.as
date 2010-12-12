package com.ffsys.di
{

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