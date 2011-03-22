package org.flashx.io.xml
{
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import org.flashx.io.loaders.events.LoadEvent;
	
	import org.flashx.io.loaders.types.ParserAwareXmlLoader;
	
	
	/**
	*	Abstract super class for unit tests.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.10.2010
	*/
	public class AbstractXmlLoadUnit extends Object
	{
		public static const TIMEOUT:Number = 1000;
		
		private var _xmlLoader:ParserAwareXmlLoader;
		/**
		* 	Creates an <code>AbstractXmlLoadUnit</code> instance.
		*/
		public function AbstractXmlLoadUnit()
		{
			super();
		}
		
		[Before( async )]
     	public function setUp():void
		{
			_xmlLoader = new ParserAwareXmlLoader();
			_xmlLoader.parser = getXmlParser();
			_xmlLoader.addEventListener(
				LoadEvent.DATA,
				Async.asyncHandler( this, assertLoadedDocument, TIMEOUT, null, fail ) );
			_xmlLoader.request = new URLRequest( getXmlLoadPath() );
			_xmlLoader.load();
		}
		
		/**
		*	Determines which parser to use when deserializing
		*	the loaded XML document.	
		*/
		protected function getXmlParser():IParser
		{
			throw new Error(
				"You must specify the XML parser to use in the concrete unit test." );			
		}
		
		/**
		*	Determines which XML document to load.	
		*/
		protected function getXmlLoadPath():String
		{
			throw new Error(
				"You must specify the XML document to load in the concrete unit test." );
		}	
		
		[After]
     	public function tearDown():void
		{
			_xmlLoader = null;
		}
		
		/**
		*	Override this method to perform assertions on the loaded
		*	data.	
		*/
		protected function assertLoadedDocument(
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