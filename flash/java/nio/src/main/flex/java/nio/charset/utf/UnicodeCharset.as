package java.nio.charset.utf
{
	import java.nio.*;	
	
	import java.nio.charset.Charset;
	import java.nio.charset.CharsetEncoder;
	import java.nio.charset.CodingErrorAction;
	import java.nio.charset.CoderResult;
	
	/**
	* 	Represents the <code>utf-16</code> character set.
	* 
	* 	This is the character set used natively by the virtual
	* 	machine and is declared to encapsulate the character set
	* 	name and aliases even though this character set cannot
	* 	be encoded.
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
		
		/**
		* 	Ensures that this character set is treated
		* 	as unencodable.
		* 
		* 	This is the character set used natively by
		* 	the virtual machine therefore there is no need
		* 	to ever encode or decode from this character set.
		* 	
		* 	@return false, this character set cannot be encoded.
		*/
		override public function canEncode():Boolean
		{
			return false;
		}
	}
}