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
			Assert.assertEquals( "ac", cdata.data );
			assertCharacterDataManipulation( cdata );
		}
		
		[Test]
		public function testCreateComment():void
		{
			var doc:Document = getXMLDocument();
			var comment:Comment = doc.createComment( "ac" );
			Assert.assertNotNull( comment );
			Assert.assertEquals( "ac", comment.data );
			assertCharacterDataManipulation( comment );			
		}
		
		[Test]
		public function testCreateText():void
		{
			var doc:Document = getXMLDocument();
			var txt:Text = doc.createTextNode( "ac" );
			Assert.assertNotNull( txt );
			Assert.assertEquals( "ac", txt.data );
			assertCharacterDataManipulation( txt );
		}
		
		private function assertCharacterDataManipulation(
			charData:CharacterData ):void
		{
			//TODO
		}
	}
}