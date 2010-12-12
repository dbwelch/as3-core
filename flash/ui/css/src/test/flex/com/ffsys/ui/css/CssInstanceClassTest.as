package com.ffsys.ui.css
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	/**
	*	Unit tests for css instance classes.
	*/ 
	public class CssInstanceClassTest
	{	
		private var _instance:CssStyleAware;
		
		public var sample:String = 
			(<![CDATA[

			style-aware {
				instance-class: class( com.ffsys.ui.css.CssStyleAware );
				id: stylable-identifier;
				styles: stylable-test;
			}
			
			CssStyleAware {
				class-level-color: #ff66ff;
			}

			#stylable-identifier {
				identifier-level-color: #ff6600;
			}

			stylable-test {
				x: 20;
				y: 50;
				custom-color: #336699;
			}
				
			]]>).toString();
		
		/**
		*	Creates a <code>CssInstanceClassTest</code> instance.
		*/ 
		public function CssInstanceClassTest()
		{
			super();
		}
		
		[Test]
		public function cssInstanceClassTest():void
		{
			var styleManager:IStyleManager = new StyleManager();
			
			var stylesheet:ICssStyleSheet = new CssStyleSheet();
			stylesheet.parse( sample );
			
			styleManager.addStyleSheet( stylesheet );
			
			var style:Object = stylesheet.getStyle( "style-aware" );
			Assert.assertNotNull( style );
			Assert.assertTrue( style is CssStyleAware );
			
			var stylable:CssStyleAware = CssStyleAware( style );
			stylable.styleManager = styleManager;
			Assert.assertEquals( "stylable-identifier", stylable.id );
			Assert.assertEquals( "stylable-test", stylable.styles );
			
			//TODO: change this to UIImpersonator and addChild()
			stylable.applyStyles();
			
			Assert.assertEquals( 20, stylable.x );
			Assert.assertEquals( 50, stylable.y );
			Assert.assertEquals( 16738047, stylable.classLevelColor );
			Assert.assertEquals( 16737792, stylable.identifierLevelColor );
			Assert.assertEquals( 3368601, stylable.customColor );
			
			//test instance method level references
			//TODO: re-implement
			/*
 			instance-method-reference {
				instance-class: class( com.ffsys.ui.css.CssStyleAware );
				method: method( doSomethingSpecial );
			}
			var instanceMethod:Object = stylesheet.getStyle( "instance-method-reference" );
			Assert.assertNotNull( instanceMethod );
			Assert.assertTrue( instanceMethod is Function );
			*/
		}
	}
}