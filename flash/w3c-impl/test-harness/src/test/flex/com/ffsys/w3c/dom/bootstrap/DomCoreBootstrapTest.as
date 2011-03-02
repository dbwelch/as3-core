package com.ffsys.w3c.dom.bootstrap
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	import org.w3c.dom.DOMFeature;
	
	import org.w3c.dom.Document;
	import org.w3c.dom.DOMImplementation;	
	import org.w3c.dom.DOMImplementationSource;
	import org.w3c.dom.css.DOMImplementationCSS;
	
	/**
	*	Unit tests for bootstrap and feature tests
	* 	on a DOM Core implementation.
	*/ 
	public class DomCoreBootstrapTest extends AbstractDomUnit
	{
		/**
		*	Creates a <code>DomCoreBootstrapTest</code> instance.
		*/ 
		public function DomCoreBootstrapTest()
		{
			super();
		}
		
		[Test]
		public function testCreateCoreImplementation():void
		{
			//unit tests must call this when testing implementation
			//sources to ensure any internally cached implementions
			//are cleared, if this were not done we can potentially
			//retrieve implementations for "unsupported" features cached
			//by a previous unit test
			DOMBootstrap.clearCachedImplementations();
			
			var source:DOMImplementationSource = new DOMCoreBootstrap();
			var impls:Vector.<DOMImplementationSource> = 
				new Vector.<DOMImplementationSource>();
			impls.push( source );
			
			var registry:DOMImplementationRegistry = getRegistry( impls );
			var impl:DOMImplementation = source.getDOMImplementation( "Core" );

			Assert.assertNotNull( impl );
			Assert.assertNotNull( source.getDOMImplementation( "Core 3.0" ) );
			Assert.assertEquals( impl, source.getDOMImplementation( "Core 3.0" ) );
			
			Assert.assertNotNull( source.getDOMImplementation( "ElementTraversal" ) );
			Assert.assertNotNull( source.getDOMImplementation( "ElementTraversal 3.0" ) );
			Assert.assertEquals( impl, source.getDOMImplementation( "ElementTraversal" ) );
			Assert.assertEquals( impl, source.getDOMImplementation( "ElementTraversal 3.0" ) );			
			
			Assert.assertNotNull( source.getDOMImplementation( "Traversal" ) );
			Assert.assertNotNull( source.getDOMImplementation( "Traversal 2.0" ) );
			Assert.assertEquals( impl, source.getDOMImplementation( "Traversal" ) );
			Assert.assertEquals( impl, source.getDOMImplementation( "Traversal 2.0" ) );
			
			Assert.assertNotNull( source.getDOMImplementation( "Range" ) );
			Assert.assertNotNull( source.getDOMImplementation( "Range 2.0" ) );
			Assert.assertEquals( impl, source.getDOMImplementation( "Range" ) );
			Assert.assertEquals( impl, source.getDOMImplementation( "Range 2.0" ) );
			
			//no 4.0 level yet
			Assert.assertNull( source.getDOMImplementation( "Core 4.0" ) );
			
			//no intermediary version either
			Assert.assertNull( source.getDOMImplementation( "Core 2.5" ) );
			
			//but we are backward compatible with older *valid* version numbers
			Assert.assertNotNull( source.getDOMImplementation( "Core 2.0" ) );
			Assert.assertNotNull( source.getDOMImplementation( "Core 1.0" ) );
			
			//this implementation source does not support the "Events" feature
			Assert.assertNull( source.getDOMImplementation( "Events" ) );
			
			//nope, don't have this non-existent feature either 
			Assert.assertNull( source.getDOMImplementation( "NonExistentFeature" ) );
		}
	}
}