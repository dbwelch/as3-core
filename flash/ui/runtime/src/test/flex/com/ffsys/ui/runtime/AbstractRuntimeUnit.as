package com.ffsys.ui.runtime
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	import com.ffsys.ui.graphics.*;
	
	import com.ffsys.io.loaders.core.*;	
	import com.ffsys.io.loaders.events.*;
	import com.ffsys.io.xml.*;
	
	/**
	*	Abstract super class for unit tests.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.06.2010
	*/
	public class AbstractRuntimeUnit extends Object
	{	
		public static const TIMEOUT:Number = 60000;
		
		public static const TEST_XML_PATH:String =
			"mock-view.xml";
			
		private var _loader:IRuntimeLoader;
		
		/**
		* 	Creates an <code>AbstractRuntimeUnit</code> instance.
		*/
		public function AbstractRuntimeUnit()
		{
			super();
		}
		
		private function getLinkedClasses():Array
		{
			var output:Array = new Array();										
			return output;
		}
		
		[Before( async )]
     	public function setUp():void
		{
			_loader = Runtime.load(
				new URLRequest( TEST_XML_PATH ),
				null,
				{ items: [ "apples", "oranges", "pears" ] } );

			_loader.addEventListener(
				LoadEvent.LOAD_COMPLETE,
				Async.asyncHandler( this, assertLoadedView, TIMEOUT, null, fail ) );					
		}
		
		[After]
     	public function tearDown():void
		{
			_loader = null;
		}
		
		/**
		*	@private
		*/
		protected function loadStart(
			event:LoadEvent ):void
		{
			//trace("AbstractRuntimeUnit::loadStart()", event, event.type, event.uri );
		}
		
		/**
		*	@private
		*/
		protected function loadProgress(
			event:LoadEvent ):void
		{
			//trace("AbstractRuntimeUnit::loadProgress()", event, event.type, event.uri );
		}
		
		/**
		*	@private
		*/
		protected function loaded(
			event:LoadEvent ):void
		{
			//trace("AbstractRuntimeUnit::loaded()", event, event.type, event.uri );
		}		
		
		/**
		*	@private
		*/
		protected function resourceNotFound(
			event:LoadEvent ):void
		{
			//trace("AbstractRuntimeUnit::resourceNotFound()", event, event.type, event.uri );
		}		
		
		/**
		*	Performs assertions once the configuration data has been
		*	loaded.
		*/
		protected function assertLoadedView(
			event:LoadEvent,
			passThroughData:Object ):void
		{
			//
		}		
		
		protected function fail( event:Event ):void
		{
			throw new Error( "An asynchronous test case failed." );
		}
	}
}