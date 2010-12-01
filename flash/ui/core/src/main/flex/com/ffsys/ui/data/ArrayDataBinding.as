package com.ffsys.ui.data
{
	/**
	*	Concrete implementation for a data binding that encapsulates
	* 	an array.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public class ArrayDataBinding extends DataBinding
	{
		/**
		* 	Creates a <code>ArrayDataBinding</code> instance.
		* 
		* 	@param value The array this data binding encapsulates.
		*/
		public function ArrayDataBinding( value:Array = null )
		{
			super( value );
		}
		
		/**
		* 	The array associated with this data binding.
		*/
		public function get value():Array
		{
			return _data as Array;
		}
		
		public function set value( value:Array ):void
		{
			_data = value;
		}
	}
}