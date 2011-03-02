package com.ffsys.w3c.dom.css
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.w3c.dom.DOMFeature;
	import org.w3c.dom.DOMVersion;	
	import org.w3c.dom.Node;
	
	import org.w3c.dom.Document;
	
	import org.w3c.dom.css.CSSStyleSheet;
	import org.w3c.dom.css.CSSRule;
	import org.w3c.dom.css.DocumentCSS;
	import org.w3c.dom.css.RuleType;
	import org.w3c.dom.css.DOMImplementationCSS;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	
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
			var doc:CSSStyleSheetImpl = CSSStyleSheetImpl( sheet );
				
			var rule:CSSRule = null;
			
			//TODO: use insertRule() not appendChild() !!!!!!
			
			rule = doc.createCharsetRule( "utf-8" );
			Assert.assertTrue( rule is CSSCharsetRuleImpl );
			Assert.assertEquals( "utf-8", CSSCharsetRuleImpl( rule ).encoding );
			doc.appendChild( Node( rule ) );
						
			rule = doc.createImportRule( "assets/css/shared.css", "print, screen" );
			Assert.assertTrue( rule is CSSImportRuleImpl );
			Assert.assertEquals( "assets/css/shared.css", CSSImportRuleImpl( rule ).href );
			doc.appendChild( Node( rule ) );
			
			//null and the empty string become the "all" media type
			rule = doc.createMediaRule( null );
			Assert.assertEquals( "all", CSSMediaRuleImpl( rule ).media.mediaText );
			rule = doc.createMediaRule( "" );
			Assert.assertEquals( "all", CSSMediaRuleImpl( rule ).media.mediaText );
						
			rule = doc.createMediaRule( "print, screen, speech" );
			Assert.assertTrue( rule is CSSMediaRuleImpl );
			//TODO: assert on media list data
			doc.appendChild( Node( rule ) );
						
			rule = doc.createFontFaceRule();
			Assert.assertTrue( rule is CSSFontFaceRuleImpl );
			//TODO: assert on font face style declaration
			doc.appendChild( Node( rule ) );
						
			rule = doc.createPageRule();
			Assert.assertTrue( rule is CSSPageRuleImpl );
			doc.appendChild( Node( rule ) );
			
			rule = doc.createStyleRule();
			Assert.assertTrue( rule is CSSStyleRuleImpl );
			doc.appendChild( Node( rule ) );
			
			rule = doc.createUnknownRule();
			Assert.assertTrue( rule is CSSUnknownRuleImpl );
			doc.appendChild( Node( rule ) );
			
			//trace("[CSS RULE] DomCssCreationTest::testCreateStyleSheetsImplementation()", rule );
			
			trace("[CSS XML] DomCssCreationTest::assertOnStyleSheetImplementation()",
				doc.xml.toXMLString() );
			
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