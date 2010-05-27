package com.ffsys.utils.locale
{
	import org.flexunit.Assert;
	
	import com.ffsys.utils.locale.*;

	/**
	*	Unit tests for the locale package.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.05.2010
	*/
	public class LocaleTest
	{
		
		/**
		*	Creates a <code>LocaleTest</code> instance.
		*/ 
		public function LocaleTest()
		{
			super();
		}
		
		/**
		*	Tests the <code>LocaleCollection</code> methods.
		*/
		[Test]
		public function testLocaleCollection():void
		{
			var en:ILocale = new Locale( "en", "GB" );
			Assert.assertEquals( "en", en.lang );
			Assert.assertEquals( "GB", en.country );
			
			var collection:LocaleCollection = new LocaleCollection();
			collection.addLocale( en );
			
			Assert.assertEquals( 1, collection.length );
		}
	}
}