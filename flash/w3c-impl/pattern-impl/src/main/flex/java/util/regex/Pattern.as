/**
*	<p>The reference implementation for the pattern library specification.</p>
*/
package java.util.regex
{
	import org.w3c.dom.Element;
	
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
		public static const NAME:String = "pattern";
		
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
		public static const GROUP_TYPE:uint = 4;
		
		/**
		* 	Represents a #ptnlib:term:range; type.
		*/
		public static const RANGE_TYPE:uint = 8;
		
		/**
		* 	Represents a #ptnlib:term:character:class; type.
		*/
		public static const CHARACTER_CLASS_TYPE:uint = 16;
		
		/**
		* 	Represents a #ptnlib:term:quantifier type.
		*/
		public static const QUANTIFIER_TYPE:uint = 32;
		
		/**
		* 	Represents character data type.
		*/
		public static const DATA_TYPE:uint = 64;
		
		/**
		* 	Represents a #ptnlib:term:modifier; type.
		*/
		public static const MODIFIER_TYPE:uint = 128;
		
		/**
		* 	Represents any other #ptnlib:term:meta:character; or #ptnlib:term:meta:sequence; type.
		*/
		public static const META_TYPE:uint = 256;
		
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
		
		//
		private var _comment:String;
		private var _parts:Pattern;
		private var _position:uint = 0;
		private var _source:* = NaN;
		private var _field:String;
		private var _compiled:String;
		private var _open:Boolean = false;
		private var _type:uint;
		
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
		* 	Creates a <code>Pattern</code> instance.
		* 
		* 	@param source The source for the pattern.
		* 	@param compile Whether the source should
		* 	be compiled.
		*/
		public function Pattern(
			source:* = null, compile:Boolean = false )
		{
			super();
			
			/*
			if( compile === true )
			{
				this.compile( extractSource( source ) );
			}else{
				this.source = source;
			}
			*/
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
				nm = QualifiedName.toName(
					Pattern.NAMESPACE_PREFIX,
					Pattern.NAME );
			}
			
			
			/*
			var i:int = 0;
			var name:String = this.name;
			var x:XML = getXmlElement();
			
			if( !rule && !group )
			{	
				if( range || meta || data )
				{
					x = getXmlElement( null, toString() );
				}
				if( range )
				{
					x.@negated = this.negated;
				}
			}
			*/
			
			//handle the output of pattern occurences.
			//groups proxy the corresponding value
			//for any subsequent quantifier or if
			//the group is not quantified reports
			//a count of one
			
			/*
			if( !quantifier
				&& nextPatternSibling != null && nextPatternSibling.quantifier )
			{
				x.@lazy = this.lazy;
				//single quantifier occurence amount
				if( this.minimum > -1
					&& this.maximum > -1
					&& this.minimum == this.maximum )
				{
					x.@count = this.minimum;
				}else
				{
					if( this.minimum > -1 )
					{
						x.@min = this.minimum;
					}
					if( this.maximum > -1 )
					{
						x.@max = this.maximum;
					}
				}
			}
			
			if( cancelled )
			{
				x.@cancelled = cancelled;
			}
			
			//shortcut out for simple types
			if( !rule && !group )
			{	
				if( range || meta || data )
				{
					return x;
				}
			}	
			*/		
			
			//handle complex types
			
			/*
			var ptns:Vector.<Pattern> = this.patterns;
			var isGrouped:Boolean = !rule && group;
			if( isGrouped )
			{
				ptns = children.patterns;
			}
			
			if( isGrouped )
			{
				x.@qualified = this.qualified;
				if( field != null )
				{
					x.@field = this.field;
				}
			}
			
			if( rule || source == CARET || source == DOLLAR )
			{
				x.@begins = begins;
				x.@ends = ends;
			}
			*/
			
			/*
			if( ptns != null && ptns.length > 0 )
			{
				var children:XML = getXmlElement( PATTERNS );
				x.appendChild( children );
				var ptn:Pattern = null;
				var child:XML = null;
				var previous:XML = null;
				for( i = 0;i < ptns.length;i++ )
				{
					ptn = ptns[ i ];
					child = ptn.xml;
					
					//skip quantifier elements as
					//their values should be represented
					//by the preceding pattern they apply to
					if( !ptn.quantifier )
					{
						children.appendChild( child );
					}
					
					//apply the quantifier source as an
					//attribute of the preceding element
					if( ptn.quantifier
						&& previous != null )
					{
						previous.@quantifier = ptn.source;
					}
					previous = child;
				}
			}			
			*/
			
			return nm;
		}
		
		/**
		* 	A comment about this pattern.
		*/
		public function get comment():String
		{
			return _comment;
		}
		
		public function set comment( value:String ):void
		{
			_comment = value;
		}
		
		/**
		* 	Specifies whether the <code>g</code> flag is set.
		* 
		* 	Specifies whether to use global matching
		* 	for the regular expression.
		*/
		public function get global():Boolean
		{
			return this.regex.global;
		}
		
		/**
		* 	Specifies whether the <code>s</code> flag is set.
		* 	
		* 	When present indicates that the dot character (<code>.</code>)
		* 	in a regular expression pattern matches new-line characters.
		*/
		public function get dotall():Boolean
		{
			return this.regex.dotall;
		}
		
		/**
		* 	Specifies whether the <code>x</code> flag is set.
		* 
		* 	When present the regular expression will use extended mode.
		*/
		public function get extended():Boolean
		{
			return this.regex.extended;
		}
		
		/**
		* 	Specifies whether the <code>m</code> flag is set.
		* 	
		* 	If it is set, the caret (<code>^</code>) and dollar
		* 	sign (<code>$</code>) in a regular expression match
		* 	before and after new lines.
		*/
		public function get multiline():Boolean
		{
			return this.regex.multiline;
		}
		
		/**
		* 	Specifies whether the <code>i</code> flag is set.
		* 
		* 	When present the regular expression
		* 	ignores case sensitivity.
		*/
		public function get ignoreCase():Boolean
		{
			return this.regex.ignoreCase;
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
			if( _source == null
				&& patterns != null )
			{
				_source = patterns.join( "," );
			}
			return _source;
		}
		
		public function set source( value:* ):void
		{
			extractSource( value );
			_source = value;
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
		* 	@private
		*/
		override public function finalized():void
		{
			super.finalized();
			
			trace("Pattern::finalized()", this, this.source );
			
			if( range )
			{
				setAttribute( "ptn:negated", "" + this.negated );
			}
			
			/*
			var src:Element = ownerDocument.createElementNS(
				NAMESPACE_URI, QualifiedName.toName(
					NAMESPACE_PREFIX, SOURCE ) );
					
			trace("[GOT SOURCE ELEMENT] Pattern::extractSource()", src );
			
			appendChild( src );
			
			if( rule )
			{			
				//appendChild( getXmlElement( SOURCE, this.source ) );
			}else
			{
				//appendChild( getXmlElement( SOURCE, toString() ) );
			}	
			*/		
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
		* 	All pattern parts as a flat list.
		*/
		public function get parts():Pattern
		{
			if( _parts == null )
			{
				_parts = createPattern();
				_parts.name = PARTS;
			}
			return _parts;
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
					&& index == 0 );
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
					&& ( index == owner.patterns.length - 1 ) );
		}
		
		/**
		* 	@private
		*/
		override public function clear():void
		{
			super.clear();
			_source = "";
			_compiled =  null;
			_parts = null;
		}
		
		/**
		* 	@private
		*/
		internal function match(
			pattern:Pattern, value:*, position:uint = 0 ):PatternMatch
		{
			var match:PatternMatch = new PatternMatch( position, pattern, value );
			var re:RegExp = pattern.regex;
			
			//compare against the source of other
			//regular expressions
			if( value is RegExp )
			{
				value = RegExp( value ).source;
			}
			
			//non-string primitive value
			//coerce to a string for comparison
			if( value is Number || value is Boolean )
			{
				//trace("[PRIMITIVE TEST] Pattern::test()", re, "" + value, re.test( "" + value ) );
				value = "" + value;
			}
			
			match.result = re.test( value as String );
			
			trace("[MATCH] Pattern::test()",
				value, re, re.test( value as String ), match.result );
			
			//add the match result to this pattern
			this[ position ] = match;
			return match;
		}
		
		/**
		* 	Tests whether the pattern matches
		* 	a value.
		* 
		* 	@param value The value to compare this pattern against.
		* 
		* 	@return Whether the pattern matches the value.
		*/
		override public function test( value:* ):Boolean
		{
			var matched:PatternMatch = null;
			
			//simple type so treat as a
			//single length match
			if( value is RegExp
				|| value is String
				|| value is uint
				|| value is int
				|| value is Number
				|| value is Boolean )
			{
				matched = match( this, value );
			//check for list/property matching
			}else if( value is Object )
			{
				return testObject( value as Object );
			}
			return matched.result;
		}
		
		/**
		* 	Validates a target object comparing the named
		* 	groups within this pattern against the properties
		* 	of the target object.
		* 
		* 	@param target The target object to validate.
		* 
		* 	@return Whether this pattern matched the target
		* 	object structure.
		*/
		public function validate( target:Object ):Boolean
		{
			var result:Boolean = false;
			if( target != null )
			{
				//TODO
			}
			return result;
		}
		
		/**
		* 	Performs matching against an array or vector.
		* 
		* 	@param target The target to match this pattern against.
		* 
		* 	@throws ArgumentError If the supplied target is not
		* 	an <code>Array</code> or <code>Vector</code>.
		* 
		* 	@return Whether the <code>target</code> list
		* 	matches this pattern.
		*/
		public function list( target:Object ):Boolean
		{
			if( !( ( target is Array ) || target is Vector ) )
			{
				throw new ArgumentError(
					"You must specify an array or vector when"
					+ " attempting to match a pattern against a list." );
			}
			//TODO
			return false;
		}
		
		/**
		* 	@private
		*/
		private function testObject( value:Object ):Boolean
		{
			//got a collection - should test against
			//the collection entries
			if( value is Array )
			{
				return compareList( value as Array );
			}else if( value is Vector )
			{
				return compareList( value as Vector );
			//non-collection object				
			}else if( value is Object )
			{
				return validate( value );
			}
			return false;
		}
		
		/**
		* 	@private
		* 
		* 	Compares a collection against the exploded
		* 	patterns.
		*/
		private function compareList( values:Object ):Boolean
		{
			//TODO: explode patterns and compare against the exploded parts
			
			//var tokens:Pattern = explode();
			
			var result:Boolean = false;
			var value:*;
			for( var i:int = 0;i < values.length;i++ )
			{
				value = values[ i ];
				result = compareObject( value );
				
				trace("Pattern::compareList()", value, result );
			}
			return result;
		}
		
		/**
		* 	@private
		*/
		private function compareObject( value:Object ):Boolean
		{
			var re:RegExp = this.regex;
			//comparing against an object property
			if( field != null && value.hasOwnProperty( field ) )
			{
				//access the underlying property and
				//coerce to a string
				value = "" + value[ field ];
			}else{
				//try to access an underlying primitive
				//value and coerce it to a string for comparison
				//when no field name is available
				value = "" + value.valueOf();
			}
			return re.test( "" + value );
		}
		
		/**
		* 	Returns a pattern that represents
		* 	the positional matches for this pattern.
		*/
		public function get positions():Pattern
		{
			return explode();
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
				&& __group.test( firstPatternChild.toString() );
		}
		
		/**
		* 	Retrieves a group pattern.
		* 
		* 	@param name A name for the group.
		* 	@param contents A pattern containing patterns
		* 	to add as the contents of the group.
		* 	@param close Whether to close the group.
		* 
		* 	@return A group pattern.
		*/
		public function getGroup(
			name:String = null,
			contents:Pattern = null,
			close:Boolean = false ):Pattern
		{
			var grp:Pattern = createPattern();
			grp.appendChild( createPattern( LPAREN ) );
			if( contents != null )
			{
				//TODO
				//grp.concat( contents );
			}
			if( close === true )
			{
				grp.appendChild( createPattern( RPAREN ) );
			}
			return grp;
		}
		
		/**
		* 	Determines whether this pattern is a group.
		*/
		public function get group():Boolean
		{
			return this.grouping && ( firstPatternChild.toString() == LPAREN );
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
		* 	@private
		*/
		override public function get children():PatternList
		{
			if( group )
			{
				var output:Pattern = createPattern();
				var ptns:Vector.<Pattern> = this.patterns;
				var ptn:Pattern = null;
				for( var i:int = 0;i < ptns.length;i++ )
				{
					ptn = ptns[ i ];
					//remove all capture group qualifiers and open and close
					//patterns to get to the child patterns
					if( ( ptn.source == LPAREN && i == 0 )
						|| ( ptn.source == RPAREN && i == ptns.length - 1 )
						|| ptn.qualifier != null )
					{
						continue;
					}
					output.appendChild( ptn );
				}
				return output;
			}
			return super.children;
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
		* 	@private
		*/
		override public function get regex():RegExp
		{
			if( _regex == null )
			{
				if( patterns.length == 0 && _source == null )
				{
					_source = patterns.join( "" );
					_regex = new RegExp( this.source );
				}else{
					_regex = new RegExp( toString() );
				}
			}			
			return super.regex;
		}
		
		/**
		* 	The type for the pattern.
		*/
		public function get type():uint
		{
			return _type;
		}
		
		/**
		* 	@private
		*/
		internal function setType( value:uint ):void
		{
			_type = value;
		}
		
		/**
		* 	@private
		*/
		override public function get name():String
		{
			var nm:String = super.name;
			if( rule )
			{
				nm = RULE;
			}
			if( nm == null )
			{
				switch( source )
				{
					case PIPE:
						nm = ALTERNATOR_NAME;
						break;
				}
				if( nm == null )
				{
					if( group )
					{
						nm = GROUP_NAME;
					}else if( range )
					{
						nm = RANGE_NAME;
					}else if( quantifier )
					{
						nm = QUANTIFIER_NAME;
					}else if( meta )
					{
						nm = META_NAME;
					}else if( data )
					{
						nm = DATA_NAME;
					}
				}
			}
			return nm == null ? PATTERN : nm;
		}
		
		/**
		* 	@private
		*/
		
		/*
		override public function get xml():XML
		{
			//TODO: stash this XML and invalidate
			
			var i:int = 0;
			var name:String = this.name;
			var x:XML = getXmlElement();
			
			if( !rule && !group )
			{	
				if( range || meta || data )
				{
					x = getXmlElement( null, toString() );
				}
				if( range )
				{
					x.@negated = this.negated;
				}
			}
			
			//handle the output of pattern occurences.
			//groups proxy the corresponding value
			//for any subsequent quantifier or if
			//the group is not quantified reports
			//a count of one
			if( !quantifier
				&& nextPatternSibling != null && nextPatternSibling.quantifier )
			{
				x.@lazy = this.lazy;
				//single quantifier occurence amount
				if( this.minimum > -1
					&& this.maximum > -1
					&& this.minimum == this.maximum )
				{
					x.@count = this.minimum;
				}else
				{
					if( this.minimum > -1 )
					{
						x.@min = this.minimum;
					}
					if( this.maximum > -1 )
					{
						x.@max = this.maximum;
					}
				}
			}
			
			if( cancelled )
			{
				x.@cancelled = cancelled;
			}
			
			//shortcut out for simple types
			if( !rule && !group )
			{	
				if( range || meta || data )
				{
					return x;
				}
			}			
			
			//handle complex types
			var ptns:Vector.<Pattern> = this.patterns;
			var isGrouped:Boolean = !rule && group;
			if( isGrouped )
			{
				ptns = children.patterns;
			}
			
			if( isGrouped )
			{
				x.@qualified = this.qualified;
				if( field != null )
				{
					x.@field = this.field;
				}
			}
			
			if( rule || source == CARET || source == DOLLAR )
			{
				x.@begins = begins;
				x.@ends = ends;
			}
			
			if( rule )
			{			
				x.appendChild( getXmlElement( SOURCE, this.source ) );
				
				if( length > 0 )
				{
					var results:XML = getXmlElement( RESULTS );
					var match:PatternMatch = null;
					for( i = 0;i < length;i++ )
					{
						match = this[ i ] as PatternMatch;
						results.appendChild( match.xml );
					}
					x.appendChild( results );
				}
			}else
			{
				x.appendChild( getXmlElement( SOURCE, toString() ) );
			}
			
			if( ptns != null && ptns.length > 0 )
			{
				var children:XML = getXmlElement( PATTERNS );
				x.appendChild( children );
				var ptn:Pattern = null;
				var child:XML = null;
				var previous:XML = null;
				for( i = 0;i < ptns.length;i++ )
				{
					ptn = ptns[ i ];
					child = ptn.xml;
					
					//skip quantifier elements as
					//their values should be represented
					//by the preceding pattern they apply to
					if( !ptn.quantifier )
					{
						children.appendChild( child );
					}
					
					//apply the quantifier source as an
					//attribute of the preceding element
					if( ptn.quantifier
						&& previous != null )
					{
						previous.@quantifier = ptn.source;
					}
					previous = child;
				}
			}
			
			return x;
		}
		*/
		
		/**
		* 	@private
		*/
		override public function toPatternLiteral():String
		{
			var prefix:String = rule ? PATTERN : PTN;
			return prefix + ":" + DELIMITER + toString() + DELIMITER;
		}
		
		/**
		* 	@private
		*/
		override public function toString():String
		{
			var delimiter:String = "";
			if( name == PARTS )
			{
				delimiter = ",";
			}
			if( patterns.length == 0 && _source == null )
			{
				return super.toString();
			}
			return patterns.length > 0 ? patterns.join( delimiter ) : _source;
		}
		
		/**
		* 	Compiles a source string into this pattern.
		* 
		* 	@param source The source string to compile.
		*/
		public function compile( source:String ):void
		{
			__compile( source );
		}
		
		/**
		* 	@private
		* 	
		* 	Compiles a string to a pattern.
		* 
		* 	Any existing patterns belonging to this pattern
		* 	are removed before attempting to compile.
		* 
		* 	@param candidate The string candidate to compile.
		* 	@param list Whether this pattern should be treated
		* 	as a tree rather than a list structure.
		* 	@param target An optional target to compile into,
		* 	if not specified the pattern is compiled into this
		* 	pattern.
		* 
		* 	@return A compiled pattern.
		*/
		private function __compile(
			candidate:String,
			target:Pattern = null ):Pattern
		{
			if( target == null )
			{
				target = this;
			}
			
			if( candidate != null )
			{
				clear();
				//copy the candidate to our source
				_source = candidate.substr();
				_compiled = candidate.substr();
				
				if( isMetaSequence( _compiled ) )
				{
					//nothing to build for meta character sequences
					return target;
				}
				
				var parentTarget:Pattern = target;
				var opens:Boolean = false;
				var closes:Boolean = false;
				var meta:String = null;
				var ptn:Pattern = null;
				var data:String = null;
				var tmp:Pattern = null;

				var current:Pattern = null;				
						
				trace("[COMPILE] PatternBuilder::compile()", _compiled );

				//candidate for valid actionscript property names
				var prop:String = "(?:[a-zA-Z_\\$]{1}[a-zA-Z0-9_\\$]*)";
				
				//meta sequences '\b', '\n' etc, etc
				
				var expr:String = "(?:" + __sequence + "|\\?!|\\?:|\\?=|\\?P|\\[|\\]|[()|^\\$<>]){1}";

				var re:RegExp = new RegExp( "(" + expr + ")" );
				var results:Array = re.exec( _compiled );
				
				//no regex special character match
				if( results == null )
				{
					ptn = createPattern( _compiled );
					parentTarget.appendChild( ptn );
					parts.appendChild( ptn );
					return target;
				}
				
				var position:int = results.index;				
				
				//grab any inital non-meta chunk
				if( position > 0 )
				{
					data = _compiled.substr( 0, results.index );
					ptn = getCompilationPattern( data );
					addCompilationPattern(
						parentTarget, ptn, true );
				}
				
				//grab the first pattern match
				if( results[ 1 ] is String )
				{
					ptn = getCompilationPattern( results[ 1 ] );
				}

				while( ptn != null )
				{
					opens = ptn.opens();
					closes = ptn.closes();
					
					if( opens
						&& parentTarget != null )
					{
						if( !( ptn.source == LESS_THAN ) )
						{
							addCompilationPart( ptn );
						}

						//add the opening meta group character
						//to a pattern used to represent the entire
						//group contents
						current = createPattern( ptn.source );
						current.appendChild( ptn );
						current.setOpen( true );
						ptn = current;
					}else
					{
						if( ptn.qualifier == null
							&& !( ptn.source == GREATER_THAN ) )
						{
							addCompilationPart( ptn );
						}
					}
					
					//
					addCompilationPattern( parentTarget, ptn );
					
					if( opens )
					{
						//opening a group update the parent target *after* adding the group
						parentTarget = current;
					}
					
					//close an open group
					if(	closes
						&& current != null )
					{
						current.setOpen( false );
						parentTarget = Pattern( current.owner );
						current = parentTarget;
					}

					//look for the next meta character sequence
					//to extract any intermediary chunk
					var next:int = _compiled.search( re );
					if( next > 0 )
					{
						//extract the non-meta character chunk
						data = _compiled.substr( 0, next );
					
						if( __quantity.test( data ) )
						{
							results = __quantity.exec( data );
							var c:String = results[ 1 ] as String;
							var just:Boolean = __justquantity.test( data );
							
							//trace("Pattern::compile()", "[FOUND QUANTITY CHUNK]", data, results, c, just, ptn );
							
							//quantifier with chunk data after
							//a group or character class so
							//split into quantifier and remaining
							//chunk
							if( c != null
								&& results.index == 0
								&& !just
								&& (
									closes
									&& ptn.source == RPAREN
									|| ptn.source == RBRACKET ) )
							{
								//trace("Pattern::compile()", "[FOUND MIXED QUANTITY CHUNK]" );
								
								//add the quantifier part
								addCompilationPattern(
									parentTarget,
									getCompilationPattern( data.substr( 0, c.length ) ),
									true );
								
								//re-assign the current chunk value
								data = data.substr( c.length );
							}else if( just && c != null )
							{
								data = c;
							}
						}

						ptn = createPattern( data );
						
						//trace("[COMPILE] Pattern::compile()", "[ADDING CHUNK]", data );
						
						//adding a chunk to a named property
						//group - <propertyName>
						if( parentTarget.grouping
							&& parentTarget.owner is Pattern
							&& parentTarget.firstPatternChild != null
							&& parentTarget.firstPatternChild.toString() == LESS_THAN )
						{	
							//assign the named property field to
							//the parent group
							Pattern( parentTarget.owner ).field = data;
						}else
						{
							addCompilationPart( ptn );
						}
						
						//add the chunk pattern
						addCompilationPattern( parentTarget, ptn );
					}
					
					//test for more meta sequences
					results = re.exec( _compiled );					
					ptn = null;
					if( results != null )
					{
						position = results.index;
						if( results[ 1 ] as String != null )
						{
							ptn = createPattern(
								results[ 1 ] as String );
						}
					}
				}
			}
			return target;
		}
		
		/*
		*	COMPILATION INTERNALS
		*/
		
		/**
		* 	@private
		* 	
		* 	Determines whether the last attempt
		* 	to compile a pattern completed successfully.
		*/
		internal function get compiled():Boolean
		{
			return _compiled != null
				&& _source != null
				&& _compiled == "";
		}
		
		/**
		* 	@private
		*/
		internal function getCompilationPattern(
			data:String ):Pattern
		{
			return createPattern( data );
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPattern(
			parent:Pattern,
			ptn:Pattern,
			part:Boolean = false ):String
		{
			//chomp the matched string
			_compiled = _compiled.substr( ptn.source.length );
						
			//a cancelled meta character/sequence
			if( ptn.cancelled )
			{
				//fold into any previous character matching data
				//if we can
				if( ptn.previousPatternSibling.data )
				{
					ptn.previousPatternSibling.source += ptn.source;
					return _compiled;
				}else{
					//TODO?
					trace("Pattern::get compiled()", "[FOUND ESCAPED META SEQUENCE WITH NO PREVIOUS CHARACTER MATCH]", ptn );
				}
			}
			
			parent.appendChild( ptn );
			if( part )
			{
				addCompilationPart( ptn );
			}
			return _compiled;
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPart(
			ptn:Pattern ):Pattern
		{
			parts.appendChild( ptn );
			return parts;
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
		
		
		/**
		* 	@private
		*/
		internal function requiresGrouping():Boolean
		{
			if( group )
			{
				//trace("[REQUIRES GROUPING] Pattern::requiresGrouping()", toString() );
				
				var ptns:PatternList = this.children;
				var ptn:Pattern = null;
				var groups:uint = 0;
				var alternators:uint = 0;
				for( var i:int = 0;i < ptns.length;i++ )
				{
					ptn = ptns.getPatternAt( i );
					if( ptn.group )
					{
						groups++;
					}
					
					if( ptn.source == PIPE )
					{
						alternators++;
					}
					//trace("Pattern::requiresGrouping()", "[TESTING CHILD PATTERN]", ptn, ptn.source, groups, alternators );
				}
				
				//empty capture group
				if( ptns.length == 0 )
				{
					return false;
				}
				
				//single nested pattern
				if( ptns.length == 1 )
				{
					//single group contents
					if( ptns.firstPatternChild.group )
					{
						return false;
					//single chunk contents
					}else if( ptns.firstPatternChild.data )
					{
						return false;
					}
				}				
				
				//complex child patterns
				if( groups > 0 && alternators > 0 )
				{
					return true;
				}
				
				if( groups == 0 && alternators > 0 )
				{
					return false;
				}
				
				//trace("[TESTING GROUPING REQUIREMENTS] Pattern::requiresGrouping()", ptns );
				return true;
			}
			return false;
		}
		
		/*
		*	INTERNAL GROUP MANIPULATION
		*/
		
		/**
		* 	Explodes this pattern into a tokenized
		* 	representation where each pattern part
		* 	represents an individual positional match.
		* 
		* 	@return A pattern representing this pattern
		* 	as patterns tokens for each position.
		*/
		private function explode(
			targets:Vector.<Pattern> = null,
			output:Pattern = null ):Pattern
		{
			if( output == null )
			{
				output = createPattern();
			}
			
			if( targets == null )
			{
				targets = this.patterns;
			}
					
			var ptn:Pattern = null;
			var next:Pattern = null;
			var grp:Pattern = null;
			for( var i:int = 0;i < targets.length;i++ )
			{
				ptn = targets[ i ];
				
				if( ptn.group )
				{
					extract( ptn, output );
				}else
				{
					if( ptn.meta || ptn.data )
					{
						//convert plain patterns to groups
						grp = createPattern();
						grp.appendChild( createPattern( LPAREN ) );	
						grp.appendChild( ptn );
						
						//look ahead and swallow non-group patterns
						while( ++i < targets.length )
						{
							next = targets[ i ];
							if( next.group )
							{
								i--;
								break;
							}
							//close and re-open the group when
							//we encounter a range
							if( next.range )
							{
								//trace("[FOUND RANGE ADD TO PREVIOUS] Pattern::explode()", next, ptn, group );
								grp.appendChild( createPattern( RPAREN ) );
								grp.appendChild( createPattern( LPAREN ) );
								grp.appendChild( next );					
							}else
							{
								grp.appendChild( next );
								//trace("[FOUND QUANTIFIER/CHUNK ADD TO PREVIOUS] Pattern::explode()", next, ptn, grp );								
							}
						}
						grp.appendChild( createPattern( RPAREN ) );
						output.appendChild( grp );
					}
				}
			}
			//trace("[EXPLODE] Pattern::explode()", output.patterns );
			return output;
		}	
		
		/**
		* 	@private
		*/
		private function extract( target:Pattern, output:Pattern ):Pattern
		{
			if( target.grouping
				&& target.group )
			{
				var ptns:Vector.<Pattern> = target.patterns;
				var ptn:Pattern = null;
				var named:Boolean = false;
				var next:Pattern = null;
				var grouped:Pattern = null;
				
				//skip the last part - the group close: ')'
				var l:int = ptns.length - 1;
				
				//skip the first part - the group open '('
				var i:int = 1;
				
				//trace("[EXTRACT] Pattern::extract()", target, target.field, target.field != null );
				
				var requiresGroup:Boolean = target.requiresGrouping();
				
				//trace("[TEST FOR ADDITIONAL GROUPING] Pattern::extract()", requiresGroup );
				
				if( requiresGroup )
				{
					output.appendChild( createPattern( LPAREN ) );
				}
				
				//create a group to encapsulate
				//each extracted group
				var tmp:Pattern = createPattern();
				
				//double the opening group so we maintain
				//the original grouping
				tmp.appendChild( createPattern( LPAREN ) );
				
				//add the positional group to the output
				output.appendChild( tmp );
				
				for( ;i < l;i++ )
				{
					ptn = ptns[ i ];
					
					//trace("[EXTRACTING] Pattern::extract()", ptn );
					
					//ignore invalid patterns
					//and and group qualifiers: '?:', '?!', '?=', '?P'
					if( ptn == null
						|| ptn.qualifier != null )
					{
						//handle named groups: '?P<propertyName>'
						if( ptn.named )
						{
							//trace("[FOUND NAMED_GROUP_SEQUENCE GROUP] Pattern::extract()", ptn );

							//finished a named capture group
							if( i < ( ptns.length - 1 ) )
							{
								next = ptns[ i + 1 ];
								//found a named group declaration
								if( next.toString().indexOf( LESS_THAN ) == 0 )
								{
									//skip the named group part: <propertyName>
									i++;
								}
								
								//trace("[CLOSED NAMED_GROUP_SEQUENCE GROUP] Pattern::extract()", ptn );
							}		
						}
						continue;
					}
					
					//trace("[HANDLE EXTRACTION] Pattern::extract()", ptn, ptn.group );
					
					if( ptn.group )
					{
						//trace("Pattern::extract()", "[FOUND NESTED GROUP PATTERN]" );
						//handle nested groups
						//as we encounter them
						grouped = extract( ptn, output );
						
						//trace("[GOT EXTRACTED GROUP RESULT] Pattern::extract()", grouped, grouped.length - 2, i );
						
						//explode( output );
						
						break;
					}
					
					//add the part to the extracted group
					tmp.appendChild( ptn );	
				}
			}
			
			//close the temp group
			tmp.appendChild( createPattern( RPAREN ) );
					
			if( i < ( l - 1 ) )
			{
				l = ptns.length;
				if( ptns[ l - 1 ] is Pattern
				 	&& ptns[ l - 1 ].source == RPAREN )
				{
					//ignore end group declarations
					l--;
				}
				
				var remainder:Vector.<Pattern> = ptns.slice( i + 1, l );
				
				/*
				trace("Pattern::extract()", "[FOUND MORE TO EXTRACT]", grouped,
					remainder );
				*/
				
				explode( remainder, output );
			}
			
			if( requiresGroup )
			{
				output.appendChild( createPattern( RPAREN ) );
			}
			return tmp;
		}				
		
		/*
		*	INTERNALS
		*/
		
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
		private function isMetaSequence( char:String ):Boolean
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