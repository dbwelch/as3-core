package java.util.regex
{
	import org.w3c.dom.Comment;	
	import org.w3c.dom.Node;
	
	import com.ffsys.w3c.dom.ElementImpl;
	
	/**
	* 	Represents a collection of patterns.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/
	dynamic public class PatternList extends ElementImpl
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
		* 	The name for a modifier.
		*/
		public static const MODIFIER_NAME:String = "modifier";
		
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
		*/
		internal var _regex:RegExp;
		
		private var _comment:String;
		
		/**
		* 	Creates a <code>PatternList</code> instance.
		*/
		public function PatternList()
		{
			super();
		}
		
		/**
		* 	A comment about this pattern.
		*/
		public function get comment():String
		{
			//TODO
			return _comment;
		}
		
		public function set comment( value:String ):void
		{
			_comment = value;
			
			trace("[SET COMMENT] PatternList::set comment()", value, ownerDocument );
			
			if( ownerDocument )
			{
				var c:Comment = ownerDocument.createComment( value );
					
				trace("PatternList::set comment()", "CREATING COMMENT WITH VALUE: ",
					value, c, c.data );
				
				//TODO: update any existing comment node
				appendChild( c );
			}
		}
		
		/**
		* 	An owner for this pattern.
		*/
		public function get owner():PatternList
		{
			return parentNode as PatternList;
		}
		
		/**
		* 	The type of this pattern.
		*/
		public function get patternType():uint
		{
			return NaN;
		}
		
		/**
		* 	Retrieves the owner document as a pattern
		* 	document.
		*/
		public function get patternDocument():PatternDocument
		{
			return ownerDocument as PatternDocument;
		}
		
		/**
		* 	@private
		*/
		internal function createPattern(
			pattern:String = null,
			comment:String = null ):Pattern
		{
			var ptn:Pattern = null;
			
			if( patternDocument )
			{
				ptn = patternDocument.createPattern(
					pattern, comment );
			}
			return ptn;
		}
		
		/**
		* 	@private
		*/
		internal function internalCreateGroupPattern(
			comment:String = null ):Pattern
		{
			var ptn:Pattern = null;
			
			if( patternDocument )
			{
				ptn = patternDocument.createPattern(
					null, comment );
				ptn.setPatternType( Pattern.GROUP_TYPE );
			}
			return ptn;
		}		
		
		/**
		* 	Determines whether this pattern
		* 	has any patterns.
		*/
		public function get empty():Boolean
		{
			return childNodes.length == 0;
		}
		
		/**
		* 	Determines whether this pattern is a rule
		*	
		* 	A rule is a pattern at the root of a
		* 	pattern hierarchy.
		*/
		public function get rule():Boolean
		{
			return ( this is Rule );
		}
		
		/**
		* 	The first child that is a pattern.
		*/
		public function get firstPatternChild():Pattern
		{
			return firstElementChild as Pattern;
		}

		/**
		* 	The last child that is a pattern.
		*/
		public function get lastPatternChild():Pattern
		{
			return lastElementChild as Pattern;
		}

		/**
		* 	The previous sibling that is a pattern.
		*/
		public function get previousPatternSibling():Pattern
		{
			return previousElementSibling as Pattern;
		}

		/**
		* 	The next sibling that is a pattern.
		*/
		public function get nextPatternSibling():Pattern
		{
			return nextElementSibling as Pattern;
		}

		/**
		* 	The number of child nodes that are patterns.
		*/
		public function get childPatternCount():uint
		{
			var c:uint = 0;
			var node:Node = null;
			for each( node in childNodes )
			{
				if( node is Pattern )
				{
					c++;
				}
			}
			return c;
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
		public function toPatternLiteral():String
		{
			return null;
		}
		
		/**
		* 	Retrieves a string representation of this pattern.
		* 
		* 	@return A string representation of this pattern.
		*/
		override public function toString():String
		{
			return super.toString();
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