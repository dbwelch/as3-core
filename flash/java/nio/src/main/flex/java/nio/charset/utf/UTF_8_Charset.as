package java.nio.charset.utf
{
	import java.nio.*;	
	
	import java.nio.charset.Charset;
	import java.nio.charset.CharsetEncoder;
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
			super( "utf-8", "unicode-1-1-utf-8", "unicode-2-0-utf-8", "x-unicode-2-0-utf-8" );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function newEncoder():CharsetEncoder
		{
			//TODO: create a valid replacement byte array
			return new CharsetEncoder( this, 1, 1, null );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function encode( buffer:CharBuffer ):ByteBuffer
		{
			//the length of a charbuffer is in characters and we need
			//the byte length, as we know we are working with 16-bit units
			//in the char buffer we can double the charbuffer length
			var output:ByteBuffer = ByteBuffer.allocate( buffer.length() * 2 );
			var encoder:CharsetEncoder = newEncoder();
			encoder.onMalformedInput( CodingErrorAction.REPLACE );
			encoder.onUnmappableCharacter( CodingErrorAction.REPLACE );
			var result:CoderResult = encoder.encode( buffer, output, true );
			
			//flush to the output buffer?
			//encoder.flush();
			
			return output;
		}
	}
}