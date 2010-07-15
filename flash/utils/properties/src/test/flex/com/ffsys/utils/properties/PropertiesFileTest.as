package com.ffsys.utils.properties
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;	
	
	/**
	*	Unit tests for <code>com.ffsys.utils.properties</code>.
	*/ 
	public class PropertiesFileTest
	{
		/**
		*	The timeout for aysnchronous operations.	
		*/
		public static const TIMEOUT:Number = 1000;
		
		/**
		*	The path to the test properties file.	
		*/
		public static const TEST_PROPERTIES_PATH:String = "test.properties";
		
		/**
		*	@private	
		*/
		private var _file:PropertiesFile;
		
		/**
		*	Creates an <code>PropertiesFileTest</code> instance.
		*/ 
		public function PropertiesFileTest()
		{
			super();
		}
		
		[Test( async )]
		public function loadPropertiesFile():void
		{
			_file = new PropertiesFile();
			_file.addEventListener(
				PropertiesLoadEvent.LOADED, Async.asyncHandler(
					this, propertiesLoaded, TIMEOUT, null, fail ) );
			_file.load( new URLRequest( TEST_PROPERTIES_PATH ) );
		}
		
		/**
		*	@private	
		*/
		private function fail( event:Event ):void
		{
			throw new Error( "The properties file asynchronous test case failed to load." );
		}
		
		/**
		*	@private	
		*/
		private function propertiesLoaded(
			event:PropertiesLoadEvent, passThroughData:Object ):void
		{
			var properties:Properties = Properties( event.properties );
			
			Assert.assertEquals( "a test top level string", properties.toplevel );
			Assert.assertEquals( "abc", properties.group.a );
			Assert.assertEquals( "bcd", properties.group.b );
			
			Assert.assertEquals( "abcdef", properties.group.nested.a );
			Assert.assertEquals( "bcdefg", properties.group.nested.b );	
			
			Assert.assertTrue( properties.group is IProperties );
			Assert.assertTrue( properties.group.nested is IProperties );
			Assert.assertTrue(
				properties.getPropertiesById( "group" ) is IProperties );
			
			//
			Assert.assertEquals(
				"An error of type {0} occured", properties.group.err );
			
			//	
			Assert.assertEquals(
				"An error of type critical occured", properties.group.substitute(
					"err", [ "critical" ] ) );

			_file = null;
		}
	}
}