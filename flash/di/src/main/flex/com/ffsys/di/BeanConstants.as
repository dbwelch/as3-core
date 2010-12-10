package com.ffsys.di
{
	
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
		*/
		public static const INSTANCE_CLASS_PROPERTY:String = "instanceClass";
	
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
		*	Represents a bean expression that references a class.
		*	
		*	The class must be available when the bean document is
		*	parsed.
		*/
		public static const CLASS:String = "class";
		
		/**
		*	Represents an external bean url expression.
		*/
		public static const URL:String = "url";		
	
		/**
		*	Represents a reference to a bean or bean property
		* 	in the same document.
		*/
		public static const REF:String = "ref";
		
		/**
		*	Represents a reference to a bean constant declaration.
		*/
		public static const CONSTANT:String = "constant";
		
		/**
		*	Represents a reference to a method definition.
		*/
		public static const METHOD:String = "method";
		
		/**
		*	Represents an array collection expression.
		*/
		public static const ARRAY:String = "array";
		
		/**
		*	Represents an external bean bitmap expression.
		*/
		public static const BITMAP:String = "img";
		
		/**
		*	Represents an external bean sound expression.
		*/
		public static const SOUND:String = "sound";
		
		/**
		*	Represents an external bean swf movie expression.
		*/
		public static const SWF:String = "swf";		
		
		/**
		*	The delimiter used in reference expressions to delimit
		* 	a property from the bean name.
		*/
		public static const REFERENCE_PROPERTY_DELIMITER:String = ".";
		
		/**
		*	Represents hexadecimal number notation.
		*/
		public static const HEX_NUMBER:String = "#";
		
		
		/**
		* 	The name of the style that defines constants for the
		* 	stylesheet.
		*/
		public static const CONSTANTS_PROPERTY_NAME:String = "constants";						
	}
}