package com.ffsys.ioc
{
	/**
	*	Encapsulates constants for the inversion of control package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanConstants extends Object
	{
		/**
		* 	The name of the bean property that indicates a bean
		* 	should be treated as a singleton instance.
		*/
		public static const SINGLETON_PROPERTY:String = "singleton";
	
		/**
		* 	The name of the property used to determine whether a bean
		* 	represents a custom class to instantiate when retrieving the bean.
		* 
		* 	This should be a <code>class</code> expression.
		*/
		public static const INSTANCE_CLASS_PROPERTY:String = "instanceClass";
		
		/**
		* 	The name of the property used to determine whether a bean uses
		* 	a factory method for instantiation.
		* 
		* 	This should be a <code>ref</code> expression.
		*/
		public static const FACTORY_PROPERTY:String = "factory";
		
		/**
		* 	The name of the property used to determine the parameters
		* 	for a method call.
		* 
		* 	This should be an <code>array</code> expression.
		*/
		public static const PARAMETERS_PROPERTY:String = "parameters";
	
		/**
		* 	The name of the property used to determine whether a bean
		* 	represents a static class reference.
		*/
		public static const STATIC_CLASS_PROPERTY:String = "staticClass";
		
		/**
		* 	The name of the property used to determine whether a bean
		* 	is a function reference.
		*/
		public static const METHOD_PROPERTY:String = "method";
		
		/**
		* 	The name of the property used to set the identifier for the bean.
		*/
		public static const ID_PROPERTY:String = "id";
		
		/**
		* 	The name of the property used to determine the file resolution
		* 	policy for external file expressions.
		* 
		* 	By default all file expressions are resolved in the context of the
		* 	bean document when the bean document is loaded.
		* 
		* 	To prevent this behaviour and have file dependencies handled
		* 	at the bean level specify this property with a value <code>bean</code>.
		*/
		public static const FILE_POLICY_PROPERTY:String = "filePolicy";
		
		/**
		*	The delimiter used in reference expressions to delimit
		* 	a property from the bean name.
		*/
		public static const REFERENCE_PROPERTY_DELIMITER:String = ".";
		
		/**
		*	Represents hexadecimal number notation.
		*/
		public static const HEX_NUMBER:String = "#";
	}
}