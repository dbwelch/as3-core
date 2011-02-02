package com.ffsys.scanner.pattern
{
	import com.ffsys.scanner.*;
	
	/**
	* 	Abstract super class for meta characters.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/	
	public class MetaCharacter extends Pattern
	{
		/**
		* 	A qualifier that indicates the start position.
		*/
		public static const STARTS_WITH:String = "^";
		
		/**
		* 	Represents a wildcard sequence.
		*/
		public static const DOT:String = ".";
		
		/**
		* 	A qualifier that indicates zero or more occurences.
		*/
		public static const ASTERISK:String = "*";
		
		/**
		* 	A qualifier that indicates one or more occurences.
		*/
		public static const PLUS:String = "+";
		
		/**
		* 	A qualifier that indicates alternation.
		*/
		public static const ALTERNATOR:String = "|";
		
		/**
		* 	A qualifier that indicates a range.
		*/
		public static const RANGE:String = "-";
		
		/**
		* 	A qualifier that indicates zero or one occurence.
		*/
		public static const OPTIONAL:String = "?";	
		
		/**
		* 	A qualifier that indicates the end position.
		*/
		public static const ENDS_WITH:String = "$";
		
		//
		public static const OPEN_GROUP:String = "(";
		
		public static const CLOSE_GROUP:String = ")";
		
		public static const OPEN_CLASS:String = "[";
		
		public static const CLOSE_CLASS:String = "]";
		
		public static const OPEN_MIN_MAX:String = "{";
		
		public static const CLOSE_MIN_MAX:String = "}";
		
		public static const POSITIVE_LOOKAHEAD:String = "?=";
		
		public static const NEGATIVE_LOOKAHEAD:String = "?!";
		
		public static const NON_CAPTURING:String = "?:";
		
		public static const NAMED:String = "?P";
		
		/**
		* 	Creates a <code>MetaCharacter</code> instance.
		* 
		* 	@param char The char of qualifier.
		*/
		public function MetaCharacter( char:String = null )
		{
			super();
			this.char = char;
		}
		
		/**
		* 	Determines whether a candidate string
		* 	represents a qualifier.
		* 
		* 	@param candidate The candidate string.
		* 
		* 	@return Whether the candidate represents a known qualifier.
		*/
		public function qualifies( candidate:String ):Boolean
		{
			return candidate == STARTS_WITH || candidate == ASTERISK || candidate == DOT || candidate == PLUS
				|| candidate == OPTIONAL || candidate == ENDS_WITH || candidate == ALTERNATOR
				|| candidate == RANGE;
		}
		
		/**
		* 	The char of this qualifier.
		*/	
		public function get char():String
		{
			return matched;
		}
		
		public function set char( value:String ):void
		{
			matched = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function toString():String
		{
			return "" + char;
		}
		
		/**
		* 	Determines whether a character string is deemed to be
		* 	a meta character.
		* 
		* 	@param char The character string candidate.
		* 
		* 	@return Whether the character string is considered to	
		* 	be a meta character.
		*/
		public static function character( char:String ):Boolean
		{
			return char == STARTS_WITH || char == ASTERISK || char == DOT || char == PLUS
				|| char == OPTIONAL || char == ENDS_WITH || char == ALTERNATOR
				|| char == RANGE || char == OPEN_GROUP || char == CLOSE_GROUP
				|| char == OPEN_MIN_MAX || char == CLOSE_MIN_MAX || char == OPEN_CLASS
				|| char == CLOSE_CLASS || char == POSITIVE_LOOKAHEAD || char == NEGATIVE_LOOKAHEAD
				|| char == NON_CAPTURING || char == NAMED;
		}
	}
}