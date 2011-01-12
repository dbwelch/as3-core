package com.ffsys.net.sax
{

	public class SaxToken extends Object
	{
		private var _xml:XML;
		private var _attributes:Vector.<SaxAttribute>;
		
		/**
		* 	The depth in the element tree.
		*/
		public var depth:int;
		
		/**
		* 	A flag that can be set on a token
		* 	to quit any further processing.
		*/
		//TODO: implement
		public var quit:Boolean = false;
		
		/**
		* 	Indicates the type of child content for
		* 	the element.
		*/
		public var type:String;
		
		/**
		* 	A parent token.
		*/
		public var parent:SaxToken;
		
		/**
		* 	A target object associated with this token.
		*/
		public var target:Object;
		
		/**
		* 	Creates a <code>SaxToken</code> instance.
		*/
		public function SaxToken(
			xml:XML = null,
			parent:SaxToken = null,
			depth:int = 0,
			type:String = null )
		{
			super();
			this.xml = xml;
			this.parent = parent;
			this.depth = depth;
			this.type = type;
		}
		
		/**
		* 	The local name of the element.
		*/
		public function get name():String
		{
			if( _xml && _xml.name() )
			{
				return _xml.name().localName;
			}
			return null;
		}		
		
		/**
		* 	A list of parsed attributes associated with
		* 	this token.
		*/
		public function get attributes():Vector.<SaxAttribute>
		{
			if( _attributes == null )
			{
				_attributes = new Vector.<SaxAttribute>();
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
			
			//trace("SaxParser::doWithAttributes()", attrs.length() );
			
			var attr:XML;
			var name:String;
			for each( attr in attrs )
			{
				attributes.push(
					new SaxAttribute( attr ) );
			}
		}		
	}
}