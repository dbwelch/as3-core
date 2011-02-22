package com.ffsys.w3c.dom.events
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	
	import org.w3c.dom.*;
	import org.w3c.dom.events.DocumentEvent;
	import org.w3c.dom.events.DOMEvent;
	
	import com.ffsys.w3c.dom.core.DOMFeature;
	
	/**
	*	Unit tests for creating DOM events.
	*/ 
	public class DomEventCreationTest extends AbstractDomUnit
	{
		
		/**
		*	Creates a <code>DomEventCreationTest</code> instance.
		*/ 
		public function DomEventCreationTest()
		{
			super();
		}
		
		[Test]
		public function testCreateElement():void
		{
			var doc:Document = getDocument();
			
			var docEvents:DocumentEvent =
				DocumentEvent( doc.implementation.getFeature(
					DOMFeature.EVENTS_MODULE, DOMFeature.LEVEL_3 ) );
			Assert.assertNotNull( docEvents );
			Assert.assertTrue( docEvents is DocumentEventImpl );
			
			//create a plain event
			var evt:DOMEvent = docEvents.createEvent(
				DocumentEventImpl.EVENT_INTERFACE );
			
			//docEvents.
				
			trace("[DOCUMENT EVENTS IMPL] DomEventCreationTest::testCreateElement()",
				docEvents, evt );
		}
	}
}