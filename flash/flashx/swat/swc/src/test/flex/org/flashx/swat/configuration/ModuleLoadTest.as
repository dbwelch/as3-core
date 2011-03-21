package org.flashx.swat.configuration
{
	import flash.display.*;
	import flash.media.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.flashx.ioc.*;
	
	import org.flashx.swat.AbstractUnit;
	
	import org.flashx.io.loaders.core.*;	
	import org.flashx.io.loaders.events.*;
	import org.flashx.io.loaders.resources.*;
	
	import org.flashx.io.xml.*;	
	
	import org.flashx.swat.events.*;
	import org.flashx.swat.configuration.*;
	import org.flashx.swat.configuration.locale.*;
	import org.flashx.swat.configuration.rsls.*;
	import org.flashx.swat.core.*;	
	import org.flashx.swat.view.*;
	
	import org.flashx.swat.mock.*;
	
	import org.flashx.utils.properties.IProperties;
	
	/**
	*	Unit tests for loading a module configuration
	* 	and associated resurces.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.12.2010
	*/
	public class ModuleLoadTest extends BootstrapLoadTest
	{
		/**
		* 	@private
		*/
		protected var _moduleLoader:IModuleLoader;
			
		/**
		* 	Creats a <code>ModuleLoadTest</code> instance.
		*/
		public function ModuleLoadTest()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function assertBootstrapData(
			event:RslEvent,
			passThroughData:Object ):void
		{
			super.assertBootstrapData( event, passThroughData );
			
			trace("ModuleLoadTest::assertBootstrapData() LOADING MODULE CONFIGURATION DATA: ", this );
			
			var parser:IParser = new ConfigurationParser( _framework );
			_moduleLoader = this.framework.getBean(
				DefaultBeanIdentifiers.MODULE_LOADER ) as IModuleLoader;
				
			_moduleLoader.request = new URLRequest( "mock-assets/common/xml/mock-module.xml" );
			_moduleLoader.parser = parser;
				
			//get debug statements
			_moduleLoader.addObserver( new DefaultApplicationPreloadView( false ) );
				
			_moduleLoader.addEventListener(
				RslEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertModuleData, TIMEOUT, null, fail ) );	
			_queue = _moduleLoader.load();
		}
		
		[After]
     	override public function tearDown():void
		{
			super.tearDown();
			_moduleLoader = null;
		}
		
		/**
		* 	@inheritDoc
		*/
		protected function assertModuleData(
			event:RslEvent,
			passThroughData:Object ):void
		{		
			trace( "ModuleLoadTest::assertModuleData()", this, _moduleLoader, _moduleLoader.resources );
		}
	}
}