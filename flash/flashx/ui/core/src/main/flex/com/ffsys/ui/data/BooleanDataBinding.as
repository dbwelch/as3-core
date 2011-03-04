package com.ffsys.ui.data
{
	/**
	*	Concrete implementation for a data binding that encapsulates
	* 	a boolean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public class BooleanDataBinding extends DataBinding
	{
		/**
		* 	Creates a <code>BooleanDataBinding</code> instance.
		* 
		* 	@param value The boolean value this data binding encapsulates.
		*/
		public function BooleanDataBinding( value:Boolean = false )
		{
			super( value );
		}
		
		/**
		* 	The boolean value associated with this data binding.
		*/
		public function get value():Boolean
		{
			return Boolean( this.data );
		}
		
		public function set value( value:Boolean ):void
		{
			this.data = value;
		}
	}
}