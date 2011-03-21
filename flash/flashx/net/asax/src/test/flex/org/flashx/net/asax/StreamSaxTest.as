package org.flashx.net.asax
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;

	
	/**
	*	Unit tests for loading a stream and parsing
	* 	the stream as elements become available. 
	*/ 
	public class StreamSaxTest extends Object
	{
		public static const TIMEOUT:Number = 10000;
		
		/**
		*	Creates a <code>StreamSaxTest</code> instance.
		*/ 
		public function StreamSaxTest()
		{
			super();
		}
		
		[Before( async )]
     	public function setUp():void
		{
			//var parser:SaxParser = new SaxObjectParser();
			//var handler:SaxHandler = new SaxHandler();
			//parser.handlers.push( handler );
			//parser.parse( sample );
			
			var parser:SaxParser = new SaxParser();
			
			var request:URLRequest = new URLRequest( "mock-sax-stream.html" );
			
			parser.addEventListener(
				Event.COMPLETE,
				Async.asyncHandler( this, loaded, TIMEOUT, null, fail ) );			
			
			parser.load( request );			
		}
		
		[After]
     	public function tearDown():void
		{
			//
		}			
		
		[Test( async )]
		public function saxParserStreamTest():void
		{
			//
		}
		
		protected function loaded( event:Event, data:Object = null ):void
		{
			//trace("StreamSaxTest::loaded()", this );
		}
		
		protected function fail( event:Event ):void
		{
			throw new Error( "An asynchronous test case failed." );
		}
	}
}