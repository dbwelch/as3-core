package com.ffsys.net.sax
{

	public class SAXToken extends Object
	{
		private var _xml:XML;
		private var _attributes:Vector.<SAXAttribute>;
		
		/**
		* 	The depth in the element tree.
		*/
		public var depth:int;
		
		/**
		* 	A flag that can be set on a token
		* 	to quit any further processing.
		*/
		public var quit:Boolean = false;
		
		/**
		* 	Indicates the type of child content for
		* 	the element.
		*/
		public var type:String;
		
		/**
		* 	Creates a <code>SAXToken</code> instance.
		*/
		public function SAXToken( xml:XML = null )
		{
			super();
			this.xml = xml;
		}
		
		/**
		* 	The local name of the element.
		*/
		public function get name():String
		{
			if( _xml )
			{
				return _xml.name().localName;
			}
			return null;
		}		
		
		/**
		* 	A list of parsed attributes associated with
		* 	this token.
		*/
		public function get attributes():Vector.<SAXAttribute>
		{
			if( _attributes == null )
			{
				_attributes = new Vector.<SAXAttribute>();
			}
			return _attributes;
		}
		
		/**
		* 	The XML that defined the element being parsed.
		*/
		public function get xml():XML
		{
			return _xml;
		}
		
		public function set xml(value:XML):void
		{
			_xml = value;
			
			if( _xml != null )
			{
				processAttributes( _xml );
			}
		}
		
		protected function processAttributes( x:XML ):void
		{
			var attrs:XMLList = x.@*;
			
			//trace("SAXParser::doWithAttributes()", attrs.length() );
			
			var attr:XML;
			var name:String;
			for each( attr in attrs )
			{
				attributes.push(
					new SAXAttribute( attr ) );
			}
		}		
	}
}