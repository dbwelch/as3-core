package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a meta element, the <code>meta</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	public class MetaElement extends Element
		implements EmptyElement
	{
		private var _name:String;
		private var _content:String;
		private var _httpEquiv:String;
		private var _scheme:String;
		
		/**
		* 	Creates a <code>MetaElement</code> instance.
		*/
		public function MetaElement()
		{
			super();
		}
		
		/**
		* 	The name of the meta element.
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
		* 	Content for the meta element.
		*/
		public function get content():String
		{
			return _content;
		}
		
		public function set content( value:String ):void
		{
			_content = value;
		}
		
		/**
		* 	The <code>http-equiv</code> attribute value.
		*/
		public function get httpEquiv():String
		{
			return _httpEquiv;
		}
		
		public function set httpEquiv( value:String ):void
		{
			_httpEquiv = value;
		}
		
		/**
		* 	A scheme for the meta element.
		*/
		public function get scheme():String
		{
			return _scheme;
		}
		
		public function set scheme( value:String ):void
		{
			_scheme = value;
		}
	}
}