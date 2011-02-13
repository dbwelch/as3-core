package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	import com.ffsys.dom.core.Element;
	
	/**
	*	Represents an option, the <code>option</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.01.2011
	*/
	dynamic public class OptionElement extends Element
		implements TextElement
	{
		private var _label:String;
		private var _value:*;
		private var _disabled:String;
		private var _selected:String;
		
		/**
		* 	Creates a <code>OptionElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function OptionElement( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	The label for this option.
		*/
		public function get label():String
		{
			return _label;
		}
		
		public function set label( value:String ):void
		{
			_label = value;
		}
		
		/**
		* 	The value for this option.
		*/
		public function get value():*
		{
			return _value;
		}
		
		public function set value( value:* ):void
		{
			_value = value;
		}
		
		/**
		* 	A disabled value for this option.
		*/
		public function get disabled():String
		{
			return _disabled;
		}
		
		public function set disabled( value:String ):void
		{
			_disabled = value;
		}
		
		/**
		* 	A selected value for this option.
		*/
		public function get selected():String
		{
			return _selected;
		}
		
		public function set selected( value:String ):void
		{
			_selected = value;
		}
	}
}