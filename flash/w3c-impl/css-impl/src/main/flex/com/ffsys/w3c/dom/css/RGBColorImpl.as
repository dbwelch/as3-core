package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSPrimitiveValue;
	import org.w3c.dom.css.RGBColor;
	
	/**
	* 	Represents a CSS RGB color.
	*/
	public class RGBColorImpl extends Object
		implements RGBColor
	{
		private var _red:CSSPrimitiveValue;
		private var _green:CSSPrimitiveValue;
		private var _blue:CSSPrimitiveValue;
		
		/**
		* 	Creates a <code>RGBColorImpl</code> instance.
		*/
		public function RGBColorImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get red():CSSPrimitiveValue
		{
			return _red;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get green():CSSPrimitiveValue
		{
			return _green;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get blue():CSSPrimitiveValue
		{
			return _blue;
		}
	}
}