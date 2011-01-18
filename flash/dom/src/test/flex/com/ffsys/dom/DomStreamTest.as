package com.ffsys.dom
{
	import flash.events.*;
	import flash.net.*;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.net.sax.*;
	
	import com.ffsys.dom.xhtml.*;	
	
	/**
	*	Unit tests for streaming DOM XML documents
	* 	using the load() method.
	*/
	dynamic public class DomStreamTest extends AbstractDomUnit
	{
		
		/**
		*	Creates a <code>DomStreamTest</code> instance.
		*/ 
		public function DomStreamTest()
		{
			super();
		}
		
		[Before( async )]
     	override public function setUp():void
		{
			super.setUp();
			
			var request:URLRequest = new URLRequest( 
				"mock-dom.html" );
				
			parser = impl.parser();
			parser.addEventListener(
				Event.COMPLETE,
				Async.asyncHandler( this, loaded, TIMEOUT, null, fail ) );
				
			parser.load( request );
		}			
		
		[Test( async )]
		public function saxParserStreamTest():void
		{
			//
		}
		
		override protected function loaded(
			event:Event = null, data:Object = null ):void
		{
			//get a reference to the DOM from the parser
			document = Document( parser.dom );
			
			//clear any DOM instances registered from previous
			//tests
			ActionscriptQuery.doms.splice(
				0, ActionscriptQuery.doms.length );

			//register the DOM manually until the event handling is improved
			$().onload( document );	
			
			performActionscriptQueryAssertions();
		}
	}
}