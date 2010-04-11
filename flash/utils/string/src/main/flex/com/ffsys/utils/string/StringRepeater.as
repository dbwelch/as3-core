package com.ffsys.utils.string {
	
	/**
	*	Lightweight helper class for repeating
	*	<code>String</code> instances.
	*	
	*	@see com.ffsys.utils.string.StringHelper
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.02.2008
	*/
	public class StringRepeater extends StringHelper {
		
		/**
		*	Creates a <code>StringRepeater</code>
		*	instance.
		*	
		*	@param source The source
		*	<code>String</code> instance.
		*/		
		public function StringRepeater(
			source:String = "" )
		{
			super( source );
		}
		
		/**
		*	Repeats a <code>String</code> the number
		*	of times specified by the <code>length</code>
		*	parameter.
		*	
		*	@param input The input <code>String</code> to repeat.
		*	@param length The number of times the <code>String</code>
		*	should be repeated.
		*	
		*	@return The repeated <code>String</code> value.
		*/
		public function repeat(
			input:String = null,
			length:int = 1 ):String
		{
			
			if( input == null )
			{
				input = source;
			}
			
			var output:String = "";
			var i:int = 0;

			for( ;i < length;i++ )
			{
				output += input;
			}
			
			return output;
		}		
	}
}