package com.ffsys.dom
{
	/**
	*	A container for the document body elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class Body extends BlockElement
	{
		private var _style:String;
		
		/**
		* 	Creates a <code>Body</code> instance.
		*/
		public function Body()
		{
			super();
		}
		
		/**
		* 	Inline css style declarations.
		*/
		public function get style():String
		{
			return _style;
		}
		
		public function set style( value:String ):void
		{
			//invalidate the inline style cache
			if( value != _style )
			{
				_inlineStyleCache = null;
			}
			_style = value;
		}
	}
}