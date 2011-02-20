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
		static private var _encoder:CharsetEncoder;
		static private var _decoder:CharsetDecoder;
		
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
			if( _encoder == null )
			{
				//TODO: create a valid replacement byte array
				return new CharsetEncoder( this, 1, 1, null );
			}
			return _encoder;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function newDecoder():CharsetDecoder
		{
			if( _decoder == null )
			{
				//TODO: create a valid replacement byte array
				return new CharsetDecoder( this, 1, 1 );
			}
			return _decoder;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function encode( buffer:CharBuffer ):ByteBuffer
		{
			//the length of a charbuffer is in characters and we need
			//the byte length, as we know we are working with 16-bit units
			//in the char buffer we can double the charbuffer length
			var output:ByteBuffer = ByteBuffer.allocate(
				buffer.capacity() * CharsetEncoder.BYTES_PER_CHARACTER );
			var encoder:CharsetEncoder = newEncoder();
			encoder.onMalformedInput( CodingErrorAction.REPLACE );
			encoder.onUnmappableCharacter( CodingErrorAction.REPLACE );
			var result:CoderResult = encoder.encode( buffer, output, true );
			output.position( 0 );
			return output;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function decode( buffer:ByteBuffer ):CharBuffer
		{
			var output:CharBuffer = CharBuffer.allocate( 0 );
			_decoder = newDecoder();
			var pos:int = buffer.position();
			buffer.position( 0 );
			_decoder.decode( buffer, output, true );
			buffer.position( pos );
			_decoder = null;
			return output;
		}
	}
}