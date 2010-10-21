package com.ffsys.utils.string
{
	
	/**
	*	Describes the contract for objects that perform
	* 	one way conversion of strings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.10.2010
	*/
	public interface IStringConverter
	{
		
		/**
		* 	Performs conversion on the input value.
		* 
		* 	The type of conversion performed is determined
		* 	by the concrete implementation.
		* 
		* 	@param value The input value.
		* 
		* 	@return The converted value.
		*/
		function convert( value:String ):String;
	}
}