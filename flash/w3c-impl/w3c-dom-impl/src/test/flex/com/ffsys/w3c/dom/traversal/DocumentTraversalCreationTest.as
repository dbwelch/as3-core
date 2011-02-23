package com.ffsys.w3c.dom.traversal
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.traversal.DocumentTraversalImpl;	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	
	import org.w3c.dom.*;
	import org.w3c.dom.traversal.DocumentTraversal;
	
	/**
	*	Unit tests for creating DOM traversal iterators/walkers.
	*/ 
	public class DocumentTraversalCreationTest extends AbstractDomUnit
	{
		
		/**
		*	Creates a <code>DocumentTraversalCreationTest</code> instance.
		*/ 
		public function DocumentTraversalCreationTest()
		{
			super();
		}
		
		/**
		* 	@private
		*/
		protected function getDocumentTraversal():DocumentTraversal
		{
			var doc:Document = getDocument();
			
			var docTraversal:DocumentTraversal =
				DocumentTraversal( doc.implementation.getFeature(
					DOMFeature.TRAVERSAL_MODULE, DOMFeature.LEVEL_3 ) );
			Assert.assertNotNull( docTraversal );
			Assert.assertTrue( docTraversal is DocumentTraversalImpl );
			return docTraversal;
		}
		
		[Test]
		public function testCreateRange():void
		{
			var docTraversal:DocumentTraversal = getDocumentTraversal();
			
			/*
			var range:Range = docTraversal.createRange();
			Assert.assertNotNull( range );
			Assert.assertTrue( range is RangeImpl );
			*/
		}
	}
}