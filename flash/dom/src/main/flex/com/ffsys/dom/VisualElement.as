package com.ffsys.dom
{
	import flash.display.*;
	import flash.events.*;	

	dynamic public class VisualElement extends Element
	{
		private var _visual:DisplayObject;
		
		/**
		* 	Creates a <code>VisualElement</code> instance.
		*/
		public function VisualElement( xml:XML = null )
		{
			//temporarily instantiate here for testing
			this.visual = new Sprite();
			super( xml );
		}
	
		/**
		* 	Ensures that visual elements use the visual as
		* 	the event dispatcher proxy.
		*/
		override public function get eventProxy():IEventDispatcher
		{
			return _visual;
		}
		
		/**
		* 	The visual display object instance.
		*/
		public function get visual():DisplayObject
		{
			return _visual;
		}
		
		public function set visual( value:DisplayObject ):void
		{
			_visual = value;
			
			//trace("VisualElement::set visual()", this );
			
			if( _visual != null )
			{
				//update the core proxy to the visual composite
				setSource( _visual );
			}
		}
	}
}