package com.ffsys.dom
{
	/**
	*	Represents a <code>DOM</code> attribute.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class Attr extends Node
	{
		private var _ownerElement:Element;
		private var _specified:Boolean;
		private var _uri:String;
		private var _name:String;
		private var _value:String;
		
		/**
		* 	Creates an <code>Attr</code> instance.
		* 
		* 	@param name The name of the attribute.
		* 	@param value The value of the attribute.
		* 	@param uri A <code>URI</code> for the attribute
		* 	that indicates it is a qualified attribute.
		*/
		public function Attr(
			name:String = null,
			value:String = null,
			uri:String = null )
		{
			_nodeType = Node.ATTRIBUTE_NODE;
			super();
			this.name = name;
			this.value = value;
			this.uri = uri;						
		}
		
		/**
		* 	A qualified name for this attribute.
		*/
		public function get qname():QName
		{
			return new QName( this.uri, name );
		}
		
		/**
		* 	The name of this attribute.
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
		* 	Ensures the local name matches the attribute name.
		*/
		override public function get localName():String
		{
			return name;
		}
		
		/**
		* 	The value for the attribute.
		*/
		public function get value():String
		{
			return _value;
		}
		
		public function set value( value:String ):void
		{
			_value = value;
		}
		
		/**
		* 	A <code>URI</code> that indicates this is a qualified attribute.
		*/
		public function get uri():String
		{
			return _uri;
		}
		
		public function set uri( value:String ):void
		{
			_uri = value;
		}
		
		/**
		* 	Whether this attribute was specified
		* 	when a document element was parsed.
		*/
		public function get specified():Boolean
		{
			return _specified;
		}
		
		internal function setSpecified( value:Boolean ):void
		{
			_specified = value;
		}
		
		/**
		* 	The element that owns this attribute.
		*/
		public function get ownerElement():Element
		{
			return _ownerElement;
		}
		
		internal function setOwnerElement( element:Element ):void
		{
			_ownerElement = element;
		}
	}
}