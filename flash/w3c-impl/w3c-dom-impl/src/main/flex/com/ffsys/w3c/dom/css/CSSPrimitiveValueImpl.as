package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSPrimitiveValue;
	
	/**
	*	Represents a CSS primitive value. 	
	*/
	public class CSSPrimitiveValueImpl extends CSSValueImpl
		implements CSSPrimitiveValue
	{	
		/**
		* 	The value is not a recognized CSS2 value.
		* 
		* 	The value can only be obtained by using the cssText attribute.
		*/
		public static const CSS_UNKNOWN:uint                    = 0;
		
		/**
		* 	The value is a simple number. The value can be obtained
		* 	by using the getFloatValue method.
		*/
		public static const CSS_NUMBER:uint                     = 1;
		
		/**
		* 	The value is a percentage.
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_PERCENTAGE:uint                 = 2;
		
		/**
		* 	The value is a length (ems).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_EMS:uint                        = 3;
		
		/**
		* 	The value is a length (exs).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_EXS:uint                        = 4;
		
		/**
		* 	The value is a length (px).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_PX:uint                         = 5;
		
		/**
		* 	The value is a length (cm).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_CM:uint                         = 6;
		
		/**
		* 	The value is a length (mm).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_MM:uint                         = 7;
		
		/**
		* 	The value is a length (in).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_IN:uint                         = 8;
		
		/**
		* 	The value is a length (pt).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_PT:uint                         = 9;
		
		/**
		* 	The value is a length (pc).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_PC:uint                         = 10;
		
		/**
		* 	The value is an angle (deg).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_DEG:uint                        = 11;
		
		/**
		* 	The value is an angle (rad).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_RAD:uint                        = 12;
		
		/**
		* 	The value is an angle (grad).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_GRAD:uint                       = 13;
		
		/**
		* 	The value is a time (ms).
		* 	
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_MS:uint                         = 14;
		
		/**
		* 	The value is a time (s).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_S:uint                          = 15;
		
		/**
		* 	The value is a frequency (Hz).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_HZ:uint                         = 16;
		
		/**
		* 	The value is a frequency (kHz).
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_KHZ:uint                        = 17;		
		
		/**
		* 	The value is a number with an unknown dimension.
		* 
		* 	The value can be obtained by using the getFloatValue method.
		*/
		public static const CSS_DIMENSION:uint                  = 18;
		
		/**
		* 	The value is a String.
		* 
		* 	The value can be obtained by using the getStringValue method.
		*/
		public static const CSS_STRING:uint                     = 19;
		
		/**
		* 	The value is a URI.
		* 
		* 	The value can be obtained by using the getStringValue method.
		*/
		public static const CSS_URI:uint                        = 20;
		
		/**
		* 	The value is an identifier.
		* 
		* 	The value can be obtained by using the getStringValue method.
		*/
		public static const CSS_IDENT:uint                      = 21;		
		
		/**
		* 	The value is a attribute function.
		* 
		* 	The value can be obtained by using the getStringValue method.
		*/
		public static const CSS_ATTR:uint                       = 22;
		
		/**
		* 	The value is a counter or counters function.
		* 
		* 	The value can be obtained by using the getCounterValue method.
		*/
		public static const CSS_COUNTER:uint                    = 23;
		
		/**
		* 	The value is a rect function.
		* 
		* 	The value can be obtained by using the getRectValue method.
		*/
		public static const CSS_RECT:uint                       = 24;
		
		/**
		* 	The value is a RGB color.
		* 
		* 	The value can be obtained by using the getRGBColorValue method.
		*/
		public static const CSS_RGBCOLOR:uint                   = 25;
		
		/**
		* 	Creates a <code>CSSPrimitiveValueImpl</code> instance.
		*/
		public function CSSPrimitiveValueImpl()
		{
			super();
		}
	}
}