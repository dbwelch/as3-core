package com.ffsys.w3c.dom.css
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	import com.ffsys.w3c.dom.DOMFeature;
	
	import org.w3c.dom.Document;
	import org.w3c.dom.css.DOMImplementationCSS;
	
	/**
	*	Unit tests for creating DOM CSS implementations.
	*/ 
	public class DomCssCreationTest extends AbstractDomUnit
	{
		/**
		*	Creates a <code>DomCssCreationTest</code> instance.
		*/ 
		public function DomCssCreationTest()
		{
			super();
		}
		
		/**
		* 	@private
		*/
		protected function getDOMImplementationCSS( name:String ):DOMImplementationCSS
		{
			var doc:Document = getHTMLDocument();
			var cssImpl:DOMImplementationCSS =
				DOMImplementationCSS( doc.implementation.getFeature(
					name, DOMFeature.LEVEL_3 ) );
			Assert.assertNotNull( cssImpl );
			Assert.assertTrue( cssImpl is DOMImplementationCSS );
			return cssImpl;
		}
		
		[Test]
		public function testCreateStyleSheetsImplementation():void
		{
			var cssImpl:DOMImplementationCSS = getDOMImplementationCSS(
				DOMFeature.STYLESHEETS_MODULE );
		}
		
		[Test]
		public function testCreateCSSImplementation():void
		{
			var cssImpl:DOMImplementationCSS = getDOMImplementationCSS(
				DOMFeature.CSS_MODULE );
		}
		
		[Test]
		public function testCreateCSS2Implementation():void
		{
			var cssImpl:DOMImplementationCSS = getDOMImplementationCSS(
				DOMFeature.CSS2_MODULE );
		}				
	}
}