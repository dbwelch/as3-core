package com.ffsys.dom
{
	import flash.display.DisplayObject;

	dynamic public class VisualElement extends Element
	{
		private var _visual:DisplayObject;
		
		/**
		* 	Creates a <code>VisualElement</code> instance.
		*/
		public function VisualElement( xml:XML = null )
		{
			super( xml );
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
			
			trace("VisualElement::set visual()", this );
			
			if( _visual != null )
			{
				//update the core proxy to the visual composite
				setSource( _visual );
			}
		}
	}
}