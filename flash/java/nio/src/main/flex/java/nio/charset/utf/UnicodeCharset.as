package java.nio.charset.utf
{
	import java.nio.*;	
	
	import java.nio.charset.Charset;
	import java.nio.charset.CharsetEncoder;
	import java.nio.charset.CodingErrorAction;
	import java.nio.charset.CoderResult;
	
	/**
	* 	Represents the <code>utf-16</code> character set.
	*/
	public class UnicodeCharset extends Charset
	{
		/**
		* 	Creates a <code>UnicodeCharset</code> instance.
		*/
		public function UnicodeCharset()
		{
			super( "unicode", "utf-16" );
		}
	}
}