package com.ffsys.w3c.dom.traversal
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.DOMVersion;
	
	import org.w3c.dom.*;
	import org.w3c.dom.traversal.*;
	
	/**
	*	Unit tests for instantiating DOM traversal iterators/walkers.
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
			var doc:Document = getXMLDocument();
			
			var docTraversal:DocumentTraversal =
				DocumentTraversal( doc.implementation.getFeature(
					DOMFeature.TRAVERSAL_MODULE, null ) );
			Assert.assertNotNull( docTraversal );
			Assert.assertTrue( docTraversal is DocumentTraversal );
			return docTraversal;
		}
		
		[Test]
		public function testCreateIterator():void
		{
			//first check by extracting an implementation for the "Traversal 3.0" feature
			var docTraversal:DocumentTraversal = getDocumentTraversal();
			var iterator:NodeIterator = docTraversal.createNodeIterator(
				null, 0, null, false );			
				
			Assert.assertNotNull( iterator );
			
			//we should also be able to operate on the XML document
			//implementation
			var doc:Document = getXMLDocument();
			iterator = DocumentTraversal( doc ).createNodeIterator(
				null, 0, null, false );
				
			Assert.assertNotNull( iterator );
			
			//and an HTML document implementation
			doc = getHTMLDocument();
			iterator = DocumentTraversal( doc ).createNodeIterator(
				null, 0, null, false );
				
			Assert.assertNotNull( iterator );
		}
	}
}