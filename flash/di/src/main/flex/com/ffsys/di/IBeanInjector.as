package com.ffsys.di
{
	/**
	*	Describes the contract for implementations that
	* 	can inject a bean value automatically.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public interface IBeanInjector
	{
		/**
		* 	Injects bean properties.
		* 
		* 	@param document The bean document storing the bean.
		* 	@param beanName The name of the bean.
		* 	@param bean The bean instance.
		* 
		* 	@return The modified bean.
		*/
		function inject(
			document:IBeanDocument,
			beanName:String,
			bean:Object ):Object;
	}
}