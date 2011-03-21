package org.flashx.utils.string {
	
	/**
	*	Lightweight helper class for removing
	*	whitespace from <code>String</code> instances.
	*	
	*	@see com.ffsys.utils.string.StringHelper
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.02.2008
	*/
	public class StringTrim extends StringHelper {
		
		/**
		*	Creates a <code>StringTrim</code>
		*	instance.
		*	
		*	@param source The source
		*	<code>String</code> instance.
		*/
		public function StringTrim(
			source:String = "" )
		{
			super( source );
		}
		
		/**
		*	Trims all leading whitespace from the
		*	<code>source</code> and returns the
		*	trimmed <code>String</code>.
		*	
		*	@return A <code>String</code> with
		*	leading whitespace removed.
		*/
		public function ltrim( input:String = null ):String
		{
			
			if( input == null )
			{
				input = source;
			}
			
			if( input )
			{
				return input.replace( /^\s+/, "" );
			}
			
			return "";
		}
		
		/**
		*	Trims all trailing whitespace from the
		*	<code>source</code> and returns the
		*	trimmed <code>String</code>.
		*	
		*	@return A <code>String</code> with
		*	trailing whitespace removed.
		*/		
		public function rtrim( input:String = null ):String
		{
			if( input == null )
			{
				input = source;
			}
			
			if( input )
			{
				return input.replace( /\s+$/, "" );
			}
			
			return "";
		}
		
		/**
		*	Trims all leading and trailing
		*	whitespace from the <code>source</code>
		*	and returns the trimmed <code>String</code>.
		*	
		*	@return A <code>String</code> with
		*	leading and trailing whitespace removed.
		*/		
		public function trim( input:String = null ):String
		{
			if( input == null )
			{
				input = source;
			}			
			
			var output:String = input;
			output = ltrim( output );
			output = rtrim( output );
			return output;
		}
	}
}