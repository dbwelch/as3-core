package com.ffsys.di
{
	
	
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