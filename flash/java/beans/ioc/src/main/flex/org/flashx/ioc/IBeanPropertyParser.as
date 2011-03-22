package org.flashx.ioc
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
		extends IBeanDocumentAware
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
			
		/**
		* 	Allows text element parsers to modify the property
		* 	name or value.
		* 
		* 	@param descriptor The bean descriptor.
		* 	@param name The property name.
		* 	@param value The value being assigned to the property.
		* 
		* 	@return An object with <code>name</code> and <code>value</code>
		* 	properties containing either the original parsed name and value
		* 	or modifications of those properties.
		*/
		function doWithProperty(
			descriptor:IBeanDescriptor,
			name:String,
			value:* ):Object;
	}
}