package org.flashx.swat.core
{
	import org.flashx.ioc.*;	
	
	/**
	* 	Describes the contract for implementations that perform
	* 	configuration of a beans document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.12.2010
	*/
	public interface IBeanConfiguration
	{
		/**
		* 	Performs configuration of the beans document.
		* 
		* 	@param beans The beans document.
		*/
		function doWithBeans(
			beans:IBeanDocument ):void;
	}
}