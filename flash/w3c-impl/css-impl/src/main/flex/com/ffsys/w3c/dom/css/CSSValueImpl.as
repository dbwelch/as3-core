package com.ffsys.w3c.dom.css
{
	import org.w3c.dom.css.CSSValue;
	
	import com.ffsys.w3c.dom.NodeImpl;
	
	/**
	* 	Represents a CSS value.
	*/
	public class CSSValueImpl extends NodeImpl
		implements CSSValue
	{
		/**
		* 	@private
		*/
		protected var __cssValueType:uint;
		
		private var _cssText:String;
		
		/**
		* 	Creates a <code>CSSValueImpl</code> instance.
		*/
		public function CSSValueImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get cssText():String
		{
			return _cssText;
		}
		
		public function set cssText( text:String ):void
		{
			_cssText = text;
		}
		
		/**
		* 	A code defining the type of the value.
		*/
		public function get cssValueType():uint
		{
			return __cssValueType;
		}		
	}
}