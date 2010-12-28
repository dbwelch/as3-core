package com.ffsys.swat.configuration
{
	import flash.display.*;
	import flash.media.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.ioc.*;
	
	import com.ffsys.swat.AbstractUnit;
	
	import com.ffsys.io.loaders.core.*;	
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.loaders.resources.*;
	
	import com.ffsys.io.xml.*;	
	
	import com.ffsys.swat.events.*;
	import com.ffsys.swat.configuration.*;
	import com.ffsys.swat.configuration.locale.*;
	import com.ffsys.swat.configuration.rsls.*;
	import com.ffsys.swat.core.*;	
	import com.ffsys.swat.view.*;
	
	import com.ffsys.swat.mock.*;
	
	import com.ffsys.utils.properties.IProperties;
	
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