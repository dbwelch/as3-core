package com.ffsys.ioc
{
	
	/**
	*	Describes the contract for implementations responsible for
	* 	parsing an individual bean property declaration.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public interface IBeanPropertyParser
	{
		/**
		* 	Parses a bean property.
		* 
		* 	@param descriptor The bean descriptor.
		* 	@param bean The name of the bean.
		* 	@param propertyName The name of the bean property.
		* 	@param value The parsed value.
		* 
		* 	@return The parsed object.
		*/
		function parse(
			descriptor:IBeanDescriptor,
			beanName:String,
			propertyName:String,
			value:String ):Object;	
	}
}