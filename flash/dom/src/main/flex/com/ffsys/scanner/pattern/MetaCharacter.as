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
			return candidate == STARTS_WITH || candidate == ASTERISK || candidate == PLUS
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
	}
}