package com.ffsys.ioc
{
	
	/**
	*	Describes the contract for bean implementations
	* 	that wish to be notifier of the identifier that
	* 	was used to create the bean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.01.2011
	*/
	public interface IBeanNameAware
	{
		/**
		* 	The name of the bean.
		* 
		* 	This will match the <code>id</code> of the bean
		* 	descriptor if no <code>names</code> (aliases) have
		* 	been specified otherwise it will be the either <code>id</code>
		* 	or the name alias located when the bean was instantiated.
		*/
		function get beanName():String;
		function set beanName( value:String ):void;
	}
}