package java.nio.charset.utf
{
	import java.nio.*;	
	
	import java.nio.charset.Charset;
	import java.nio.charset.CharsetEncoder;
	import java.nio.charset.CharsetDecoder;
	import java.nio.charset.CodingErrorAction;
	import java.nio.charset.CoderResult;
	
	/**
	* 	Represents the <code>utf-8</code> character set.
	*/
	public class UTF_8_Charset extends Charset
	{		
		/**
		* 	Creates a <code>UTF_8_Charset</code> instance.
		*/
		public function UTF_8_Charset()
		{
			super(
				"utf-8",
				"unicode-1-1-utf-8",
				"unicode-2-0-utf-8",
				"x-unicode-2-0-utf-8" );
		}
	}
}