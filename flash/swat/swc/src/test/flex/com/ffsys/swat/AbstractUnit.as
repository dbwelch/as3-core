package com.ffsys.swat
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.utils.locale.ILocale;
	import com.ffsys.utils.locale.Locale;
	
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.core.*;	
	import com.ffsys.swat.events.*;
	
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
		
		private var _bootstrapLoader:BootstrapLoader;
		
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
			var flashvars:DefaultFlashVariables = new DefaultFlashVariables();
			flashvars.configuration = TEST_XML_PATH;
			flashvars.classPathConfiguration = new ClassPathConfiguration();
			var parser:IConfigurationParser = new ConfigurationParser();
			parser.classNodeNameMap.rootInstance =
				new Configuration();
			_bootstrapLoader = new BootstrapLoader(
				flashvars,
				parser );	
			_bootstrapLoader.addEventListener(
				ConfigurationEvent.CONFIGURATION_LOAD_COMPLETE,
				Async.asyncHandler( this, assertLoadedConfiguration, TIMEOUT, null, fail ) );
			
			//_bootstrapLoader.request = new URLRequest( TEST_XML_PATH );
			
			_bootstrapLoader.load();
		}
		
		[After]
     	public function tearDown():void
		{
			_bootstrapLoader = null;
		}
		
		/**
		*	Performs assertions once the configuration data has been
		*	loaded.
		*/
		protected function assertLoadedConfiguration(
			event:ConfigurationEvent,
			passThroughData:Object ):void
		{
			var configuration:IConfiguration = event.configuration;
			Assert.assertNotNull( configuration );
			var locale:ILocale = Locale.EN_GB;
			configuration.locales.lang = locale.getLanguage();
		}
		
		protected function fail( event:Event ):void
		{
			throw new Error( "An asynchronous test case failed." );
		}
	}
}