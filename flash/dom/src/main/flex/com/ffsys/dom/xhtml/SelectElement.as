package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a selection of options, the <code>select</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class SelectElement extends InlineElement
	{
		private var _name:String;
		private var _disabled:String;
		private var _multiple:String;
		
		//TODO
		private var _size:uint;
		private var _tabindex:int;
		
		//Other: disabled onchange size onfocus onblur multiple name tabindex
		
		/**
		* 	Creates a <code>SelectElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function SelectElement( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	The name of this select element.
		*/
		public function get name():String
		{
			return _name;
		}
		
		public function set name( value:String ):void
		{
			_name = value;
		}
		
		/**
		* 	Whether this select is disabled.
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
		* 	Whether this select allows selection
		* 	of multiple options.
		*/
		public function get multiple():String
		{
			return _multiple;
		}
		
		public function set multiple( value:String ):void
		{
			_multiple = value;
		}
	}
}