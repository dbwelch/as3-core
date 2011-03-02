package com.ffsys.w3c.dom.css
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.w3c.dom.DOMFeature;
	import org.w3c.dom.DOMVersion;	
	
	import org.w3c.dom.Document;
	
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.DocumentCSS;
	import org.w3c.dom.css.RuleType;
	import org.w3c.dom.css.DOMImplementationCSS;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	
	import com.ffsys.w3c.dom.css.CSSStyleSheetImpl;
	
	
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
				DOMImplementationCSS( doc.implementation.getFeature( name, null ) );
			Assert.assertNotNull( cssImpl );
			Assert.assertTrue( cssImpl is DOMImplementationCSS );
			return cssImpl;
		}
		
		/**
		* 	@private
		*/
		protected function assertOnStyleSheetImplementation( impl:DOMImplementationCSS ):CSSStyleSheet
		{
			var doc:CSSStyleSheet = impl.createCSSStyleSheet(
				"A style sheet", "screen, print" );
				
			Assert.assertTrue( doc is DocumentCSS );
			var docCss:DocumentCSS = doc as DocumentCSS; 

			//the document should be the first style sheet
			//in the list by default
			Assert.assertEquals( doc, Object( docCss.styleSheets )[ 0 ] );
			
			/*
			trace("[CSS DOC] DomCssCreationTest::testCreateStyleSheetsImplementation()",
				impl, doc,
				docCss.styleSheets, docCss.styleSheets.length );	
			*/
				
			Assert.assertTrue( docCss is CSSStyleSheetImpl );
			
			return docCss as CSSStyleSheet;
		}
		
		[Test]
		public function testCreateStyleSheetsImplementation():void
		{
			var cssImpl:DOMImplementationCSS = getDOMImplementationCSS(
				DOMFeature.STYLESHEETS_MODULE );
			
			var sheet:CSSStyleSheet = assertOnStyleSheetImplementation( cssImpl );
			var rule:CSSRule = CSSStyleSheetImpl( sheet ).createCSSRule( RuleType.UNKNOWN_RULE );
			
			
			//TODO
			
			//trace("[CSS RULE] DomCssCreationTest::testCreateStyleSheetsImplementation()", rule );
		}
		
		[Test]
		public function testCreateCSSImplementation():void
		{
			var cssImpl:DOMImplementationCSS = getDOMImplementationCSS(
				DOMFeature.CSS_MODULE );
			var sheet:CSSStyleSheet = assertOnStyleSheetImplementation( cssImpl );
		}
		
		[Test]
		public function testCreateCSS2Implementation():void
		{
			var cssImpl:DOMImplementationCSS = getDOMImplementationCSS(
				DOMFeature.CSS2_MODULE );
			var sheet:CSSStyleSheet = assertOnStyleSheetImplementation( cssImpl );		
		}				
	}
}