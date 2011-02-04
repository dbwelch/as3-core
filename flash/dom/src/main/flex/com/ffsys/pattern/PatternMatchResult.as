package com.ffsys.pattern
{
	import flash.utils.getQualifiedClassName;
	
	/**
	* 	Represents the result of a single pattern
	* 	match.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.03.2011
	*/
	public class PatternMatchResult extends Object
	{
		private var _pattern:Pattern;
		private var _position:uint = 0;
		private var _result:Boolean;
		private var _source:*;
		private var _message:String;
		
		/**
		* 	Creates a <code>PatternMatchResult</code> instance.
		*/
		public function PatternMatchResult(
			position:uint = 0,
			pattern:Pattern = null,
			source:* = null )
		{
			super();
			this.position = position;
			this.pattern = pattern;
			this.source = source;
		}
		
		/**
		* 	The position for this pattern match.
		*/
		public function get position():uint
		{
			return _position;
		}
		
		public function set position( value:uint ):void
		{
			_position = value;
		}
		
		/**
		* 	The pattern being matched against.
		*/
		public function get pattern():Pattern
		{
			return _pattern;
		}
		
		public function set pattern( value:Pattern ):void
		{
			_pattern = value;
		}
		
		/**
		* 	Whether the pattern match succeeded.
		*/
		public function get result():Boolean
		{
			return _result;
		}
		
		public function set result( value:Boolean ):void
		{
			_result = value;
		}
		
		/**
		* 	The source being matched.
		*/
		public function get source():*
		{
			return _source;
		}
		
		public function set source( value:* ):void
		{
			_source = value;
		}
		
		/**
		* 	A message associated with this match result.
		*/
		public function get message():String
		{
			return _message;
		}
		
		public function set message( value:String ):void
		{
			_message = value;
		}
		
		/**
		* 	An xml representation of this match.
		*/
		public function get xml():XML
		{
			return getXml( false );
		}
		
		/**
		* 	Gets a string representation of this
		* 	pattern match result.
		*/
		public function toString():String
		{
			return getXml( false ).toXMLString();
		}
		
		/**
		* 	@private
		*/
		internal function getXml( simple:Boolean = true ):XML
		{
			var x:XML = new XML( "<" + Pattern.MATCH + " />" );
			x.@position = position;			
			x.@result = result;
			if( !simple )
			{
				if( source != null )
				{
					var src:XML = new XML( "<source><![CDATA["
						+ source + "]]></source>" );
					src.@type = getQualifiedClassName( source );
					x.appendChild( src );
				}
				if( pattern != null )
				{
					x.appendChild(
						new XML(
						"<" + Pattern.PATTERN + "><![CDATA["
						+ pattern.toPatternString()
						+ "]]></" + Pattern.PATTERN + ">" ) );
				}
			}
			return x;
		}
	}
}