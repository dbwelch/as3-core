package com.ffsys.utils.text {
	
	import flash.text.TextField;
	
	/**
	*	Abstract super class for custom textfields.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.06.2010
	*/
	public class AbstractTextField extends TextField {
		
		private var _enabled:Boolean = false;
		
		/**
		*	Creates an <code>AbstractTextField</code> instance.
		*/
		public function AbstractTextField()
		{
			super();
		}
		
		public function get enabled():Boolean
		{
			return _enabled;
		}
		
		public function set enabled( enabled:Boolean ):void
		{
			mouseEnabled = enabled;
			_enabled = enabled;
		}
	}
}