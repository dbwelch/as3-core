package com.ffsys.w3c.dom.range
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	
	import org.w3c.dom.*;
	import org.w3c.dom.range.DocumentRange;
	import org.w3c.dom.range.Range;

	import com.ffsys.w3c.dom.DOMFeature;
	
	/**
	*	Unit tests for creating a DOM range.
	*/ 
	public class DomRangeCreationTest extends AbstractDomUnit
	{
		
		/**
		*	Creates a <code>DomRangeCreationTest</code> instance.
		*/ 
		public function DomRangeCreationTest()
		{
			super();
		}
		
		/**
		* 	@private
		*/
		protected function getDocumentRange():DocumentRange
		{
			var doc:Document = getXMLDocument();
			
			var docRange:DocumentRange =
				DocumentRange( doc.implementation.getFeature(
					DOMFeature.RANGE_MODULE, DOMFeature.LEVEL_3 ) );
			Assert.assertNotNull( docRange );
			Assert.assertTrue( docRange is DocumentRangeImpl );
			return docRange;			
		}
		
		[Test]
		public function testCreateRange():void
		{
			var docRange:DocumentRange = getDocumentRange();
			var range:Range = docRange.createRange();
			Assert.assertNotNull( range );
			Assert.assertTrue( range is RangeImpl );
		}
	}
}