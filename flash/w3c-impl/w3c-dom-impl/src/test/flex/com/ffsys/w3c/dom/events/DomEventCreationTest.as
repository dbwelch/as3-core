package com.ffsys.w3c.dom.events
{
	import org.flexunit.Assert;
	import org.flexunit.async.Async;
	
	import com.ffsys.w3c.dom.AbstractDomUnit;
	
	import org.w3c.dom.*;
	import org.w3c.dom.events.DocumentEvent;
	import org.w3c.dom.events.DOMEvent;
	import org.w3c.dom.events.FocusEvent;
	import org.w3c.dom.events.MutationEvent;
	import org.w3c.dom.events.UIEvent;
	
	import com.ffsys.w3c.dom.DOMFeature;
	import com.ffsys.w3c.dom.DOMVersion;
	import com.ffsys.w3c.dom.html.HTMLDocumentImpl;
	
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
			var doc:Document = getHTMLDocument();
			
			trace("DomEventCreationTest::getDocumentEvent()", HTMLDocumentImpl( doc ).xml.toXMLString() );
			
			var docEvents:DocumentEvent =
				DocumentEvent( doc.implementation.getFeature(
					DOMFeature.EVENTS_MODULE, DOMVersion.LEVEL_3 ) );
			Assert.assertNotNull( docEvents );
			Assert.assertTrue( docEvents is DocumentEventImpl );
			
			return docEvents;			
		}
		
		[Test]
		public function testCreateMutationEvent():void
		{
			var docEvents:DocumentEvent = getDocumentEvent();
			
			//create a DOM event
			var evt:MutationEvent = MutationEvent( docEvents.createEvent(
				DocumentEventImpl.MUTATION_EVENT_INTERFACE ) );
			Assert.assertNotNull( evt );
			
			evt.initMutationEvent(
				MutationEventImpl.DOM_ATTR_MODIFIED,
				false, false,
				null,
				"a previous value",
				"a new value",
				"attrname",
				1 );
			
			Assert.assertEquals( MutationEventImpl.DOM_ATTR_MODIFIED, evt.type );
			Assert.assertFalse( evt.bubbles );
			Assert.assertFalse( evt.cancelable );
			Assert.assertNull( evt.relatedNode );
			Assert.assertEquals( "a previous value", evt.prevValue );
		}		
		
		[Test]
		public function testCreateFocusEvent():void
		{
			var docEvents:DocumentEvent = getDocumentEvent();
			
			//create a DOM event
			var evt:FocusEvent = FocusEvent( docEvents.createEvent(
				DocumentEventImpl.FOCUS_EVENT_INTERFACE ) );
			Assert.assertNotNull( evt );
			
			evt.initFocusEvent(
				FocusEventImpl.BLUR, false, false, null, -1, null );
			
			Assert.assertEquals( FocusEventImpl.BLUR, evt.type );
			Assert.assertFalse( evt.bubbles );
			Assert.assertFalse( evt.cancelable );
			Assert.assertNull( evt.view );
			Assert.assertEquals( -1, evt.detail );
			Assert.assertNull( evt.relatedTarget );
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