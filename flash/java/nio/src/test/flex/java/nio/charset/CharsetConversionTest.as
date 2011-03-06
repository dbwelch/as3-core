package java.nio.charset
{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;	
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import java.lang.*;	
	import java.nio.*;
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
		public function testCharsets():void
		{
			var charsets:SortedMap = Charset.availableCharsets;	
			var it:Iterator = charsets.values().iterator();
			var value:* = null;
			while( it.hasNext() )
			{
				value = it.next();
				trace("CharsetConversionTest::charset ", value );
				Assert.assertTrue( value is Charset );
				Assert.assertNotNull( Charset( value ).name() );
			}
		}
		
		/**
		* 	@private
		*/
		protected function getCandidateString(
			charset:Charset = null ):String
		{
			if( charset == null )
			{
				charset = CharacterSets.UTF8;
			}
			return '<?xml version="1.0" charset="' + charset.name() + '" standalone="no" ?>\n<root></root>';
		}
		
		/**
		* 	@private
		*/
		protected function getCandidateCharBuffer( charset:Charset = null ):CharBuffer
		{
			return CharBuffer.wrap(
				getCandidateString( charset ) );
		}
		
		/**
		* 	@private
		*/
		protected function getEncodedCandidate( charset:Charset ):ByteBuffer
		{
			//an internal 16-bit code unit string
			var candidate:CharBuffer = getCandidateCharBuffer();
			//get the byte buffer representation
			var buffer:ByteBuffer =
				charset.encode( candidate );
			return buffer;
		}
		
		/**
		* 	@private
		*/
		protected function getDecodedCandidate( charset:Charset, buffer:ByteBuffer ):CharBuffer
		{
			//decode back to a charbuffer
			var decoded:CharBuffer = charset.decode( buffer );
			return decoded;
		}
		
		/**
		* 	@private
		*/
		protected function assertEncodedCandidate( buffer:ByteBuffer ):void
		{
			//assert on each byte in the byte buffer
			Assert.assertEquals( 0x3C, buffer.array().readByte() );
			Assert.assertEquals( 0x3F, buffer.array().readByte() );
			Assert.assertEquals( 0x78, buffer.array().readByte() );
			Assert.assertEquals( 0x6D, buffer.array().readByte() );
			Assert.assertEquals( 0x6C, buffer.array().readByte() );
			Assert.assertEquals( 0x20, buffer.array().readByte() );
			Assert.assertEquals( 0x76, buffer.array().readByte() );
			Assert.assertEquals( 0x65, buffer.array().readByte() );
			Assert.assertEquals( 0x72, buffer.array().readByte() );
			Assert.assertEquals( 0x73, buffer.array().readByte() );
			Assert.assertEquals( 0x69, buffer.array().readByte() );
			Assert.assertEquals( 0x6F, buffer.array().readByte() );
			Assert.assertEquals( 0x6E, buffer.array().readByte() );
			Assert.assertEquals( 0x3D, buffer.array().readByte() );
			Assert.assertEquals( 0x22, buffer.array().readByte() );
			Assert.assertEquals( 0x31, buffer.array().readByte() );
			Assert.assertEquals( 0x2E, buffer.array().readByte() );
			Assert.assertEquals( 0x30, buffer.array().readByte() );
			Assert.assertEquals( 0x22, buffer.array().readByte() );
			Assert.assertEquals( 0x20, buffer.array().readByte() );
			Assert.assertEquals( 0x63, buffer.array().readByte() );
			Assert.assertEquals( 0x68, buffer.array().readByte() );
			Assert.assertEquals( 0x61, buffer.array().readByte() );
			Assert.assertEquals( 0x72, buffer.array().readByte() );
			Assert.assertEquals( 0x73, buffer.array().readByte() );
			Assert.assertEquals( 0x65, buffer.array().readByte() );
			Assert.assertEquals( 0x74, buffer.array().readByte() );
			Assert.assertEquals( 0x3D, buffer.array().readByte() );
			Assert.assertEquals( 0x22, buffer.array().readByte() );
			Assert.assertEquals( 0x75, buffer.array().readByte() );
			Assert.assertEquals( 0x74, buffer.array().readByte() );
			Assert.assertEquals( 0x66, buffer.array().readByte() );
			Assert.assertEquals( 0x2D, buffer.array().readByte() );
			Assert.assertEquals( 0x38, buffer.array().readByte() );
			Assert.assertEquals( 0x22, buffer.array().readByte() );
			Assert.assertEquals( 0x20, buffer.array().readByte() );
			Assert.assertEquals( 0x73, buffer.array().readByte() );
			Assert.assertEquals( 0x74, buffer.array().readByte() );
			Assert.assertEquals( 0x61, buffer.array().readByte() );
			Assert.assertEquals( 0x6E, buffer.array().readByte() );
			Assert.assertEquals( 0x64, buffer.array().readByte() );
			Assert.assertEquals( 0x61, buffer.array().readByte() );
			Assert.assertEquals( 0x6C, buffer.array().readByte() );
			Assert.assertEquals( 0x6F, buffer.array().readByte() );
			Assert.assertEquals( 0x6E, buffer.array().readByte() );
			Assert.assertEquals( 0x65, buffer.array().readByte() );
			Assert.assertEquals( 0x3D, buffer.array().readByte() );
			Assert.assertEquals( 0x22, buffer.array().readByte() );
			Assert.assertEquals( 0x6E, buffer.array().readByte() );
			Assert.assertEquals( 0x6F, buffer.array().readByte() );
			Assert.assertEquals( 0x22, buffer.array().readByte() );
			Assert.assertEquals( 0x20, buffer.array().readByte() );
			Assert.assertEquals( 0x3F, buffer.array().readByte() );
			Assert.assertEquals( 0x3E, buffer.array().readByte() );
			Assert.assertEquals( 0x0A, buffer.array().readByte() );
			Assert.assertEquals( 0x3C, buffer.array().readByte() );
			Assert.assertEquals( 0x72, buffer.array().readByte() );
			Assert.assertEquals( 0x6F, buffer.array().readByte() );
			Assert.assertEquals( 0x6F, buffer.array().readByte() );
			Assert.assertEquals( 0x74, buffer.array().readByte() );
			Assert.assertEquals( 0x3E, buffer.array().readByte() );
			Assert.assertEquals( 0x3C, buffer.array().readByte() );
			Assert.assertEquals( 0x2F, buffer.array().readByte() );
			Assert.assertEquals( 0x72, buffer.array().readByte() );
			Assert.assertEquals( 0x6F, buffer.array().readByte() );
			Assert.assertEquals( 0x6F, buffer.array().readByte() );
			Assert.assertEquals( 0x74, buffer.array().readByte() );
			Assert.assertEquals( 0x3E, buffer.array().readByte() );			
		}
		
		/**
		* 	@private
		*/
		protected function assertDecodedCandidate( candidate:String ):void
		{
			//assert on each character
			Assert.assertEquals( "<",	candidate.charAt( 0 ) );
			Assert.assertEquals( "?", 	candidate.charAt( 1 ) );
			Assert.assertEquals( "x", 	candidate.charAt( 2 ) );
			Assert.assertEquals( "m", 	candidate.charAt( 3 ) );
			Assert.assertEquals( "l", 	candidate.charAt( 4 ) );
			Assert.assertEquals( " ", 	candidate.charAt( 5 ) );
			Assert.assertEquals( "v", 	candidate.charAt( 6 ) );
			Assert.assertEquals( "e", 	candidate.charAt( 7 ) );
			Assert.assertEquals( "r", 	candidate.charAt( 8 ) );
			Assert.assertEquals( "s", 	candidate.charAt( 9 ) );
			Assert.assertEquals( "i", 	candidate.charAt( 10 ) );
			Assert.assertEquals( "o", 	candidate.charAt( 11 ) );
			Assert.assertEquals( "n", 	candidate.charAt( 12 ) );
			Assert.assertEquals( "=", 	candidate.charAt( 13 ) );
			Assert.assertEquals( "\"", 	candidate.charAt( 14 ) );
			Assert.assertEquals( "1", 	candidate.charAt( 15 ) );
			Assert.assertEquals( ".", 	candidate.charAt( 16 ) );
			Assert.assertEquals( "0", 	candidate.charAt( 17 ) );
			Assert.assertEquals( "\"", 	candidate.charAt( 18 ) );
			Assert.assertEquals( " ", 	candidate.charAt( 19 ) );
			Assert.assertEquals( "c", 	candidate.charAt( 20 ) );
			Assert.assertEquals( "h", 	candidate.charAt( 21 ) );
			Assert.assertEquals( "a", 	candidate.charAt( 22 ) );
			Assert.assertEquals( "r", 	candidate.charAt( 23 ) );
			Assert.assertEquals( "s", 	candidate.charAt( 24 ) );
			Assert.assertEquals( "e", 	candidate.charAt( 25 ) );
			Assert.assertEquals( "t", 	candidate.charAt( 26 ) );
			Assert.assertEquals( "=", 	candidate.charAt( 27 ) );
			Assert.assertEquals( "\"", 	candidate.charAt( 28 ) );
			Assert.assertEquals( "u", 	candidate.charAt( 29 ) );
			Assert.assertEquals( "t", 	candidate.charAt( 30 ) );
			Assert.assertEquals( "f", 	candidate.charAt( 31 ) );
			Assert.assertEquals( "-", 	candidate.charAt( 32 ) );
			Assert.assertEquals( "8", 	candidate.charAt( 33 ) );
			Assert.assertEquals( "\"", 	candidate.charAt( 34 ) );
			Assert.assertEquals( " ", 	candidate.charAt( 35 ) );
			Assert.assertEquals( "s", 	candidate.charAt( 36 ) );
			Assert.assertEquals( "t", 	candidate.charAt( 37 ) );
			Assert.assertEquals( "a", 	candidate.charAt( 38 ) );
			Assert.assertEquals( "n", 	candidate.charAt( 39 ) );
			Assert.assertEquals( "d", 	candidate.charAt( 40 ) );
			Assert.assertEquals( "a", 	candidate.charAt( 41 ) );
			Assert.assertEquals( "l", 	candidate.charAt( 42 ) );
			Assert.assertEquals( "o", 	candidate.charAt( 43 ) );
			Assert.assertEquals( "n", 	candidate.charAt( 44 ) );
			Assert.assertEquals( "e", 	candidate.charAt( 45 ) );
			Assert.assertEquals( "=", 	candidate.charAt( 46 ) );
			Assert.assertEquals( "\"", 	candidate.charAt( 47 ) );
			Assert.assertEquals( "n", 	candidate.charAt( 48 ) );
			Assert.assertEquals( "o", 	candidate.charAt( 49 ) );
			Assert.assertEquals( "\"", 	candidate.charAt( 50 ) );
			Assert.assertEquals( " ", 	candidate.charAt( 51 ) );
			Assert.assertEquals( "?", 	candidate.charAt( 52 ) );
			Assert.assertEquals( ">", 	candidate.charAt( 53 ) );
			Assert.assertEquals( "\n", 	candidate.charAt( 54 ) );
			Assert.assertEquals( "<", 	candidate.charAt( 55 ) );
			Assert.assertEquals( "r", 	candidate.charAt( 56 ) );
			Assert.assertEquals( "o", 	candidate.charAt( 57 ) );
			Assert.assertEquals( "o", 	candidate.charAt( 58 ) );
			Assert.assertEquals( "t", 	candidate.charAt( 59 ) );
			Assert.assertEquals( ">", 	candidate.charAt( 60 ) );
			Assert.assertEquals( "<", 	candidate.charAt( 61 ) );
			Assert.assertEquals( "/", 	candidate.charAt( 62 ) );
			Assert.assertEquals( "r", 	candidate.charAt( 63 ) );
			Assert.assertEquals( "o", 	candidate.charAt( 64 ) );
			Assert.assertEquals( "o",	candidate.charAt( 65 ) );
			Assert.assertEquals( "t", 	candidate.charAt( 66 ) );
			Assert.assertEquals( ">", 	candidate.charAt( 67 ) );
		}
		
		[Test]
		public function testUTF8Conversion():void
		{
			var candidate:CharBuffer = getCandidateCharBuffer();
			
			//get the byte buffer representation
			var buffer:ByteBuffer = getEncodedCandidate(
				CharacterSets.UTF8 );
				
			//the char buffer should be twice the length of the byte buffer
			//as we are dealing with internal vm 16-bit per character strings
			Assert.assertEquals(
				candidate.capacity() * 2, buffer.capacity() );
				
			assertEncodedCandidate( buffer );
			
			//reset the position
			buffer.position( 0 );
			Assert.assertEquals( 0, buffer.position() );
			
			var decoded:CharBuffer = getDecodedCandidate(
				CharacterSets.UTF8, buffer );
			
			//convert the charbuffer to a string
			var chars:String = decoded.toString();
			
			//assert each character is correct
			assertDecodedCandidate( chars );
			
			//compare complete candidate and decoded strings
			Assert.assertEquals( candidate.toString(), chars );
		}
		
		[Test]
		public function testUTF8ConversionBOM():void
		{
			var candidate:CharBuffer = getCandidateCharBuffer();
			
			//get the byte buffer representation
			var buffer:ByteBuffer = getEncodedCandidate(
				CharacterSets.UTF8 );
				
			assertEncodedCandidate( buffer );
				
			//the char buffer should be twice the length of the byte buffer
			//as we are dealing with internal vm 16-bit per character strings
			Assert.assertEquals(
				candidate.capacity() * 2, buffer.capacity() );
				
			//the BOM should not match yet
			Assert.assertFalse( ByteOrderMark.UTF_8.test( buffer.array() ) );
			
			/*	
			trace("CharsetConversionTest::testUTF8ConversionBOM()",
				buffer.array().length,
				ByteOrderMark.UTF_8.bytes.length,
				ByteOrderMark.UTF_8.test( buffer.array() ) );
			*/
			
			//concatenate the BOM with the UTF8 encoded bytes
			var bomBytes:ByteArray =
				ByteOrderMark.UTF_8.concat( buffer.array() );
				
			//verify the BOM is present in the concatenated output
			Assert.assertTrue( ByteOrderMark.UTF_8.test( bomBytes ) );
			
			//simple test on byte lengths after concat()
			Assert.assertEquals(
				ByteOrderMark.UTF_8.bytes.length + buffer.array().length, bomBytes.length );
				
			//wrap the concatenated bytes back in a buffer
			var bom:ByteBuffer =
				ByteBuffer.wrap( bomBytes );
			
			//lengths of buffer and concatenated BOM bytes should be equal	
			Assert.assertEquals(
				bomBytes.length, bom.capacity() );
			
			/*	
			assertEncodedCandidate( buffer );
			
			//reset the position
			buffer.position( 0 );
			Assert.assertEquals( 0, buffer.position() );
			
			var decoded:CharBuffer = getDecodedCandidate(
				CharacterSets.UTF8, buffer );
			
			//convert the charbuffer to a string
			var chars:String = decoded.toString();
			
			//assert each character is correct
			assertDecodedCandidate( chars );
			
			//compare complete candidate and decoded strings
			Assert.assertEquals( candidate.toString(), chars );
			*/
		}		
		
		/*
		[Test]
		public function testISO_8859_1Conversion():void
		{
			var candidate:CharBuffer = getCandidateCharBuffer();
			
			//get the byte buffer representation
			var buffer:ByteBuffer = getEncodedCandidate(
				CharacterSets.ISO_8859_1 );
				
			//the char buffer should be twice the length of the byte buffer
			//as we are dealing with internal vm 16-bit per character strings
			Assert.assertEquals(
				candidate.capacity() * 2, buffer.capacity() );
				
			assertEncodedCandidate( buffer );
			
			//reset the position
			buffer.position( 0 );
			Assert.assertEquals( 0, buffer.position() );
			
			var decoded:CharBuffer = getDecodedCandidate(
				CharacterSets.ISO_8859_1, buffer );
			
			//convert the charbuffer to a string
			var chars:String = decoded.toString();
			
			//assert each character is correct
			assertDecodedCandidate( chars );
			
			//compare complete candidate and decoded strings
			Assert.assertEquals( candidate.toString(), chars );
		}	
		*/	
	}
}