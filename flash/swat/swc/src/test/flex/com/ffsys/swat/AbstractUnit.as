package com.ffsys.swat
{
	import flash.events.Event;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.Locale;
	import com.ffsys.utils.collections.strings.LocaleAwareStringCollection;
	
	import com.ffsys.swat.configuration.IConfiguration;
	import com.ffsys.swat.configuration.ConfigurationLoader;
	import com.ffsys.swat.events.ConfigurationEvent;
	
	/**
	*	Abstract super class for unit tests.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class AbstractUnit extends Object
	{
		public static const TIMEOUT:Number = 1000;
		
		public static const TEST_XML_PATH:String =
			"mock-configuration.xml";
		
		private var _configurationLoader:ConfigurationLoader;		
		private var _configuration:IConfiguration;
		/**
		* 	Creates an <code>AbstractUnit</code> instance.
		*/
		public function AbstractUnit()
		{
			super();
		}
		
		[Before( async )]
     	public function setUp():void
		{
			_configurationLoader = new ConfigurationLoader();
			_configurationLoader.addEventListener(
				LoadEvent.DATA,
				Async.asyncHandler( this, assertLoadedConfiguration, TIMEOUT, null, fail ) );

			_configurationLoader.load( TEST_XML_PATH );						
		}		
		
		[After]
     	public function tearDown():void
		{
			_configurationLoader = null;
			_configuration = null;
		}
		
		private function assertLoadedConfiguration(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			var configuration:IConfiguration = _configurationLoader.configuration;

			var locale:ILocale = new Locale();
			locale.lang = "en";
			locale.country = "GB";
			
			configuration.copy.locale = locale;
			
			Assert.assertNotNull( configuration );
			Assert.assertNotNull( configuration.locales );
			Assert.assertNotNull( configuration.copy );
			Assert.assertNotNull( configuration.settings );
			Assert.assertNotNull( configuration.assets );
			
			_configuration = configuration;
		}
		
		protected function fail( event:Event ):void
		{
			throw new Error( "An asynchronous test case failed." );
		}
		
		public function get configuration():IConfiguration
		{
			return _configuration;
		}
	}
}