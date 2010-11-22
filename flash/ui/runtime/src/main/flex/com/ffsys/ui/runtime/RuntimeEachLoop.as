package com.ffsys.ui.runtime
{
	import com.ffsys.ui.containers.Canvas;
	
	/**
	*	Represents a view that iterates over a complex object
	* 	and creates a child view for each item in the object.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  22.11.2010
	*/	
	public class RuntimeEachLoop extends Canvas
	{
		private var _provider:String;
		
		/**
		* 	Creates a <code>RuntimeEachLoop</code> instance.
		*/
		public function RuntimeEachLoop()
		{
			super();
		}
		
		/**
		* 	The string representing the reference to the complex
		* 	object to iterate over.
		*/
		public function get provider():String
		{
			return _provider;
		}
		
		public function set provider( provider:String ):void
		{
			_provider = provider;
		}
	}
}