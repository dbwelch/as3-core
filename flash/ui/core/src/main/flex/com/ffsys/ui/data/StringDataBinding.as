package com.ffsys.ui.data
{
	/**
	*	Concrete implementation for a data binding that encapsulates
	* 	a string.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.12.2010
	*/
	public class StringDataBinding extends DataBinding
	{
		/**
		* 	Creates a <code>StringDataBinding</code> instance.
		* 
		* 	@param value The string this data binding encapsulates.
		*/
		public function StringDataBinding( value:String = null )
		{
			super( value );
		}
		
		/**
		* 	The string string associated with this data binding.
		*/
		public function get value():String
		{
			return String( this.data );
		}
		
		public function set value( value:String ):void
		{
			this.data = value;
		}
	}
}