package com.ffsys.net.sax
{

	public class SaxToken extends Object
	{
		/**
		* 	Represents an element.
		*/
		public static const ELEMENT:String = "element";	
		
		/**
		* 	Represents a text node.
		*/
		public static const TEXT:String = "text";	
		
		/**
		* 	Represents a comment node.
		*/
		public static const COMMENT:String = "comment";
		
		/**
		* 	Represents a CDATA text node.
		*/
		public static const CDATA:String = "cdata";
		
		/**
		* 	Represents a processing instruction.
		*/
		public static const PROCESSING_INSTRUCTION:String = "processing-instruction";
		
		/**
		* 	Represents a simple element.
		* 	
		* 	A simple element is an element whose child
		* 	elements are <em>only</em> text elements.
		*/
		public static const SIMPLE:String = "simple";
		
		/**
		* 	Represents an inline element.
		* 	
		* 	An inline element is an element whose children
		* 	are a mix of text and other elements.
		*/
		public static const INLINE:String = "inline";
		
		/**
		* 	Represents a block element.
		* 
		* 	A block element is an element that does not
		* 	contain any direct child text elements.
		*/
		public static const BLOCK:String = "block";		
		
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
		public var type:String = "";
		
		/**
		* 	A parent token.
		*/
		public var parent:SaxToken;
		
		/**
		* 	A target object associated with this token.
		*/
		public var target:Object;
		
		
		private var _name:String;
		
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
		* 	Determines whether this token represents an element.
		*/
		public function isElement():Boolean
		{
			return type == ELEMENT || type == SIMPLE || type == INLINE || type == BLOCK;
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
			return type;
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
		* 	The <code>XML</code> that defined the element being parsed.
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
		
		/**
		* 	Gets a string representation of this token.
		* 
		* 	@return The string representation of this token.
		*/
		public function toString():String
		{
			return "[object SaxToken#" + ( name != null ? name : type.toUpperCase() ) + "]";
		}
		
		/**
		*	@private 
		*/
		protected function processAttributes( x:XML ):void
		{
			var attrs:XMLList = x.attributes();
			
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