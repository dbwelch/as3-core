package com.ffsys.dom
{
	import flash.display.*;
	import flash.events.*;
	
	import com.ffsys.dom.core.*;	

	dynamic public class VisualElement extends Element
	{
		private var _visual:DisplayObject;
		
		private var _style:String;		
		
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
		* 	Inline css style declarations.
		*/
		public function get style():String
		{
			return _style;
		}
		
		public function set style( value:String ):void
		{
			//invalidate the inline style cache
			if( value != _style )
			{
				_inlineStyleCache = null;
			}
			_style = value;
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
				setProxySource( _visual );
			}
		}
	}
}