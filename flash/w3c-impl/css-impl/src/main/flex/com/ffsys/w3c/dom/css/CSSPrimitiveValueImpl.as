package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.Counter;	
	import org.w3c.dom.css.CSSPrimitiveValue;
	import org.w3c.dom.css.Rect;
	import org.w3c.dom.css.RGBColor;
	import org.w3c.dom.css.ValueType;
	
	/**
	*	Represents a CSS primitive value. 	
	*/
	public class CSSPrimitiveValueImpl extends CSSValueImpl
		implements CSSPrimitiveValue
	{
		/**
		* 	@private
		*/
		protected var __cssPrimitiveType:uint = NaN;
		
		/**
		* 	Creates a <code>CSSPrimitiveValueImpl</code> instance.
		*/
		public function CSSPrimitiveValueImpl()
		{
			__cssValueType = ValueType.CSS_PRIMITIVE_VALUE;
			super();
		}
		
		/**
		*	@inheritDoc
		*/
		public function get primitiveType():uint
		{
			return __cssPrimitiveType;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getFloatValue( unitType:uint ):Number
		{
			//TODO
			return -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setFloatValue( unitType:uint, floatValue:Number ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getStringValue():String
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setStringValue( stringType:uint, stringValue:String ):void
		{
			//TODO
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getCounterValue():Counter
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getRectValue():Rect
		{
			//TODO
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getRGBColorValue():RGBColor
		{
			//TODO
			return null;
		}
	}
}