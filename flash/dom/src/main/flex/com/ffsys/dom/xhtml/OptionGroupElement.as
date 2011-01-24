package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents an option group, the <code>optgroup</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.01.2011
	*/
	dynamic public class OptionGroupElement extends Element
	{
		private var _label:String;
		private var _disabled:String;
		
		/**
		* 	Creates a <code>OptionGroupElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function OptionGroupElement( xml:XML = null )
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
	}
}