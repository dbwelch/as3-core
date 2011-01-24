package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents an anchor, the <code>a</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.01.2011
	*/
	dynamic public class AnchorElement extends InlineElement
	{
		//TODO
		private var _href:String;
		private var _charset:String;
		private var _rev:String;
		private var _rel:String;
		private var _type:String;
		private var _accesskey:String;
		private var _hreflang:String;
		private var _target:String;
		private var _tabindex:String;
		
		//Other: onfocus type accesskey onblur hreflang target tabindex
		
		/**
		* 	Creates a <code>AnchorElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function AnchorElement( xml:XML = null )
		{
			super( xml );
		}
		
		public function get href():String
		{
			return _href;
		}
		
		public function set href( value:String ):void
		{
			_href = value;
		}
	}
}