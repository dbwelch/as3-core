package com.ffsys.utils.string {
	
	/**
	*	Lightweight helper class for padding
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
	public class StringPad extends StringHelper {
		
		/**
		*	Creates a <code>StringPad</code>
		*	instance.
		*	
		*	@param source The source
		*	<code>String</code> instance.
		*/		
		public function StringPad(
			source:String = "" )
		{
			super( source );
		}
		
		public function padLines(
			input:String,
			padding:String,
			stripLeadingWhiteSpace:Boolean = false,
			stripTrailingWhiteSpace:Boolean = false ):String
		{
			
			var sanitized:String = input.replace( /\n$/, "" );
			
			var output:String = "";
			
			var arr:Array = lines( sanitized );
			
			var i:int = 0;
			var l:int = arr.length;
			
			if( l == 1 )
			{
				return padding + sanitized;
			}
			
			var trimmer:StringTrim = new StringTrim();
			
			var line:String;
			
			for( ;i < l;i++ )
			{
				line = arr[ i ];
				
				if( stripLeadingWhiteSpace )
				{
					line = trimmer.ltrim( line );
				}
				
				if( stripTrailingWhiteSpace )
				{
					line = trimmer.rtrim( line );
				}
				
				line = padding + line;
				
				if( i < ( l - 1 ) )
				{
					line += StringConstants.NEWLINE;
				}
				
				output += line;
			}
			
			return output;
		}
				
	}
}