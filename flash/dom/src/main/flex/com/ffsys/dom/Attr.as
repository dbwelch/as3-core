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
		/**
		* 	The delimiter used to delimit <code>XML</code>
		* 	namespace prefixes and the local name of the node.
		*/
		public static const NAMESPACE_DELIMITER:String = ":";
		
		private var _ownerElement:Element;
		private var _specified:Boolean;
		private var _uri:String;
		private var _name:String;
		private var _value:String;
		private var _prefix:String;
		private var _data:Object;
		
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
			if( isQualified() )
			{
				return new QName( this.uri, name );
			}
			
			return new QName( name );
		}
		
		/*
		
		var ns:Namespace = node.namespace();
		if( ns
			&& ns.uri.length > 0
			&& ns.prefix.length > 0 )
		{		
		
		*/
		
		public function isQualified():Boolean
		{
			return uri != null && uri.length > 0;
		}
		
		/**
		* 	The name of this attribute.
		*/
		public function get name():String
		{
			var output:String = _name;
			if( prefix != null )
			{
				output = prefix + NAMESPACE_DELIMITER + _name;
			}
			return output;
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
			return _name;
		}
		
		/**
		* 	The name of this node.
		*/
		override public function get nodeName():String
		{
			return _name;
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
		* 	Data associated with this attribute.
		*/
		public function get data():Object
		{
			if( _data == null
				&& value != null )
			{
				//TODO: CREATE DEFAULT DATA AS A PRIMITIVE VALUE
			}
			
			return _data;
		}
		
		public function set data( value:Object ):void
		{
			_data = value;
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
		* 	A namespace prefix associated with this attribute.
		*/
		public function get prefix():String
		{
			return _prefix;
		}
		
		public function set prefix( value:String ):void
		{
			_prefix = value;
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