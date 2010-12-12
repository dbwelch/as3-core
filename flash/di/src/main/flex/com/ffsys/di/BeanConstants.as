package com.ffsys.di
{
	/**
	*	Encapsulates constants for the dependency injection package.
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
		*	The delimiter used in reference expressions to delimit
		* 	a property from the bean name.
		*/
		public static const REFERENCE_PROPERTY_DELIMITER:String = ".";
		
		/**
		*	Represents hexadecimal number notation.
		*/
		public static const HEX_NUMBER:String = "#";
		
		/**
		* 	The name of the bean descriptor that defines constants for the
		* 	bean document.
		*/
		public static const CONSTANTS_PROPERTY_NAME:String = "constants";			
		
		/**
		*	Represents a bean expression that references a class.
		*	
		*	The class must be available when the bean document is
		*	parsed.
		*/
		public static const CLASS_EXPRESSION:String = "class";
		
		/**
		*	Represents an external bean url expression.
		*/
		public static const URL_EXPRESSION:String = "url";
	
		/**
		*	Represents a reference to a bean or bean property
		* 	in the same document.
		*/
		public static const REF_EXPRESSION:String = "ref";
		
		/**
		*	Represents a reference to a bean constant declaration.
		*/
		public static const CONSTANT_EXPRESSION:String = "constant";
		
		/**
		*	Represents an array collection expression.
		*/
		public static const ARRAY_EXPRESSION:String = "array";
		
		/**
		*	Represents an external bean bitmap expression.
		*/
		public static const BITMAP_EXPRESSION:String = "img";
		
		/**
		*	Represents an external bean sound expression.
		*/
		public static const SOUND_EXPRESSION:String = "sound";
		
		/**
		*	Represents an external bean swf movie expression.
		*/
		public static const SWF_EXPRESSION:String = "swf";
		
		/**
		*	Represents an external bean xml document expression.
		*/
		public static const XML_EXPRESSION:String = "xml";
		
		/**
		*	Represents an external bean text document expression.
		*/
		public static const TEXT_EXPRESSION:String = "text";
	}
}