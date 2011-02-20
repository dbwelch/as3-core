package java.nio.charset
{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;	
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import java.util.*;
	
	/**
	* 	
	*/
	public class CharsetConversionTest extends Object
	{
	
		public function CharsetConversionTest()
		{
			super();
		}
		
		[Test]
		public function testCharacterSetConversion():void
		{
			var charsets:SortedMap = Charset.availableCharsets;

			trace("CharsetConversionTest::testCharacterSetConversion()",
				charsets );
				
			var it:Iterator = charsets.iterator();
			
			while( it.hasNext() )
			{
				trace("CharsetConversionTest::testCharacterSetConversion()", it.next() );
			}
		}
	}
}