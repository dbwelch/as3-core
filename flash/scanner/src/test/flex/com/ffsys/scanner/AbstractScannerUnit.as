package com.ffsys.scanner
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;	
	
	/**
	*	Abstract super class for DOM unit tests.
	*/
	public class AbstractScannerUnit extends Object
	{
		public static const TIMEOUT:Number = 10000;
		
		/**
		* 	@private
		*/
		protected var _time:Number;
		
		/**
		*	Creates a <code>AbstractScannerUnit</code> instance.
		*/ 
		public function AbstractScannerUnit()
		{
			super();
		}
		
		[Before( async )]
     	public function setUp():void
		{
			_time = new Date().getTime();
		}
		
		[After]
     	public function tearDown():void
		{
		}
		
		/**
		* 	@private
		*/
		protected function loaded(
			event:Event = null, data:Object = null ):void
		{
			//
		}
		
		/**
		* 	@private
		*/
		protected function fail( event:Event ):void
		{
			throw new Error( "An asynchronous test case failed." );
		}
	}
}