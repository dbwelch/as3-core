/**
*	<p>The reference implementation for the pattern library specification.</p>
*/
package java.util.regex
{
	import org.w3c.dom.Element;
	import org.w3c.dom.Node;
	
	import javax.xml.namespace.QualifiedName;
	
	/**
	* 	Represents a regular expression pattern.
	* 
	* 	This implementation allows for matching against complex
	* 	object structures using a regular expression.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/
	dynamic public class Pattern extends PatternList
	{	
		/**
		* 	The bean name for a pattern.
		*/
		public static const NAME:String = "ptn";
		
		/*
		*	TYPE CONSTANTS (uint)
		*/
		
		/**
		* 	Represents a rule list type.
		*/
		public static const RULE_LIST_TYPE:uint = 1;
		
		/**
		* 	Represents a #ptnlib:term:rule; type.
		*/
		public static const RULE_TYPE:uint = 2;
		
		/**
		* 	Represents a #ptnlib:term:group; type.
		*/
		public static const GROUP_TYPE:uint = 3;
		
		/**
		* 	Represents a #ptnlib:term:range; type.
		*/
		public static const RANGE_TYPE:uint = 4;
		
		/**
		* 	Represents a #ptnlib:term:character:class; type.
		*/
		public static const CHARACTER_CLASS_TYPE:uint = 5;
		
		/**
		* 	Represents a #ptnlib:term:quantifier type.
		*/
		public static const QUANTIFIER_TYPE:uint = 6;
		
		/**
		* 	Represents character data type.
		*/
		public static const DATA_TYPE:uint = 7;
		
		/**
		* 	Represents a #ptnlib:term:modifier; type.
		*/
		public static const MODIFIER_TYPE:uint = 8;
		
		/**
		* 	Represents any other #ptnlib:term:meta:character; or #ptnlib:term:meta:sequence; type.
		*/
		public static const META_TYPE:uint = 9;
		
		/**
		* 	The attribute name used to indicate
		* 	if a range is negated.
		*/
		public static const NEGATED_ATTR_NAME:String = "negated";
		
		/**
		* 	The attribute name used to indicate
		* 	if a quantifier is lazy.
		*/
		public static const LAZY_ATTR_NAME:String = "lazy";
		
		/**
		* 	The attribute name used to indicate
		* 	if a group has a field.
		*/
		public static const FIELD_ATTR_NAME:String = "field";
		
		/**
		* 	The attribute name used to indicate
		* 	an occurence count.
		*/
		public static const COUNT_ATTR_NAME:String = "count";
		
		/**
		* 	The attribute name used to indicate
		* 	a minimum occurence.
		*/
		public static const MIN_ATTR_NAME:String = "min";
		
		/**
		* 	The attribute name used to indicate
		* 	a maximum occurence.
		*/
		public static const MAX_ATTR_NAME:String = "max";
		
		/*
		*	NAMESPACE CONSTANTS (String/Namespace)
		*/
		
		/**
		* 	The pattern namespace prefix.
		*/
		public static const NAMESPACE_PREFIX:String = 
			"ptn";
			
		/**
		* 	The pattern namespace <code>URI</code>.
		*/
		public static const NAMESPACE_URI:String = 
			"http://ns.wav.co.uk/ptn";
		
		/**
		* 	The namespace used when creating <code>XML</code>
		* 	representations of a pattern.
		*/
		public static const NAMESPACE:Namespace = new Namespace(
			NAMESPACE_PREFIX,
			NAMESPACE_URI );
			
		/*
		*	META SEQUENCE CONSTANTS (String)
		*/
						
		/**
		* 	@private
		* 
		* 	A meta character that indicates
		* 	the start position or negation
		* 	when specified as the first character
		* 	in a character class.
		*/
		public static const CARET:String = "^";
		
		/**
		* 	@private
		* 
		* 	Represents a wildcard character.
		*/
		public static const DOT:String = ".";
		
		/**
		* 	@private
		* 
		* 	A quantifier character that indicates
		* 	zero or more occurences.
		*/
		public static const ASTERISK:String = "*";
		
		/**
		* 	@private
		* 
		* 	A quantifier character that indicates one
		* 	or more occurences.
		*/
		public static const PLUS:String = "+";
		
		/**
		* 	@private
		* 
		* 	A quantifier character that indicates zero or one occurence
		* 	or as a greedy behaviour modifier.
		*/
		public static const QUESTION_MARK:String = "?";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates alternation.
		*/
		public static const PIPE:String = "|";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates a character range.
		* 
		* 	Only applicable within character classes.
		*/
		public static const HYPHEN:String = "-";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end position.
		*/
		public static const DOLLAR:String = "$";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the start of a group.
		*/
		public static const LPAREN:String = "(";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end of a group.
		*/
		public static const RPAREN:String = ")";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the start of a
		* 	character class.
		*/
		public static const LBRACKET:String = "[";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end of a
		* 	character class.
		*/
		public static const RBRACKET:String = "]";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the start
		* 	of a qualifier range.
		*/
		public static const LBRACE:String = "{";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end
		* 	of a qualifier range.
		*/
		public static const RBRACE:String = "}";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the start
		* 	of a name for a named group.
		*/
		public static const LESS_THAN:String = "<";
		
		/**
		* 	@private
		* 
		* 	A meta character that indicates the end
		* 	of a name for a named group.
		*/
		public static const GREATER_THAN:String = ">";
		
		/**
		* 	@private
		* 
		*	The meta sequence representing a
		* 	positive lookahead group.
		*/
		public static const POSITIVE_LOOKAHEAD_SEQUENCE:String = "?=";
		
		/**
		* 	@private
		* 
		*	The meta sequence representing a
		* 	negative lookahead group.
		*/
		public static const NEGATIVE_LOOKAHEAD_SEQUENCE:String = "?!";
		
		/**
		* 	@private
		* 
		*	The meta sequence representing a
		* 	non-capturing group.
		*/
		public static const NON_CAPTURING_SEQUENCE:String = "?:";
		
		/**
		* 	@private
		* 
		*	The meta sequence representing a
		* 	named group.
		*/
		public static const NAMED_GROUP_SEQUENCE:String = "?P";
		
		/*
		*	FLAG CONSTANTS (char)
		*/
		
		/**
		* 	@private
		* 
		*	Represents the <code>g</code> flag, the
		* 	<code>global</code> property.
		*/
		public static const GLOBAL_FLAG:String = "g";
		
		/**
		* 	@private
		* 
		*	Represents the <code>s</code> flag, the
		* 	<code>dotall</code> property.
		*/
		public static const DOTALL_FLAG:String = "s";
		
		/**
		* 	@private
		* 
		*	Represents the <code>x</code> flag, the
		* 	<code>extended</code> property.
		*/
		public static const EXTENDED_FLAG:String = "x";
		
		/**
		* 	@private
		* 
		*	Represents the <code>m</code> flag, the
		* 	<code>multiline</code> property.
		*/
		public static const MULTILINE_FLAG:String = "m";
		
		/**
		* 	@private
		* 
		*	Represents the <code>i</code> flag, the
		* 	<code>ignoreCase</code> property.
		*/
		public static const IGNORE_CASE_FLAG:String = "i";
		
		private var _position:uint = 0;
		private var _field:String;
		private var _open:Boolean = false;
		
		/**
		* 	@private
		*/
		protected var _compiled:String;
		
		/**
		* 	@private
		*/
 		protected var _source:* = NaN;
		
		/**
		* 	@private
		* 
		* 	A minimum number of occurences for this pattern.
		*/
		internal var _min:Number = -1;
		
		/**
		* 	@private
		* 
		* 	A maximum number of occurences for this pattern.
		*/
		internal var _max:Number = -1;
		
		/**
		* 	@private
		*/
		internal var _patternType:uint = NaN;
		
		/**
		* 	Creates a <code>Pattern</code> instance.
		* 
		* 	@param src The source for the pattern.
		*/
		public function Pattern(
			src:* = null )
		{
			super();
			if( src != null )
			{
				this.source = src;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get patternType():uint
		{
			return _patternType;
		}
		
		/**
		* 	@private
		*/
		internal function setPatternType( type:uint ):void
		{
			_patternType = type;
		}
		
		/**
		* 	@private
		*/
		override public function get nodeName():String
		{
			//TODO: mutate localName on pattern type
			var nm:String = super.nodeName;
			if( nm == null )
			{			
				//default node name
				nm = Pattern.NAME;
			}
			
			if( !isNaN( _patternType ) )
			{
				if( _patternType == GROUP_TYPE )
				{
					nm = GROUP_NAME;
				}else if( _patternType == RANGE_TYPE )
				{
					nm = RANGE_NAME;
				}else if( _patternType == QUANTIFIER_TYPE )
				{
					nm = QUANTIFIER_NAME;
				}else if( _patternType == MODIFIER_TYPE )
				{
					nm = MODIFIER_NAME;
				}else if( _patternType == DATA_TYPE )
				{
					nm = DATA_NAME;
				}else if( _patternType == META_TYPE )
				{
					nm = META_NAME;				
				}
			}
			
			trace("[GROUP] Pattern::get nodeName()", this.group, _source );
			
			if( this.group )
			{
				nm = GROUP_NAME;
			}
			
			if( nm.indexOf( QualifiedName.DELIMITER ) == -1 )
			{
				//convert to a fully qualified name
				nm = QualifiedName.toName(
					Pattern.NAMESPACE_PREFIX,
					nm );			
			}
			
			return nm;
		}
		
		/**
		* 	The minimum number of occurences
		* 	for this pattern.
		*/
		public function get minimum():uint
		{
			if( quantifier )
			{
				if( _min == -1 )
				{
					_min = getOccurences().min;
				}
			}else
			{
				if( _min == -1 && _max == -1 )
				{
					_min = 1;
					_max = 1;
				}
				
				if( nextPatternSibling != null
					&& nextPatternSibling.quantifier )
				{
					_min = nextPatternSibling.minimum;
				}
			}
			return _min;
		}
		
		/**
		* 	The maximum number of occurences
		* 	for this pattern.
		*/
		public function get maximum():uint
		{
			if( quantifier )
			{
				if( _max == -1 )
				{
					_max = getOccurences().max;
				}
			}else
			{
				if( _min == -1 && _max == -1 )
				{
					_min = 1;
					_max = 1;
				}
				if( nextPatternSibling != null
					&& nextPatternSibling.quantifier )
				{
					_max = nextPatternSibling.maximum;
				}
			}		
			return _max;
		}
		
		/**
		*	Gets the qualifier for a group.
		* 
		* 	A qualifier for a group is a meta
		* 	character sequence that qualifies the 
		* 	group behaviour.
		* 
		* 	Valid values are the non-capturing qualifier (<code>?:</code>),
		* 	the positive lookahead qualifier (<code>?=</code>), the negative
		* 	lookahead qualifier (<code>?!</code>) and the named group qualifier
		* 	(<code>?P</code>).
		*/
		public function get qualifier():String
		{
			if ( source == POSITIVE_LOOKAHEAD_SEQUENCE
				|| source == NEGATIVE_LOOKAHEAD_SEQUENCE
				|| source == NON_CAPTURING_SEQUENCE
				|| source == NAMED_GROUP_SEQUENCE
				|| namedGroup )
			{
				return source;
			}
			return null;
		}
		
		/**
		* 	Determines whether this pattern is a named
		* 	group. A named group is a group that has been
		*	assigned a property name using the regular expression
		* 	syntax <code>(?P&lt;property&gt;)</code>.
		*/
		public function get namedGroup():Boolean
		{
			var src:String = toString();
			var namedStart:int = src.indexOf( LESS_THAN );
			var namedEnd:int = src.indexOf( GREATER_THAN );
			
			//TODO: test previous sibling is '?P'
			
			return ( namedStart == 0 && namedEnd == ( src.length - 1 ) );
		}
		
		/**
		* 	Determines whether this pattern
		* 	is quantifier meta data.
		* 
		* 	A quantifier is deemed to be a sequence
		* 	that affects the number of occurences for
		* 	a previous pattern.
		* 
		* 	@return Whether this pattern is a
		* 	quantifier.
		*/
		public function get quantifier():Boolean
		{
			return ( source != null
				&& ( __justquantity.test( source )
				|| quantifierRange ) );
		}
		
		/**
		* 	Determines whether this pattern is a quantifier
		* 	range, <code>{1,2}</code>.
		*/
		public function get quantifierRange():Boolean
		{
			return __quantifierRange.test( this.source );
		}		
		
		/**
		*	Determines whether a capture group
		* 	has a qualifier specified.
		*/
		
		/*
		public function get qualified():Boolean
		{
			if( group )
			{
				if( patterns.length > 1
					&& patterns[ 0 ].toString() == LPAREN
					&& patterns[ 1 ] is Pattern )
				{
					return ( patterns[ 1 ].qualifier != null );
				}
			}
			return false;
		}
		*/
		
		/**
		* 	Determines whether this is a lazy quantifier.
		* 
		* 	These are the <code>&#43;</code> and <code>&#42;</code>
		* 	operators whose behaviour has been modified from the
		* 	default greedy behaviour using the <code>?</code> meta
		* 	character.
		* 
		* 	Valid examples are <code>&#43;?</code> and <code>&#42;?</code>.
		* 
		* 	This lazy behaviour modifier only applies when a quantifier
		* 	allows for unlimited matches (only the &#42; and &#43; quantifiers)
		* 	and applying this to another quantifier is invalid.
		* 
		* 	For example, <code>??</code> and <code>{10,20}?</code> are meaningless because
		* 	both statements declare a fixed number of maximum possible matches,
		* 	one and twenty respectively.
		* 
		* 	Finally you can consider <code>{10,}?</code> as a valid use of the
		* 	lazy modifier as the quantifier range allows for unlimited maximum
		* 	matches.
		*/
		public function get lazy():Boolean
		{
			if( nextPatternSibling != null
				&& nextPatternSibling.quantifier )
			{
				return nextPatternSibling.lazy;
			}
			return quantifier
				&& source != QUESTION_MARK
				&& ( ( source.indexOf( QUESTION_MARK ) == source.length - 1 )
				|| ( nextPatternSibling != null
					&& nextPatternSibling.source == QUESTION_MARK ) );
		}
		
		/**
		* 	Determines whether this pattern
		* 	represents a named capture group
		* 	declaration, <code>?P</code>.
		*/
		public function get named():Boolean
		{
			return source == NAMED_GROUP_SEQUENCE;
		}
		
		/**
		* 	Determines whether this pattern represents a
		* 	meta character sequence.
		*/
		public function get meta():Boolean
		{
			return isMetaSequence( this.source ) || shortcut;
		}
		
		/**
		* 	Determines whether this is a character match
		* 	data pattern.
		* 
		* 	A character match data pattern does not contain groups
		* 	or character classes buy may contain quantifiers that
		* 	apply to a preceding <em>character</em>.
		* 
		* 	This implies that quantifiers in data patterns may
		* 	be intermingled with other data elements and appear
		* 	at the end (apply to the last character), but may not
		* 	appear at the beginning of a data pattern
		* 	as the quantifier should be applied to the
		* 	preceding pattern.
		*/
		public function get data():Boolean
		{
			return !rule && !meta;
		}
		
		/**
		* 	The source for this pattern.
		*/
		public function get source():*
		{
			return _source;
		}
		
		public function set source( value:* ):void
		{
			extractSource( value );
			_source = value;
			
			//update the pattern type
			if( group )
			{
				_patternType = GROUP_TYPE;
			}else if( range )
			{
				_patternType = RANGE_TYPE;
			}else if( quantifier )
			{
				_patternType = QUANTIFIER_TYPE;
			}else if( meta )
			{
				_patternType = META_TYPE;
			}
		}
		
		private function extractSource( value:* ):String
		{
			if( value is RegExp )
			{
				value = RegExp( value ).source;
				_regex = value as RegExp;
				//trace("Pattern::set source()", "[EXTRACTED REGEX SOURCE]", value );
			}

			return "" + value;
		}
		
		/**
		* 	The target property name when matching
		* 	pattern parts against complex objects.
		*/
		public function get field():String
		{
			return _field;
		}
		
		public function set field( value:String ):void
		{
			_field = value;
		}
		
		/**
		* 	Determines whether this pattern
		* 	should match from the beginning
		* 	of a target being matched against.
		* 
		* 	Equivalent to a <code>^</code> at the beginning
		* 	of a regular expression.
		*/
		public function get begins():Boolean
		{
			return 	( rule && !empty && firstPatternChild.source == CARET )
				||	( owner != null
					&& owner.rule
					&& source == CARET
					&& childIndex == 0 );
		}
		
		/**
		* 	Determines whether this pattern
		* 	should match until the end
		*	of a target being matched against.
		* 
		* 	Equivalent to a <code>$</code> at the end
		* 	of a regular expression.
		*/
		public function get ends():Boolean
		{
			return 	( rule && !empty && lastPatternChild.source == DOLLAR )
				||	( owner != null
					&& owner.rule
					&& source == DOLLAR
					&& ( childIndex == owner.childNodes.length - 1 ) );
		}
		
		/**
		* 	@private
		*/
		override public function clear():void
		{
			super.clear();
			_source = "";
			_compiled =  null;
		}
		
		/**
		* 	Determines whether this pattern is grouping.
		* 
		* 	This will return <code>true</code> for groups
		* 	<code>()</code>, character classes <code>[]</code>,
		* 	quantifier ranges <code>{}</code> and group names
		* 	<code>&lt;&gt;</code>.
		* 
		* 	Comparison is performed on the first child and does not
		* 	imply that the grouping has been correctly closed.
		*/
		public function get grouping():Boolean
		{
			return length > 0
				&& firstPatternChild != null
				&& __group.test( "" + firstPatternChild.source );
		}
		
		/**
		* 	Creates a matcher that will match the given
		* 	input against this pattern.
		* 
		* 	@param input The input to use for matching.
		* 
		* 	@return A new matcher for this pattern.
		*/
		public function matcher( input:* ):Matcher
		{
			return new Matcher( this, input );
		}
		
		/**
		* 	Returns the number of capturing groups in this pattern.
		* 
		* 	Group zero denotes the entire pattern by convention.
		* 	It is not included in this count.
		* 
		* 	Any non-negative integer smaller than or equal to the
		* 	value returned by this method is guaranteed to be a
		* 	valid group index for this pattern.
		* 
		* 	@return The number of capturing groups in this pattern.
		*/
		public function groupCount():int
		{
			//TODO
			return 0;
		}
		
		/**
		* 	Determines whether this pattern is a group.
		*/
		public function get group():Boolean
		{
			if( _patternType === GROUP_TYPE )
			{
				return true;
			}
			
			return _source === LPAREN ||
				( this.grouping
				&& ( firstPatternChild.toString() == LPAREN ) );
		}
		
		/**
		* 	Retrieves all escape characters (<code>\</code>)
		* 	at the end of the source of this pattern.
		*/
		public function get escapes():String
		{
			var re:RegExp = /(\\+)$/;
			if( re.test( source ) )
			{
				var results:Array = re.exec( source );
				if( results != null && results[ 1 ] is String )
				{
					return results[ 1 ] as String;
				}
			}
			return null;
		}
		
		/**
		* 	Determines whether this pattern is an escape
		* 	sequence and would cancel the special meaning
		* 	of any subsequent pattern.
		*/
		public function get cancels():Boolean
		{
			return escapes != null
				&& ( escapes.length == 1
					|| escapes.length % 2 != 0 );
		}
		
		/**
		* 	Determines whether this pattern has any special
		* 	meaning cancelled by a preceding escape sequence.
		*/
		public function get cancelled():Boolean
		{
			if( previousPatternSibling != null )
			{
				if( previousPatternSibling.cancels )
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		* 	Determines whether this pattern represents
		* 	an escaped character class shortcut.
		*/
		public function get shortcut():Boolean
		{
			return isShortCut( this.source );
		}
		
		/**
		* 	Determines whether this pattern is a range
		* 	(character class), <code>[0-9]</code>.
		*/
		public function get range():Boolean
		{
			return ( source != null && source == LBRACKET )
				|| this.grouping && ( firstPatternChild.toString() == LBRACKET );
		}
		
		/**
		* 	Determines whether this pattern is a character
		* 	range and is negated, <code>[^0-9]</code>.
		*/
		public function get negated():Boolean
		{
			return range
				&& firstPatternChild != null
				&& firstPatternChild.nextPatternSibling != null
				&& firstPatternChild.nextPatternSibling.source == CARET;
		}
		
		/**
		* 	A regular expression representation
		* 	of this pattern based.
		*/
		public function get regex():RegExp
		{
			if( _regex == null && _source != null )
			{
				_regex = new RegExp( "" + _source );
			}
			return _regex;
		}
		
		/**
		* 	@private
		*/
		override public function toPatternLiteral():String
		{
			return NAME + ":" + DELIMITER + this.source + DELIMITER;
		}
		
		/*
		*	GROUPING INTERNALS
		*/
		
		/**
		* 	@private
		* 	
		* 	Determines whether this pattern is
		* 	currently open.
		* 
		* 	Used during the process of building
		* 	pattern representations from string
		* 	representations.
		*/
		internal function get open():Boolean
		{
			return _open;
		}
		
		/**
		* 	@private
		*/
		internal function setOpen( value:Boolean ):void
		{
			_open = value;
		}
		
		/**
		* 	@private
		* 
		* 	Determines whether this pattern
		* 	opens a grouping.
		* 
		* 	@return Whether this pattern opens a grouping.
		*/
		internal function opens():Boolean
		{
			var valid:Boolean = (
				source == Pattern.LPAREN
				|| source == Pattern.LBRACKET
				|| source == Pattern.LBRACE
				|| source == Pattern.LESS_THAN );	
			if( valid )
			{
				_open = true;
			}
			return valid;
		}
		
		/**
		* 	@private
		* 	
		* 	Determines whether the this pattern
		* 	closes a grouping.
		* 
		* 	@return Whether this pattern closes a grouping.
		*/
		internal function closes():Boolean
		{
			var valid:Boolean = (
				source == Pattern.RPAREN
				|| source == Pattern.RBRACKET
				|| source == Pattern.RBRACE
				|| source == Pattern.GREATER_THAN );			
			if( valid && _open )
			{
				_open = false;
			}
			return valid;
		}
		
		/*
		*	INTERNAL QUANTIFIER AMOUNT CALCULATION
		*/		
		
		/**
		* 	@private
		*/
		internal function getQuantifierRangeOccurences( tmp:String ):Object
		{
			var output:Object = new Object();
			output.min = _min;
			output.max = _max;
			tmp = tmp.replace( /\{/, "" );
			tmp = tmp.replace( /\}/, "" );
			var parts:Array = tmp.split( "," );
			if( output.min == -1 && parts.length >= 1 )
			{
				output.min = parseInt( parts[ 0 ] );
				if( parts.length == 1 )
				{
					output.max = output.min;
				}
			}
			if( output.max == -1 
				&& parts.length == 2 )
			{
				if( parts[ 1 ] == "" )
				{
					output.max = uint.MAX_VALUE;
				}else
				{
					output.max = parseInt( parts[ 1 ] );
				}
			}
			return output;
		}
		
		/**
		* 	@private
		*/
		internal function getOccurences():Object
		{
			var floor:int = 0;
			var ceiling:int = uint.MAX_VALUE;
			var output:Object = new Object();
			output.min = _min;
			output.max = _max;
			var tmp:String = source.substr();
			
			//remove any lazy modifiers associated
			//with another quantifier before calculation
			if( tmp != QUESTION_MARK
				&& tmp.indexOf( QUESTION_MARK ) > -1 )
			{
				tmp = tmp.replace( /[?]+$/, "" );
			}
			
			if( quantifierRange && _min == -1 && _max == -1 )
			{
				output = getQuantifierRangeOccurences( tmp );
			}
			
			if( output.min == -1
				&& output.max == -1 )
			{
				var defined:Boolean = _min > 0 && _max > 0;
				if( !defined && quantifier )
				{
					switch( tmp )
					{
						case ASTERISK:
							output.min = floor;
							output.max = ceiling;
							break;
						case PLUS:
							output.min = 1;
							output.max = ceiling;
							break;
						case QUESTION_MARK:
							output.min = floor;
							output.max = 1;
							break;
					}
				}
			}
			_min = output.min;
			_max = output.max;
			return output;
		}		
		
		/*
		*	INTERNALS
		*/
		
		protected function notifyChildPatternsComplete():void
		{
			if( hasChildNodes() )
			{
				var n:Node = null;
				var p:Pattern = null;
				for( var i:int  = 0;i < childNodes.length;i++)
				{
					n = childNodes.item( i );
					if( n is Pattern )
					{
						p = n as Pattern;
						p.completed();
					}
				}
			}			
		}
		
		/**
		* 	@private
		* 
		* 	Invoked once a compilation pass has completed
		* 	on a rule.
		* 
		* 	This allows the rule to inspect the DOM structure
		* 	and manipulate the DOM values to correctly reflect
		* 	the compiled pattern data in a compact manner.
		*/
		internal function completed():void
		{
			trace("[COMPILE COMPLETE PATTERN] Pattern::completed()", this, field );			

			if( _source != null
				&& _source != "" )
			{
				insertBefore( ownerDocument.createCDATASection( _source ), firstChild );
			}
		
			notifyChildPatternsComplete();
			
			if( this.group )
			{
				if( this.field != null )
				{
					setAttributeNS(
						Pattern.NAMESPACE_URI,
							QualifiedName.toName(
								Pattern.NAMESPACE_PREFIX,
								FIELD_ATTR_NAME ),
						this.field );	
				}
				
				if( firstPatternChild != null
					&& firstPatternChild.source == LPAREN )
				{
					removeChild( firstPatternChild );
				}
				
				if( lastPatternChild != null
					&& lastPatternChild.source == RPAREN )
				{
					removeChild( lastPatternChild );
				}
				
			}else if( this.range )
			{
				setAttributeNS(
					Pattern.NAMESPACE_URI,
						QualifiedName.toName(
							Pattern.NAMESPACE_PREFIX,
							NEGATED_ATTR_NAME ),
					"" + this.negated );
					
				if( firstPatternChild != null
					&& firstPatternChild.source == LBRACKET )
				{
					removeChild( firstPatternChild );
				}
				
				if( lastPatternChild != null
					&& lastPatternChild.source == RBRACKET )
				{
					removeChild( lastPatternChild );
				}
			}
			
			if( !quantifier
				&& nextPatternSibling != null
				&& nextPatternSibling.quantifier )
			{
				setAttributeNS(
					Pattern.NAMESPACE_URI,
						QualifiedName.toName(
							Pattern.NAMESPACE_PREFIX,
							LAZY_ATTR_NAME ),
					"" + this.lazy );
				
				//single quantifier occurence amount
				if( this.minimum > -1
					&& this.maximum > -1
					&& this.minimum == this.maximum )
				{
					setAttributeNS(
						Pattern.NAMESPACE_URI,
							QualifiedName.toName(
								Pattern.NAMESPACE_PREFIX,
								COUNT_ATTR_NAME ),
						"" + this.minimum );					
				}else
				{
					if( this.minimum > -1 )
					{
						setAttributeNS(
							Pattern.NAMESPACE_URI,
								QualifiedName.toName(
									Pattern.NAMESPACE_PREFIX,
									MIN_ATTR_NAME ),
							"" + this.minimum );
					}
					if( this.maximum > -1 )
					{
						setAttributeNS(
							Pattern.NAMESPACE_URI,
								QualifiedName.toName(
									Pattern.NAMESPACE_PREFIX,
									MAX_ATTR_NAME ),
							"" + this.maximum );
					}
				}
				
				//reference the quantifier as an attribute
				setAttributeNS(
					Pattern.NAMESPACE_URI,
						QualifiedName.toName(
							Pattern.NAMESPACE_PREFIX,
							"quantifier" ),
					"" + nextPatternSibling.source );		
				
				//remove the quantifier
				parentNode.removeChild( nextPatternSibling );
			}
		}
		
		/**
		* 	@private
		* 	
		* 	Determines whether a string is considered
		* 	to be a meta character or meta sequence.
		* 
		* 	@param char The string to test against.
		* 
		* 	@return Whether the value is a meta character
		* 	or meta sequence.
		*/
		protected function isMetaSequence( char:String ):Boolean
		{
			return char == POSITIVE_LOOKAHEAD_SEQUENCE
				|| char == NEGATIVE_LOOKAHEAD_SEQUENCE
				|| char == NON_CAPTURING_SEQUENCE
				|| char == NAMED_GROUP_SEQUENCE	
				|| char == CARET
				|| char == ASTERISK
				|| char == PLUS
				|| char == QUESTION_MARK
				|| char == DOLLAR
				|| char == PIPE
				|| char == LPAREN
				|| char == RPAREN
				|| char == LBRACE
				|| char == RBRACE
				|| char == LBRACKET
				|| char == RBRACKET
				|| char == LESS_THAN
				|| char == GREATER_THAN;			
		}
		
		/*
		*	REGEX INTERNALS
		*/
		
		/**
		* 	@private
		*/
		protected static var __group:RegExp = new RegExp(
			"^(?:"
			+ "\\" + LPAREN
			+ "|\\" + LBRACKET
			+ "|\\" + LBRACE
			+ "|\\" + LESS_THAN + ")"
		);		
	}
}