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
	dynamic public class AreaElement extends VisualElement
	{
		private var _accesskey:String;
		
		//TODO
		private var _shape:String;
		private var _href:String;
		private var _alt:String;
		private var _nohref:String;
		
		/**
		* 	Creates a <code>AreaElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function AreaElement( xml:XML = null )
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