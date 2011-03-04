package com.ffsys.utils.number {
	
	/**
	*	Utility methods for working with
	*	<code>Number</code> instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class NumberUtils extends Object {
		
		/**
		*	@private
		*/
		public function NumberUtils()
		{
			super();
		}
		
		/**
		*	Gets a zero padded <code>String</code>
		*	representation of a <code>Number</code>.
		*
		*	The <code>Number</code> will be zero padded
		*	with a single zero if the <code>Number</code>
		*	is less than ten.
		*	
		*	@param num The <code>Number</code> to zero pad.
		*
		*	@return A zero padded <code>String</code>
		*	representation of the <code>Number</code>.
		*/
		static public function zeroPad( num:Number ):String
		{
			var str:String = num.toString();
			
			if( ( num is int ) && ( num < 10 ) )
			{
				str = "0" + str;
			}
			
			return str;
		}
	}
}