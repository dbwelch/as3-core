package com.ffsys.w3c.dom
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import org.w3c.dom.CDATASection;
	import org.w3c.dom.CharacterData;
	import org.w3c.dom.Comment;
	import org.w3c.dom.Document;
	import org.w3c.dom.Text;
	
	/**
	*	Unit tests for operating on the implementations
	* 	derived from the CharacterData interface.
	*/ 
	public class DomCharacterDataTest extends AbstractDomUnit
	{
		/**
		*	Creates a <code>DomCharacterDataTest</code> instance.
		*/ 
		public function DomCharacterDataTest()
		{
			super();
		}
		
		[Test]
		public function testCreateCDATASection():void
		{
			var doc:Document = getXMLDocument();
			var cdata:CDATASection = doc.createCDATASection( "ac" );
			Assert.assertNotNull( cdata );
			assertCharacterDataManipulation( cdata );
		}
		
		[Test]
		public function testCreateComment():void
		{
			var doc:Document = getXMLDocument();
			var comment:Comment = doc.createComment( "ac" );
			Assert.assertNotNull( comment );
			assertCharacterDataManipulation( comment );			
		}
		
		[Test]
		public function testCreateText():void
		{
			var doc:Document = getXMLDocument();
			var txt:Text = doc.createTextNode( "ac" );
			Assert.assertNotNull( txt );
			assertCharacterDataManipulation( txt );
		}
		
		private function assertCharacterDataManipulation(
			charData:CharacterData ):void
		{
			Assert.assertEquals( "ac", charData.data );
			
			//insert a "b"
			charData.insertData( 1, "b" );
			Assert.assertEquals( 3, charData.length );
			
			//delete the "c"
			charData.deleteData( 2, 1 );
			Assert.assertEquals( 2, charData.length );
			
			//append the "c" back on
			charData.appendData( "c" );
			Assert.assertEquals( 3, charData.length );
			
			//replace "ab" with "i"
			charData.replaceData( 0, 2, "i" );
			Assert.assertEquals( 2, charData.length );

			//now should be "icu"
			charData.appendData( "u" );
			Assert.assertEquals( 3, charData.length );
			Assert.assertEquals( "icu", charData.data );
			
			//iterate over each character
			var c:uint = 0;
			var char:String = null;
			for( char in charData )
			{
				Assert.assertEquals(
					charData.substringData( c, 1 ), char );
				c++;
			}
			
			Assert.assertEquals( c, charData.length );
			
			//iterate over the 16-bit unicode code points
			c = 0;
			var code:uint = NaN;
			for each( code in charData )
			{
				Assert.assertEquals(
					charData.substringData( c, 1 ), String.fromCharCode( code ) );
				c++;
			}
			
			Assert.assertEquals( c, charData.length );
		}
	}
}