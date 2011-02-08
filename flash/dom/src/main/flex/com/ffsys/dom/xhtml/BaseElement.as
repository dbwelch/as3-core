package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;	
	
	import com.ffsys.dom.core.*;

	/**
	*	Represents a base href, the <code>base</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.01.2011
	*/
	public class BaseElement extends Element
		implements EmptyElement
	{
		private var _href:String;
		private var _target:String;
		
		/**
		* 	Creates a <code>BaseElement</code> instance.
		*/
		public function BaseElement()
		{
			super();
		}
		
		/**
		* 	The base href.
		*/
		public function get href():String
		{
			return _href;
		}
		
		public function set href( value:String ):void
		{
			_href = value;
		}
		
		/**
		*	The base target.
		*/
		public function get target():String
		{
			return _target;
		}
		
		public function set target( value:String ):void
		{
			_target = value;
		}
	}
}