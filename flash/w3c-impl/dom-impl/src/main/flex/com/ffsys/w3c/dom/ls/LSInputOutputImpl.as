package com.ffsys.w3c.dom.ls
{
	
	/**
	* 	An abstract super class for the LSInput and
	* 	LSOutput implementations.
	*/
	public class LSInputOutputImpl extends Object
	{
		private var _e4x:XML;
		
		/**
		* 	Creates an <code>LSInputOutputImpl</code> instance.
		*/
		public function LSInputOutputImpl()
		{
			super();
		}
		
		/**
		* 	Indicates that this input or output sink
		* 	should read from or write to a native XML
		* 	instance.
		* 
		* 	When this property is declared it takes precedence
		* 	over all other input/output sink types.
		*/
		public function get e4x():XML
		{
			return _e4x;
		}
		
		public function set e4x( value:XML ):void
		{
			_e4x = value;
		}
	}
}