package com.ffsys.utils.byte {
	
	/**
	*	Describes the contract for instances
	*	that can format the output when calling
	*	the <code>dump</code> method with a 
	*	<code>ByteArray</code>.
	*	
	*	@see com.ffsys.utils.byte.ByteStringUtils
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.04.2008
	*/
	public interface IByteDumpFormatter {
		
		/**
		*	Formats an individual byte to a complex
		*	<code>String</code> representation.
		*	
		*	@param byte The unsigned integer representing the byte.
		*	@param char A String character represented by the byte.
		*	@param hex A hexadecimal representation of the byte.
		*	@param binary A binary representation of the byte.
		*	
		*	@return The formatted output.
		*/
		function format( byte:uint, char:String, hex:String, binary:String ):String
		
		
		/**
		*	The number of columns to display
		*	before breaking onto a new line.	
		*/
		function set columns( val:int ):void;
		function get columns():int;
	}
}
