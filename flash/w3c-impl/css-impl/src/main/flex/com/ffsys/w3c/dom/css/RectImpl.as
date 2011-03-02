package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSPrimitiveValue;
	import org.w3c.dom.css.Rect;
	
	/**
	* 	Represents a CSS rectangle.
	*/
	public class RectImpl extends Object
		implements Rect
	{	
		private var _top:CSSPrimitiveValue;
		private var _right:CSSPrimitiveValue;
		private var _bottom:CSSPrimitiveValue;	
		private var _left:CSSPrimitiveValue;
		
		/**
		* 	Creates a <code>RectImpl</code> instance.
		*/
		public function RectImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get top():CSSPrimitiveValue
		{
			return _top;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get right():CSSPrimitiveValue
		{
			return _right;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get bottom():CSSPrimitiveValue
		{
			return _bottom;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get left():CSSPrimitiveValue
		{
			return _left;
		}
	}
}