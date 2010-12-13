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
		*	An expression to reference a linked class.
		* 
		* 	The class must be available when this expression is resolved.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to <code>Class</code>.
		*/
		public static const CLASS_EXPRESSION:String = "class";
		
		/**
		*	An expression to create a url.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to <code>URLRequest</code>.
		*/
		public static const URL_EXPRESSION:String = "url";
	
		/**
		*	An expression that references another bean in the same document.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to the result of evaluating the bean reference.
		*/
		public static const REF_EXPRESSION:String = "ref";
		
		/**
		*	An expression that references a declared constant.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to the result of evaluating the constant property.
		*/
		public static const CONSTANT_EXPRESSION:String = "constant";
		
		/**
		*	An expression to create an array.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to <code>Array</code>.
		*/
		public static const ARRAY_EXPRESSION:String = "array";
		
		/**
		*	An expression to load an image file.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to <code>BitmapData</code>.
		*/
		public static const BITMAP_EXPRESSION:String = "img";
		
		/**
		*	An expression to load a sound file.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to a <code>Sound</code>.
		*/
		public static const SOUND_EXPRESSION:String = "sound";
		
		/**
		*	An expression to load a flash movie.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to a <code>Loader</code>.
		*/
		public static const SWF_EXPRESSION:String = "swf";
		
		/**
		*	An expression to load an <code>XML</code> document.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to <code>XML</code>.
		*/
		public static const XML_EXPRESSION:String = "xml";
		
		/**
		*	An expression to load a plain text file.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to a <code>String</code>.
		*/
		public static const TEXT_EXPRESSION:String = "text";
		
		/**
		*	An expression to load a properties file with messages.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to an <code>IProperties</code>.
		*/
		public static const MESSAGES_EXPRESSION:String = "messages";
		
		/**
		*	An expression to load a flash movie containing fonts.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to an <code>Array</code> of <code>Font</code>
		* 	instances representing the fonts registered when the font
		* 	loader parsed the loaded font data.
		*/
		public static const FONT_EXPRESSION:String = "font";
		
		/**
		*	An expression to declare a point.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to a <code>Point</code>.
		*/
		public static const POINT_EXPRESSION:String = "point";
		
		/**
		*	An expression to declare a rectangle.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to a <code>Rectangle</code>.
		*/
		public static const RECTANGLE_EXPRESSION:String = "rect";
		
		/**
		*	An expression to declare a matrix.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to a <code>Matrix</code>.
		*/
		public static const MATRIX_EXPRESSION:String = "matrix";
		
		/**
		*	An expression to declare a color transform.
		* 
		* 	When this expression is evaluated the resulting property
		* 	will be set to a <code>ColorTransform</code>.
		*/
		public static const COLOR_TRANSFORM_EXPRESSION:String = "color";
	}
}