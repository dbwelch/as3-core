package com.ffsys.w3c.dom.events
{
	import org.w3c.dom.events.UIEvent;
	import org.w3c.dom.views.VisualResource;
	
	/**
	* 	Represents a user interface event.
	*/
	public class UIEventImpl extends EventImpl
		implements UIEvent
	{
		/**
		* 	A resize event type.
		*/
		public static const RESIZE:String = "resize";
		
		/**
		* 	A scroll event type.
		*/
		public static const SCROLL:String = "scroll";
		
		private var _view:VisualResource;
		private var _detail:int = -1;
		
		/**
		* 	Creates a <code>UIEventImpl</code> instance.
		* 
		* 	@param type The type of the event.
		* 	@param bubbles Whether the event bubbles.
		* 	@param cancelable Whether the event is cancelable.
		*/
		public function UIEventImpl(
			type:String = null,
			bubbles:Boolean = false,
			cancelable:Boolean = false )
		{
			super( type, bubbles, cancelable );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get view():VisualResource
		{
			return _view;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get detail():int
		{
			return _detail;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function initUIEvent(
			type:String,
			bubbles:Boolean,
			cancelable:Boolean,
			view:VisualResource,
			detail:int ):void
		{
			initEvent( type, bubbles, cancelable );
			_view = view;
			_detail = detail;
		}
	}
}