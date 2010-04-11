package com.ffsys.utils.string {
	
	/**
	*	Lightweight helper class for formatting
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
	public class StringFormatter extends StringHelper {
		
		/**
		*	Creates a <code>StringFormatter</code>
		*	instance.
		*	
		*	@param source The source
		*	<code>String</code> instance.
		*/		
		public function StringFormatter(
			source:String = "" )
		{
			super( source );
		}
		
		/**
		*	Converts the first character of a
		*	<code>String</code> to lower case.
		*
		*	@param input The <code>String</code> to convert.
		*	
		*	@return A <code>String</code> with the first character
		*	converted to lower case.
		*/
		public function firstCharToLowerCase(
			input:String = null ):String
		{
			if( input == null )
			{
				input = source;
			}
			
			return input.charAt( 0 ).toLowerCase() +
				input.substr( 1 );
		}
		
		/**
		*	Converts the first character of a
		*	<code>String</code> to upper case.
		*
		*	@param input The <code>String</code> to convert.
		*	
		*	@return A <code>String</code> with the first character
		*	converted to upper case.
		*/
		public function firstCharToUpperCase(
			input:String = null ):String
		{
			if( input == null )
			{
				input = source;
			}			
			
			return input.charAt( 0 ).toUpperCase() +
				input.substr( 1 );
		}		
		
		/**
		*	@private
		*/
		private function toTitleCaseCallback(
			item:*,
			index:int,
			array:Array ):void
		{
			array[ index ] = firstCharToUpperCase( item as String );
		}
		
		/**
		*	Converts an <code>input</code> to title case.
		*	
		*	Splits all the words in <code>input</code> into
		*	an <code>Array</code> and converts the first
		*	character of each of the resulting words to
		*	upper case.
		*	
		*	@param input The <code>String</code> to convert.
		*	
		*	@return A title case representation of <code>input</code>.
		*/
		public function toTitleCase(
			input:String = null ):String
		{
			if( input == null )
			{
				input = source;
			}
						
			var sourceWords:Array = words( input );
			sourceWords.forEach( toTitleCaseCallback );
			return sourceWords.join( StringConstants.SPACE );
		}		
	}
}