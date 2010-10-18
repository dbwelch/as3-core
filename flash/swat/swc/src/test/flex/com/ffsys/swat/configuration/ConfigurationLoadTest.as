package com.ffsys.swat.configuration
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.swat.AbstractUnit;
	
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.swat.configuration.IConfiguration;
	
	/**
	*	Unit tests for ensuring the configuration data can
	* 	be loaded and parsed.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class ConfigurationLoadTest extends AbstractUnit
	{
		
		/**
		* 	Creats a <code>ConfigurationLoadTest</code> instance.
		*/
		public function ConfigurationLoadTest()
		{
			super();
		}
		
		/**
		*	@inheritDoc	
		*/
		override protected function assertLoadedConfiguration(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			super.assertLoadedConfiguration( event, passThroughData );
			
			/*
			var configuration:IConfiguration = this.configuration;
			
			Assert.assertNotNull( configuration );
			Assert.assertNotNull( configuration.locales );
			Assert.assertNotNull( configuration.settings );
			Assert.assertNotNull( configuration.assets );
			*/			
		}
	
		[Test(async)]
		public function loadConfiguration():void
		{
			//
		}
	}
}