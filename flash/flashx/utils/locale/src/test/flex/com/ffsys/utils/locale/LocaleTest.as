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
			Assert.assertTrue( collection.hasLocale( en ) );
			
			//can't add the same language
			var copy:ILocale = new Locale( "en", "GB" );
			collection.addLocale( copy );
			Assert.assertEquals( 1, collection.length );
			
			//can't add null values
			collection.addLocale( null );
			Assert.assertEquals( 1, collection.length );			
			
			Assert.assertEquals( en, collection.getLocaleByLanguage( "en" ) );
			Assert.assertEquals( en, collection.getLocaleByLanguageAndCountry( "en", "GB" ) );
			
			var es:ILocale = new Locale( "es", "ES" );
			
			Assert.assertTrue( en.equals( en ) );
			Assert.assertTrue( !en.equals( es ) );
			
			collection.addLocale( es );
			Assert.assertEquals( 2, collection.length );
			
			collection.removeLocale( es );
			Assert.assertEquals( 1, collection.length );
			
			collection.clear();
			Assert.assertEquals( 0, collection.length );
		}
	}
}