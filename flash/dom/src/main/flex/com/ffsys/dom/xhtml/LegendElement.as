package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a legend, the <code>legend</code> element.
	* 
	* 	This element is not considered to be either <code>block</code>
	* 	or <code>inline</code> by default but is a container for other elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class LegendElement extends VisualElement
	{
		private var _accesskey:String;
		
		/**
		* 	Creates a <code>LegendElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function LegendElement( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	An access key for this legend.
		*/
		public function get accesskey():String
		{
			return _accesskey;
		}
		
		public function set accesskey( value:String ):void
		{
			_accesskey = value;
		}
	}
}