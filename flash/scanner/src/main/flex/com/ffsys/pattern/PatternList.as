package com.ffsys.pattern
{
	/**
	* 	Represents a collection of patterns.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/
	dynamic public class PatternList extends Array
	{					
		/**
		* 	The delimiter used to mark the
		* 	beginning and end of a pattern.
		*/
		public static const DELIMITER:String = "/";
		
		/**
		* 	The name for a pattern rule.
		*/
		public static const RULE:String = "rule";
		
		/**
		* 	The name for a pattern.
		*/
		public static const PATTERN:String = "pattern";
		
		/**
		* 	The name for a list of patterns.
		*/
		public static const PATTERNS:String = "patterns";
		
		/**
		* 	The name for a pattern that belongs
		* 	to another pattern.
		*/
		public static const PTN:String = "ptn";
		
		/**
		* 	The name for pattern parts.
		*/
		public static const PARTS:String = "parts";
		
		/**
		* 	The name for a pattern match result list.
		*/
		public static const RESULTS:String = "results";
		
		/**
		* 	The name for a pattern match.
		*/
		public static const MATCH:String = "match";	
		
		/**
		* 	The name for the target of a pattern match.
		*/
		public static const TARGET:String = "target";
		
		/**
		* 	The name for the source of a pattern.
		*/
		public static const SOURCE:String = "source";
		
		/**
		* 	The name for an alternator.
		*/
		public static const ALTERNATOR_NAME:String = "alternator";
		
		/**
		* 	The name for a group.
		*/
		public static const GROUP_NAME:String = "group";
		
		/**
		* 	The name for a range (character class).
		*/
		public static const RANGE_NAME:String = "range";
		
		/**
		* 	The name for a quantifier.
		*/
		public static const QUANTIFIER_NAME:String = "quantifier";
		
		/**
		* 	The name for a meta character or sequence.
		*/
		public static const META_NAME:String = "meta";
		
		/**
		* 	The name for a meta sequence of escape characters.
		*/
		public static const ESCAPE_SEQUENCE_NAME:String = "escape";
		
		/**
		* 	The name for a non-meta data chunk.
		*/
		public static const DATA_NAME:String = "data";
		
		/**
		* 	Represents the escape meta character.
		*/
		public static const ESCAPE_CHARACTER:String = "\\";
		
		/**
		* 	Represents the vertical feed meta sequence.
		*/
		public static const VERTICAL_FEED_SEQUENCE:String = "v";
		
		/**
		* 	Represents the line feed meta sequence.
		*/
		public static const LINE_FEED_SEQUENCE:String = "f";
		
		/**
		* 	Represents the carriage return meta sequence.
		*/
		public static const CARRIAGE_RETURN_SEQUENCE:String = "r";
		
		/**
		* 	Represents the new line meta sequence.
		*/
		public static const NEW_LINE_SEQUENCE:String = "n";
		
		/**
		* 	Represents the tab meta sequence.
		*/
		public static const TAB_SEQUENCE:String = "t";
		
		/**
		* 	Represents the word boundary meta sequence.
		*/
		public static const WORD_BOUNDARY_SEQUENCE:String = "b";
		
		/**
		* 	Represents the non-word boundary meta sequence.
		*/
		public static const NON_WORD_BOUNDARY_SEQUENCE:String = "B";
		
		/**
		* 	Represents the whitespace meta sequence.
		*/
		public static const WHITESPACE_SEQUENCE:String = "s";
		
		/**
		* 	Represents the non-whitespace meta sequence.
		*/
		public static const NON_WHITESPACE_SEQUENCE:String = "S";
		
		/**
		* 	Represents the a word sequence.
		*/
		public static const WORD_CHARACTER_SEQUENCE:String = "w";
		
		/**
		* 	Represents the a non-word sequence.
		*/
		public static const NON_WORD_CHARACTER_SEQUENCE:String = "W";
		
		/**
		* 	Represents the a digit sequence.
		*/
		public static const DIGIT_SEQUENCE:String = "d";
		
		/**
		* 	Represents the a non-digit sequence.
		*/
		public static const NON_DIGIT_SEQUENCE:String = "D";
		
		/**
		* 	A list of meta sequences.
		*/
		public static const META_CHARACTER_SEQUENCES:Array = [
			VERTICAL_FEED_SEQUENCE,
			LINE_FEED_SEQUENCE,
			CARRIAGE_RETURN_SEQUENCE,
			NEW_LINE_SEQUENCE,
			TAB_SEQUENCE,
			WORD_BOUNDARY_SEQUENCE,
			NON_WORD_BOUNDARY_SEQUENCE,
			WHITESPACE_SEQUENCE,
			NON_WHITESPACE_SEQUENCE,
			WORD_CHARACTER_SEQUENCE,
			NON_WORD_CHARACTER_SEQUENCE,
			DIGIT_SEQUENCE,
			NON_DIGIT_SEQUENCE
		];
		
		/**
		* 	A list of escaped meta sequences.
		*/
		public static const ESCAPED_META_CHARACTER_SEQUENCES:Array = [
			ESCAPE_CHARACTER + VERTICAL_FEED_SEQUENCE,
			ESCAPE_CHARACTER + LINE_FEED_SEQUENCE,
			ESCAPE_CHARACTER + CARRIAGE_RETURN_SEQUENCE,
			ESCAPE_CHARACTER + NEW_LINE_SEQUENCE,
			ESCAPE_CHARACTER + TAB_SEQUENCE,
			ESCAPE_CHARACTER + WORD_BOUNDARY_SEQUENCE,
			ESCAPE_CHARACTER + NON_WORD_BOUNDARY_SEQUENCE,
			ESCAPE_CHARACTER + WHITESPACE_SEQUENCE,
			ESCAPE_CHARACTER + NON_WHITESPACE_SEQUENCE,
			ESCAPE_CHARACTER + WORD_CHARACTER_SEQUENCE,
			ESCAPE_CHARACTER + NON_WORD_CHARACTER_SEQUENCE,
			ESCAPE_CHARACTER + DIGIT_SEQUENCE,
			ESCAPE_CHARACTER + NON_DIGIT_SEQUENCE
		];
		
		/**
		* 	@private
		* 	
		*	The child patterns for this pattern.
		*/
		private var _patterns:Vector.<Pattern>;
		
		/**
		* 	@private
		*/
		internal var _regex:RegExp;
		
		/**
		* 	@private
		*/
		protected var _list:PatternList;
		
		private var _owner:PatternList;
		private var _name:String;
		private var _index:int = -1;
		
		/**
		* 	Creates a <code>PatternList</code> instance.
		*/
		public function PatternList()
		{
			super();
		}
		
		/**
		* 	An owner for this pattern.
		*/
		public function get owner():PatternList
		{
			return _owner;
		}
		
		/**
		* 	@private
		*/
		internal function setOwner( owner:PatternList ):void
		{
			_owner = owner;
		}
		
		/**
		* 	The index of this pattern in the context
		* 	of an owner pattern.
		*/
		public function get index():int
		{
			return _index;
		}
		
		/**
		* 	@private
		*/
		internal function setIndex( index:int ):void
		{
			_index = index;
		}
		
		/**
		* 	The first part of this pattern.
		*/
		public function get firstChild():Pattern
		{
			if( patterns.length > 0 )
			{
				return patterns[ 0 ];
			}
			return null;
		}
		
		/**
		* 	The last part of this pattern.
		*/
		public function get lastChild():Pattern
		{
			if( patterns.length > 0 )
			{
				return patterns[ patterns.length - 1 ];
			}
			return null;
		}
		
		/**
		* 	Determines whether this pattern
		* 	has any patterns.
		*/
		public function get empty():Boolean
		{
			return patterns.length == 0;
		}
		
		/**
		* 	Clears this pattern so that it is empty.
		*/
		public function clear():void
		{
			_patterns = null;
		}
		
		/**
		* 	Adds a pattern part to test against.
		* 	
		* 	@param part The pattern part to add.
		* 
		* 	@return Whether the part was added.
		*/
		public function add( part:Pattern ):Boolean
		{
			if( part != null )
			{
				part.setOwner( this as Pattern );
				part.setIndex( patterns.length );
				patterns.push( part );
				return true;
			}
			return false;
		}
		
		/*
		public function concat( pattern:Pattern ):void
		{
			for()
			{
				
			}
		}
		*/
		
		/**
		*	Removes pattern(s) from this pattern.
		* 
		* 	@param start The index to start removing
		* 	from.
		* 	@param end The end index to stop removing from.
		* 
		* 	@return A pattern or <code>null</code> if the start
		* 	index is out of range.
		*/
		public function remove( start:int = -1, end:int = -1 ):Pattern
		{
			//behave like pop() by default
			if( start == -1 && patterns.length > 0 )
			{
				start = ( patterns.length == 1 ) ? 0 : patterns.length - 2;
			}
			if( start >= 0 && start < patterns.length )
			{
				if( end == -1 )
				{
					end = start + 1;
				}
				if( end <= start )
				{
					end = start + 1;
				}
				var count:uint = uint( end - start );
				patterns.splice( start, count );
			}
			return null;
		}
		
		/**
		* 	Retrieves a child pattern at the specified
		* 	index.
		* 
		* 	@param index The index for the child pattern.
		*
		* 	@return The pattern at the specified index
		* 	or <code>null</code> if the index is out of
		* 	bounds.
		*/
		public function getPatternAt( index:int ):Pattern
		{
			if( index < 0 || index >= patterns.length )
			{
				return null;
			}
			return patterns[ index ];
		}
		
		/**
		* 	Retrieves a copy of the last pattern
		* 	match results.
		*/
		public function get results():Array
		{
			//TODO: move to composite vector
			return slice();
		}
		
		/**
		* 	Retrieves a list of the matches
		* 	that failed during the last pattern
		* 	match.
		*/
		public function get failures():Vector.<PatternMatchResult>
		{
			var output:Vector.<PatternMatchResult> =
				new Vector.<PatternMatchResult>();
			var match:PatternMatchResult = null;
			for( var i:int = 0;i < results.length;i++ )
			{
				match = PatternMatchResult( results[ i ] );
				if( !match.result )
				{
					output.push( match );
				}
			}
			return output;
		}
		
		/**
		* 	Tests whether the pattern matches
		* 	a value.
		* 
		* 	@param value The value to compare this pattern against.
		* 
		* 	@return Whether the pattern matches the value.
		*/
		public function test( value:* ):Boolean
		{
			return false;
		}
		
		/**
		* 	Determines whether this pattern is a rule
		*	
		* 	A rule is a pattern at the root of a
		* 	pattern hierarchy.
		*/
		public function get rule():Boolean
		{
			return ( owner == null );
		}
		
		/**
		* 	The patterns belonging to this pattern
		* 	as a vector.
		*/
		public function get patterns():Vector.<Pattern>
		{
			if( _patterns == null )
			{
				_patterns = new Vector.<Pattern>();
			}
			return _patterns;
		}
		
		/**
		* 	The patterns belonging to this pattern
		* 	as a pattern list.
		*/
		public function get children():PatternList
		{
			if( _list == null )
			{
				_list = new PatternList();
				_list._patterns = this.patterns;
			}
			return _list;
		}
		
		/**
		* 	A name for this pattern.
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
		* 	An <code>XML</code> representation of this pattern.
		*/
		public function get xml():XML
		{
			return null;
		}
		
		/**
		* 	A regular expression representation
		* 	of this pattern.
		*/
		public function get regex():RegExp
		{		
			return _regex;
		}
		
		/**
		* 	Gets a string representation of this pattern
		* 	that indicates it is a pattern as opposed to
		* 	a string or regular expression.
		* 
		* 	If this pattern is the root of a pattern hierarchy
		* 	it's string representation is encapsulated with pattern://,
		* 	otherwise the diminutive ptn:// is used.
		* 
		* 	@return A string representation of this pattern
		* 	that distinguishes it from a string or regular
		* 	expression.
		*/
		public function toPatternString():String
		{
			return null;
		}
		
		/**
		* 	Retrieves a string representation of this pattern.
		* 
		* 	@return A string representation of this pattern.
		*/
		public function toString():String
		{
			return null;
		}
		
		/*
		*	XML INTERNALS
		*/
		
		/**
		* 	@private
		* 
		* 	Creates an <code>XML</code> element within the namespace
		* 	for pattern <code>XML</code>.
		* 
		* 	@param nm The name for the <code>XML</code> element.
		* 	@param cdata Some CDATA text to add as
		* 	a child of the new element.
		* 
		* 	@return The <code>XML</code> element.
		*/
		protected function getXmlElement(
			nm:String = null,
			cdata:String = null ):XML
		{
			if( nm == null )
			{
				nm = this.name;
			}
			var x:XML = new XML( "<node />" );
			x.setNamespace( Pattern.NAMESPACE );
			x.setName( new QName( Pattern.NAMESPACE, nm ) );
			if( cdata != null )
			{
				x.appendChild( new XML( "<![CDATA[" + cdata + "]]>" ) );
			}
			return x;
		}
		
		/*
		*	REGEX INTERNALS
		*/		
		
		/**
		* 	@private
		* 
		* 	Determines whether a source string is
		* 	an shortcut meta character sequence,
		* 	<code>\b</code> etc.
		* 
		* 	@param src The source string to compare.
		* 
		* 	@return Whether the source candidate is
		* 	a valid shortcut meta sequence.
		*/
		protected function isShortCut(
			src:String ):Boolean
		{
			return __sequenced.test( src );
		}

		/**
		* 	@private
		*/
		protected static var __escapes:String = "(?:\\\\)";
		
		/**
		* 	@private
		*/
		protected static var __escaped:RegExp = new RegExp( "^(" + __escapes + ")$" );
		
		/**
		* 	@private
		*/
		protected static var __sequence:String = __escapes + "(?:[bBsSwWdDrfntv])";
		
		/**
		* 	@private
		*/
		protected static var __sequenced:RegExp = new RegExp( "^(" + __sequence + ")$" );
	
		/**
		* 	@private
		*/
		protected static var __quantifierRangeExpr:String =
			"(?:\\{(?:[0-9]+)(?:,[0-9]*)?\\})";
		
		/**
		* 	@private
		*/
		protected static var __quantifierRange:RegExp =
			new RegExp( "^(" + __quantifierRangeExpr + ")+$" );
		
		/**
		* 	@private
		*/
		protected static var __quantifiers:String =
			"(?:" + __quantifierRangeExpr + "|\\*|\\+|\\?){1}"
			+ "(?:\\?)?";	//additional lazy quantifier
		
		/**
		* 	@private
		*/
		protected static var __quantity:RegExp = new RegExp( "(" + __quantifiers + ")" );
		
		/**
		* 	@private
		*/
		protected static var __justquantity:RegExp = new RegExp( "^(" + __quantifiers + ")$" );
	}
}