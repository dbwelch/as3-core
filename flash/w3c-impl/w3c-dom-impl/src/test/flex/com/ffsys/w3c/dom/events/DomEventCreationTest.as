package com.ffsys.w3c.dom.events
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	
	import org.w3c.dom.*;
	import org.w3c.dom.events.DocumentEvent;
	import org.w3c.dom.events.DOMEvent;
	import org.w3c.dom.events.UIEvent;
	
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
		
		/**
		* 	@private
		*/
		protected function getDocumentEvent():DocumentEvent
		{
			var doc:Document = getDocument();
			
			var docEvents:DocumentEvent =
				DocumentEvent( doc.implementation.getFeature(
					DOMFeature.EVENTS_MODULE, DOMFeature.LEVEL_3 ) );
			Assert.assertNotNull( docEvents );
			Assert.assertTrue( docEvents is DocumentEventImpl );
			
			return docEvents;			
		}
		
		[Test]
		public function testCreateUIEvent():void
		{
			var docEvents:DocumentEvent = getDocumentEvent();
			
			//create a DOM event
			var evt:UIEvent = UIEvent( docEvents.createEvent(
				DocumentEventImpl.UI_EVENT_INTERFACE ) );
			Assert.assertNotNull( evt );
			
			evt.initUIEvent(
				UIEventImpl.RESIZE, false, false, null, -1 );
				
			Assert.assertEquals( UIEventImpl.RESIZE, evt.type );
			Assert.assertFalse( evt.bubbles );
			Assert.assertFalse( evt.cancelable );
			Assert.assertNull( evt.view );
			Assert.assertEquals( -1, evt.detail );
			
			trace("[DOCUMENT UI EVENTS IMPL] DomEventCreationTest::testCreateElement()",
				evt, evt.type, evt.bubbles, evt.cancelable );
		}
		
		[Test]
		public function testCreateDOMEvent():void
		{
			var docEvents:DocumentEvent = getDocumentEvent();
			
			//create a DOM event
			var evt:DOMEvent = docEvents.createEvent(
				DocumentEventImpl.EVENT_INTERFACE );
			Assert.assertNotNull( evt );
			
			//check defaults before initialization
			Assert.assertNull( evt.type );
			Assert.assertFalse( evt.bubbles );
			Assert.assertFalse( evt.cancelable );			
			
			evt.initEvent(
				EventImpl.ERROR, true, true );
			
			//after initialization	
			Assert.assertEquals( EventImpl.ERROR, evt.type );
			Assert.assertTrue( evt.bubbles );
			Assert.assertTrue( evt.cancelable );
		}
	}
}