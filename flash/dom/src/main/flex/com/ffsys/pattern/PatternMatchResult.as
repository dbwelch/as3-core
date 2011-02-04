package com.ffsys.pattern
{

	public class PatternMatchResult extends Object
	{
		private var _pattern:Pattern;
		private var _position:uint = 0;
		private var _result:Boolean;
		private var _source:*;
		
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
	}
}