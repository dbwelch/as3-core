package org.flashx.utils.string {
	
	import org.flashx.utils.regex.RegexUtils;
	
	/**
	*	Lightweight helper class for removing one
	*	or more occurences of a <code>String</code>
	*	from a <code>source</code>.
	*	
	*	@see com.ffsys.utils.string.StringHelper
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.02.2008
	*/
	public class StringStrip extends StringHelper {
		
		/**
		*	Creates a <code>StringStrip</code>
		*	instance.
		*	
		*	@param source The source
		*	<code>String</code> instance.
		*/
		public function StringStrip(
			source:String = "" )
		{
			super( source );
		}
		
		/**
		*	Removes one or more occurences of a
		*	substring from the beginning of an
		*	input <code>String</code>.
		*
		*	@param input The input <code>String</code> 
		*	to operate on.
		*	@param strip The substring to strip from
		*	the beginning of the <code>input</code>.
		*
		*	@return A <code>String</code> with any occurences
		*	of the <code>strip</code> removed from the
		*	beginning of <code>input</code>.
		*/
		public function lstrip(
			input:String = null,
			strip:String = "" ):String
		{
			
			if( input == null )
			{
				input = source;
			}
			
			var escaped:String = RegexUtils.escape( strip );
			var re:RegExp = new RegExp( "^(" + escaped + ")+" );
			return input.replace( re, "" );
		}
		
		/**
		*	Removes one or more occurences of a
		*	substring from the end of an input
		*	<code>String</code>.
		*
		*	@param source The source <code>String</code>
		*	to operate on.
		*	@param strip The substring to strip from
		*	the end of <code>input</code>.
		*
		*	@return A <code>String</code> with any occurences
		*	of <code>strip</code> removed from the end of
		*	<code>input</code>.
		*/
		public function rstrip(
			input:String = null,
			strip:String = "" ):String
		{
			
			if( input == null )
			{
				input = source;
			}
			
			var escaped:String = RegexUtils.escape( strip );
			var re:RegExp = new RegExp( "(" + escaped + ")+$" );
			return input.replace( re, "" );
		}
		
		/**
		*	Removes all leading and trailing occurences
		*	of a substring from an input <code>String</code>.
		*	
		*	@param source The source <code>String</code>
		*	to operate on.
		*	@param strip The substring to strip from
		*	the <code>input</code>.
		*
		*	@return A <code>String</code> with any occurences
		*	of <code>strip</code> removed from the beginning
		*	and end of <code>input</code>.
		*/
		public function strip(
			input:String = null,
			strip:String = "" ):String
		{
			
			if( input == null )
			{
				input = source;
			}
			
			var output:String = input;
			output = lstrip( output, strip );
			output = rstrip( output, strip );
			return output;
		}
	}
}