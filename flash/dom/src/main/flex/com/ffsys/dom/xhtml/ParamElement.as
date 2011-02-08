package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;	
	import com.ffsys.dom.core.Element;

	/**
	*	Represents a parameter, the <code>param</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.01.2011
	*/
	public class ParamElement extends Element
		implements EmptyElement
	{
		private var _name:String;
		private var _type:String;
		private var _valuetype:String;
		private var _value:String;
		
		/**
		* 	Creates a <code>ParamElement</code> instance.
		*/
		public function ParamElement()
		{
			super();
		}
		
		/**
		* 	A name for the parameter.
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
		*	A <code>MIME</code> type for the parameter.
		*/
		public function get type():String
		{
			return _type;
		}
		
		public function set type( value:String ):void
		{
			_type = value;
		}
		
		/**
		* 	A type for the value.
		*/
		public function get valuetype():String
		{
			return _valuetype;
		}
		
		public function set valuetype( value:String ):void
		{
			_valuetype = value;
		}
		
		/**
		* 	The parameter value.
		*/
		public function get value():String
		{
			return _value;
		}
		
		public function set value( value:String ):void
		{
			_value = value;
		}
	}
}