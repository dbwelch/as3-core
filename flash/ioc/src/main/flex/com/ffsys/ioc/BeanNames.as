package com.ffsys.ioc
{
	/**
	*	Encapsulates constants that represent bean names used by convention.
	* 
	* 	These bean names are considered to be <em>reserved</em> bean names
	* 	therefore you should not use these names when declaring beans.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public class BeanNames extends Object
	{
		/**
		* 	The name of the bean that defines the element parser
		* 	to use when parsing the bean definition.
		* 
		* 	All bean documents must delare this bean.
		*/
		public static const BEAN_ELEMENT_PARSER:String =
			"bean-element-parser";
		
		/**
		* 	The name of the bean that defines constants for the
		* 	bean document.
		*/
		public static const CONSTANTS_PROPERTY_NAME:String = "constants";
		
		/**
		* 	The name of the bean that defines an injector for the
		* 	bean document.
		*/
		public static const INJECTOR_NAME:String = "injector";
	}
}