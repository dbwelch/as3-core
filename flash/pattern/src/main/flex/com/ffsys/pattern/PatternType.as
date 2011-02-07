package com.ffsys.pattern
{
	/**
	*	<p>Encapsulates constants representing the various pattern types.</p>
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.03.2011
	*/
	public class PatternType extends Object
	{
		/**
		* 	Represents a rule list.
		*/
		public static const RULE_LIST:uint = 1;
		
		/**
		* 	Represents a rule.
		*/
		public static const RULE:uint = 2;
		
		/**
		* 	Represents a group.
		*/
		public static const GROUP:uint = 4;
		
		/**
		* 	Represents a range.
		*/
		public static const RANGE:uint = 8;
		
		/**
		* 	Represents a character class.
		*/
		public static const CHARACTER_CLASS:uint = 16;
		
		/**
		* 	Represents a quantifier.
		*/
		public static const QUANTIFIER:uint = 32;
		
		/**
		* 	Represents a modifier.
		*/
		public static const MODIFIER:uint = 64;
		
		/**
		* 	Represents any other meta character or meta sequence.
		*/
		public static const META:uint = 128;
		
		/**
		* 	Represents a character data potentially
		* 	mixed with quantifiers.
		*/
		public static const DATA:uint = 256;
		
		private var _type:uint;
		
		/**
		* 	Creats a <code>PatternType</code> instance.
		* 
		* 	@param type The type of the pattern.
		*/
		public function PatternType( type:uint = 0 )
		{
			super();
			this.type = type;
		}
		
		/**
		* 	The type for the pattern.
		*/
		public function get type():uint
		{
			return _type;
		}
		
		public function set type( value:uint ):void
		{
			_type = value;
		}
		
		/**
		* 	Retrieves the locale name of a pattern
		* 	based on the type associated with this
		* 	pattern type representation.
		*/
		public function getLocalName( type:uint ):String
		{
			return null;
		}
	}
}