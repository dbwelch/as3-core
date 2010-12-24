package com.ffsys.swat.core
{
	import com.ffsys.ioc.*;	

	/**
	* 	Represents the default application beans configured before
	* 	the xml configuration is parsed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.12.2010
	*/
	public class ApplicationBeanConfiguration extends Object
		implements IBeanConfiguration
	{
		
		/**
		* 	Creates an <code>ApplicationBeanConfiguration</code> instance.
		*/
		public function ApplicationBeanConfiguration()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function doWithBeans(
			beans:IBeanDocument ):void
		{
			trace("ApplicationBeanConfiguration::doWithBeans()", beans );
		}
	}
}