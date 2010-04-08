package com.ffsys.io.http {
	
	/**
	*	Encapsulates an individual HTTP
	*	header.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.08.2007
	*/
	public class HttpResponseHeader extends Object {
		
		/**
		*	@private	
		*/
		private var _name:String;
		
		/**
		*	@private
		*/
		private var _value:String;
		
		/**
		*	Creates an <code>HttpResponseHeader</code>
		*/
		public function HttpResponseHeader(
			name:String = null,
			value:String = null )
		{
			super();
			this.name = name;
			this.value = value;
		}
		
		public function parse( data:String ):void
		{
			var index:int = data.indexOf( HttpConstants.DELIMITER );
			_name = data.substr( 0, index );
			_value = data.substr( index + 1 );	
		}
		
		/**
		*	The <code>name</code> of the HTTP header. 
		*/
		public function set name( val:String ):void
		{
			_name = val;
		}
		
		public function get name():String
		{
			return _name;
		}		
		
		/**
		*	The <code>value</code> of the HTTP header.
		*/		
		public function set value( val:String ):void
		{
			_value = val;
		}
		
		public function get value():String
		{
			return _value;
		}
		
		/**
		*	Gets a <code>String</code> representation
		*	of this instance.
		*	
		*	@return The <code>String</code>
		*	representation of this instance.
		*/		
		public function toString():String
		{
			return "[object HttpResponseHeader][" + _name + HttpConstants.DELIMITER + _value + "]";
		}
	}
}