package com.ffsys.w3c.dom.events
{
	import org.w3c.dom.events.EventTarget;
	import org.w3c.dom.events.FocusEvent;
	import org.w3c.dom.views.VisualResource;
	
	/**
	* 	Represents a user interface focus event.
	*/
	public class FocusEventImpl extends UIEventImpl
		implements FocusEvent
	{	
		/**
		* 	A DOM focus in event type.
		*/
		public static const DOM_FOCUS_IN:String = "DOMFocusIn";
		
		/**
		* 	A DOM focus out event type.
		*/
		public static const DOM_FOCUS_OUT:String = "DOMFocusOut";
		
		/**
		* 	A focus event type.
		*/
		public static const FOCUS:String = "focus";
		
		/**
		* 	A focus in event type.
		*/
		public static const FOCUS_IN:String = "focusin";
		
		/**
		* 	A focus out event type.
		*/
		public static const FOCUS_OUT:String = "focusout";
		
		/**
		* 	A blur event type.
		*/
		public static const BLUR:String = "blur";
		
		private var _relatedTarget:EventTarget;
		
		/**
		* 	Creates a <code>FocusEventImpl</code> instance.
		* 
		* 	@param type The type of the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is cancelable.
		*/
		public function FocusEventImpl(
			type:String = null,
			bubbles:Boolean = false,
			cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}

		/**
		* 	@inheritDoc
		*/
		public function get relatedTarget():EventTarget
		{
			return _relatedTarget;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function initFocusEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean,
			view:VisualResource,
			detail:int,
			relatedTarget:EventTarget ):void
		{
			initUIEvent( type, bubbles, cancelable, view, detail );
			_relatedTarget = relatedTarget;
		}
	}
}