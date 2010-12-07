package com.ffsys.ui.data
{
	/**
	*	Concrete implementation for a data binding that encapsulates
	* 	a number.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public class NumberDataBinding extends DataBinding
	{
		/**
		* 	Creates a <code>NumberDataBinding</code> instance.
		* 
		* 	@param value The numeric value this data binding encapsulates.
		*/
		public function NumberDataBinding( value:Number = 0 )
		{
			super( value );
		}
		
		/**
		* 	The numeric value associated with this data binding.
		*/
		public function get value():Number
		{
			return Number( this.data );
		}
		
		public function set value( value:Number ):void
		{
			this.data = value;
		}
	}
}