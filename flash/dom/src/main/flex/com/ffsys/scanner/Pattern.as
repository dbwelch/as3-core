package com.ffsys.scanner
{
	/**
	* 	Represents a regular expression pattern.
	* 
	* 	This implementation allows for matching against complex
	* 	object structures using a regular expression.
	* 
	* 	This functionality can be used to validate the order
	* 	and occurences of a list of values or the properties
	* 	of complex objects.
	* 
	* 	Examples could be validation for scanner tokens
	* 	or for other validation routines
	* 	such as form field validation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/
	dynamic public class Pattern extends Object
	{
		private static var __group:RegExp = new RegExp(
			"^(?:"
			+ "\\" + OPEN_GROUP
			+ "|\\" + OPEN_CLASS
			+ "|\\" + OPEN_MIN_MAX
			+ "|\\" + OPEN_NAME + ")"
		);
		
		/**
		* 	A meta character that indicates the start position.
		*/
		public static const STARTS_WITH:String = "^";
		
		/**
		* 	Represents a wildcard sequence.
		*/
		public static const DOT:String = ".";
		
		/**
		* 	A meta character that indicates zero or more occurences.
		*/
		public static const ASTERISK:String = "*";
		
		/**
		* 	A meta character that indicates one or more occurences.
		*/
		public static const PLUS:String = "+";
		
		/**
		* 	A meta character that indicates alternation.
		*/
		public static const ALTERNATOR:String = "|";
		
		/**
		* 	A meta character that indicates a range.
		*/
		public static const RANGE:String = "-";
		
		/**
		* 	A meta character that indicates zero or one occurence.
		*/
		public static const OPTIONAL:String = "?";	
		
		/**
		* 	A meta character that indicates the end position.
		*/
		public static const ENDS_WITH:String = "$";
		
		//
		public static const OPEN_GROUP:String = "(";
		
		public static const CLOSE_GROUP:String = ")";
		
		public static const OPEN_CLASS:String = "[";
		
		public static const CLOSE_CLASS:String = "]";
		
		public static const OPEN_MIN_MAX:String = "{";
		
		public static const CLOSE_MIN_MAX:String = "}";
		
		public static const OPEN_NAME:String = "<";
		
		public static const CLOSE_NAME:String = ">";		
		
		public static const POSITIVE_LOOKAHEAD:String = "?=";
		
		public static const NEGATIVE_LOOKAHEAD:String = "?!";
		
		public static const NON_CAPTURING:String = "?:";
		
		public static const NAMED:String = "?P";
		
		/**
		* 	The default target property name when matching against
		* 	complex objects.
		*/
		public static const PROPERTY_NAME:String = "id";
		
		private var _patterns:Vector.<Pattern>;
		
		private var _owner:Pattern;
		private var _position:uint = 0;
		private var _source:* = NaN;
		private var _field:String;
		
		//the actual regex we use for matching
		//this is required as the source property is read only
		//and we want to instantiate a new regex when our source property has changed
		private var _regex:RegExp;

		private var _open:Boolean = false;
		
		/**
		* 	Creates a <code>Pattern</code> instance.
		* 
		* 	@param source The source for the pattern.
		*/
		public function Pattern( target:* = null )
		{
			super();
			if( target is RegExp )
			{
				target = RegExp( target ).source;
			}

			this.source = "" + target;
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
		* 	Determines whether this pattern represents a
		* 	meta character sequence.
		*/
		public function get meta():Boolean
		{
			return Pattern.character(
				this.source );
		}
		
		/**
		* 	Determines whether this is a pattern
		* 	part that does not contain any special
		* 	characters.
		*/
		public function get normal():Boolean
		{
			return !meta;
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
			_source = value;
		}
		
		/**
		* 	The number of parts to this pattern.
		*/
		public function get length():uint
		{
			return this.patterns.length;
		}
		
		/**
		* 	An owner for this pattern.
		*/
		public function get owner():Pattern
		{
			return _owner;
		}
		
		/**
		* 	@private
		*/
		internal function setOwner( owner:Pattern ):void
		{
			_owner = owner;
		}
		
		
		/**
		* 	Concatenates a candidate string to the patterns
		* 	stored by this candidate.
		* 
		* 	@param candidate The string candidate to concatenate.
		*/

		public function build( candidate:String ):void
		{
			if( candidate != null )
			{
				var parentTarget:Pattern = this;
				var opens:Boolean = false;
				var closes:Boolean = false;
				var meta:String = null;
				var ptn:Pattern = null;
				var chunk:String = null;
				
				//var previous:Pattern = null;				

				var current:Pattern = null;				
						
				trace("[CANDIDATE] PatternBuilder::build()", candidate );

				//candidate for valid actionscript property names
				var prop:String = "(?:[a-zA-Z_\\$]{1}[a-zA-Z0-9_\\$]*)";

				//candidate for group capturing
				var namedgroup:String = "";

				//"(?:<(?:"
				//+ prop + ")>)?"	
				//var ng:RegExp = new RegExp( "(?:" + namedgroup + ")" );

				//the main expression used to capture regex special characters
				var expr:String = "(?:\\?!|\\?:|\\?=|\\?P|\\[|\\]|\\?|\\+|[(){}*\\|^\\$:<>.\\-]){1}";

				//(?:[^\\\\]|)

				//var re:RegExp = new RegExp( "(" + expr + ")?([0-9]+)(" + expr + ")?", "g" );

				var re:RegExp = new RegExp( "(" + expr + ")" );
				var results:Array = re.exec( candidate );				

				//trace("PatternBuilder::build()", re, results );

				//no regex special character match
				if( results == null )
				{
					parentTarget.add(
						new Pattern( candidate ) );
					return;
				}
				
				var position:int = results.index;				
				
				//grab any inital non-meta chunk
				if( position > 0 )
				{
					//trace("Pattern::build()", position );
					
					ptn = new Pattern(
						candidate.substr( 0, results.index ) )
					parentTarget.add( ptn );
					candidate = candidate.substr( results.index );
				}				

				if( results[ 1 ] is String )
				{
					ptn = new Pattern( results[ 1 ] );
					candidate = candidate.substr( ptn.source.length );
				}
				
				//current = ptn;

				while( ptn != null )
				{
					opens = ptn.opens();
					closes = ptn.closes();
					
					if( opens
						&& parentTarget != null )
					{
						//add the opening meta group character
						//to a pattern used to represent the entire
						//group contents
						current = new Pattern( ptn.source );
						current.add( ptn );
						current.setOpen( true );
						ptn = current;
						trace("PatternBuilder::build() [OPENING GROUP]", current, parentTarget );
					
						//trace("PatternBuilder::build() [OPENING GROUP NEW PARENT]", parentTarget );
					}
					
					/*
					if( current != null )
					{
						trace("[IN GROUP] PatternBuilder::build()", ptn, opens, closes, current.group, current.open );
					}				
					*/
					
					//
					parentTarget.add( ptn );
					
					if( opens )
					{
						//opening a group update the parent target after adding the group
						parentTarget = current;
						//trace("PatternBuilder::build() [OPENING GROUP - OWNER IS THIS]", current.owner == this );
					}
					
					trace("[ADDING PATTERN] PatternBuilder::build()", ptn, parentTarget );					
					
					if(	closes
						&& current != null )
					{
						current.setOpen( false );
						trace("PatternBuilder::build()", "[CLOSING GROUP]", ptn, current, parentTarget, current.owner == this );
						parentTarget = current.owner;
						current = parentTarget;
					}

					//look for the next meta character sequence
					var next:int = candidate.search( re );
					if( next > 0 )
					{
						chunk = candidate.substr( 0, next );
						
						//chomp the string
						candidate = candidate.substr( chunk.length );
						ptn = new Pattern( chunk );
						
						//adding a chunk to a named property
						//group - <propertyName>
						if( parentTarget.group
							&& parentTarget.owner != null
							&& parentTarget.first != null
							&& parentTarget.first.toString() == OPEN_NAME )
						{
							
							/*
							trace("[FOUND CHUNK FOR NAMED PROPERTY] Pattern::build()",
								ptn, parentTarget.owner );
							*/
								
							//assign the named property field to
							//the parent group
							parentTarget.owner.field = chunk;
						}
						
						parentTarget.add( ptn );

						trace("[ADDING CHUNK] PatternBuilder::build()", chunk, parentTarget );
					}
					
					trace("[NEW LENGTH] Pattern::build()", patterns.length );
					
					//test for more meta characters
					results = re.exec( candidate );
					ptn = null;
					if( results != null )
					{
						position = results.index;
						if( results[ 1 ] as String != null )
						{
							ptn = new Pattern(
								results[ 1 ] as String );
							//chomp the source candidate
							candidate = candidate.substr( ptn.source.length );
							//trace("Pattern::build() [CREATED NEXT META PATTERN]", ptn );
						}
					}
				}

				trace("[MATCHES] PatternBuilder::build()", this, patterns.length, patterns );
			}
		}
		
		/**
		* 	Attempts to extract a single value
		* 	from a list of candidate values.
		* 
		* 	@param values An array of candidate values.
		* 
		* 	@return The extracted value or <code>null</code>
		* 	if the <code>values</code> is <code>null</code>
		* 	or empty.
		*/
		public function extract( values:Array ):*
		{
			if( values == null || values.length == 0 )
			{
				return null;
			}
			var value:* =  values[ 0 ];
			var field:String = getField( value );
			if( value is Object
				&& field != null )
			{
				var hasProp:Boolean = value.hasOwnProperty( field );
				if( hasProp )
				{
					//extract the value from a named property
					value = value[ field ];
				}				
			}
			return value;
		}
		
		/**
		* 	Retrieves pattern parts by type.
		* 
		* 	@param types The list of types to retrieve parts
		* 	for.
		* 	@param negated Whether the patterns must not be
		* 	of the specified types.
		*/
		public function getPatternParts(
			types:Vector.<Class> = null,
			negated:Boolean = false ):Vector.<Pattern>
		{
			var output:Vector.<Pattern> = new Vector.<Pattern>();
			var type:Class = null;
			var part:Pattern = null;
			var conforms:Boolean = false;
			var i:int = 0;
			for each( type in types )
			{
				for( i = 0;i < patterns.length;i++ )
				{
					part = patterns[ i ];
					conforms = ( !negated ) ? ( part is type ) : !( part is type );
					if( conforms )
					{
						output.push( part );
					}
				}
			}
			return output;
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
			trace("Pattern::set field()", value );
		}
		
		/**
		* 	The scan rule patterns to test against.
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
		* 	The first part of this pattern.
		*/
		public function get first():Pattern
		{
			if( patterns.length > 0 )
			{
				return patterns[ 0 ];
			}
			return null;
		}
		
		/**
		* 	The last part of this patterns.
		*/
		public function get last():Pattern
		{
			if( patterns.length > 0 )
			{
				return patterns[ patterns.length - 1 ];
			}
			return null;
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
				part.setOwner( this );
				patterns.push( part );
				return true;
			}
			return false;
		}
		
		private function getCandidate(
			candidates:Array ):Array
		{
			return candidates.slice( _position, _position + 1 );
		}
		
		/**
		* 	Retrieves the name of the property field
		* 	for a given target.
		* 
		* 	When the return value is <code>null</code>
		* 	it indicates either the target is <code>null</code>
		* 	or a primitive value.
		* 
		* 	@param target The target object to test for
		* 	the availability of a field name.
		* 
		* 	@return A field name if the target is an
		* 	<code>Object</code>.
		*/
		public function getField( target:* ):String
		{
			if( target == null || !( target is Object ) )
			{
				return null;
			}
			//just test against numeric id for the moment
			return PROPERTY_NAME;
		}
		
		public function test( value:* ):Boolean
		{
			var re:RegExp = this.regex;
			
			//compare against the source of other
			//regular expressions
			if( value is RegExp )
			{
				value = RegExp( value ).source;
			}
			
			if( value is String )
			{
				return re.test( value as String );
			}
			
			trace("Pattern::test()", value, ( value is Object ) );
			
			//non-string primitive value
			//coerce to a string for comparison
			if( value is Number || value is Boolean )
			{
				trace("[PRIMITIVE TEST] Pattern::test()", re, "" + value, re.test( "" + value ) );
				return re.test( "" + value );
			}
			
			if( value is Object )
			{
				//got a collection - should test against
				//the collection entries
				if( value is Array || value is Vector )
				{
					//TODO
				}else
				{
					//TODO: single object comparison
					//test for named property group
					//if exists try object property comparison
					//otherwise coerce the object valueOf() to a string for comparison
				}
			}
			
			return false;
		}
		
		/**
		* 	Tests whether the rule pattern matches
		* 	the candidates list.
		* 
		* 	@param candidates The list of candidate objects.
		* 
		* 	@return Whether the pattern matches the candidate list.
		*/
		public function valid( candidates:Array ):Boolean
		{
			var empty:Boolean = candidates == null || candidates.length == 0;
			
			trace("[TEST] Pattern::test() [CANDIDATES]", candidates );
			
			//copy the input
			if( !empty )
			{
				candidates = candidates.slice();
			}
			
			var parts:Array = null;
			
			var i:uint = 0;
			var g:uint = 0;								//nested group iterator
			var tmp:Vector.<Pattern> = patterns.slice();	//copy our patterns
			var l:uint = tmp.length;
			var candidate:Array = null;
			var begins:Boolean = false;
			var ends:Boolean = false;
			var part:Pattern = null;
			var next:Pattern = null;
			var previous:Pattern = null;
						
			var first:Pattern = null;
			var last:Pattern = null;
			var isMatchPattern:Boolean;			
			
			try
			{
				first = patterns[ 0 ];
				last = patterns[ patterns.length - 1 ];
			}catch( e:Error )
			{
				//no need to worry if we don't have first | last
			}
			
			//empty pattern
			if( first == null && last == null )
			{
				return empty === true;
			}
			
			//single pattern part
			if( first === last )
			{
				//parts = new Array( 1, true );
				return !empty
					&& candidates.length == 1
					&& first != null
					&& first.valid( candidates );
			}
			
			begins = first != null
				&& first.meta
				&& first.equals( Pattern.STARTS_WITH );
			ends = first != last
				&& last != null
				&& last.meta
				&& last.equals( Pattern.ENDS_WITH );
				
			if( begins )
			{
				tmp.unshift();
			}
			
			if( ends )
			{
				tmp.pop();
			}	
			
			//retrieve a default field to use
			var field:String = getField( this );
			
			var result:Boolean = true;
				
			for( ;i < l;i++ )
			{
				part = tmp[ i ];
				isMatchPattern = part.handles();
				
				/*
				if( begins && i == 0 )
				{
					candidates.unshift( first );
				}else if( ends && i == ( l - 1 ) )
				{
					candidates.push( last );
				}
				*/
				
				/*			
				if( part is PatternQuantifier )
				{
					//previous match pattern with no qualifier
					if( previous != null
					 	&& previous.handles()
						&& previous.quantifier == null )
					{
						previous.quantifier = part as PatternQuantifier;
					}
					trace("Pattern::test()", "[SKIPPING QUANTIFIER]", part );
					continue;
				}	
				*/
				
				candidate = getCandidate( candidates );
				
				result = testChildGroups( part, candidates );
				
				//trace("Pattern::test() begins/ends:", begins, ends );
				
			
				trace("[TEST] Pattern::test()", _position, part );	
				
				result = part.match( field, candidate );
				
				trace("[RESULT] Pattern::test()", _position, result );
				
				//any unsuccessful result breaks the test
				if( result === false )
				{
					/*
					//starts with failed to match
					//or a match that is begin and end qualified ^.*$
					//failed to match
					if( ( begins
						&& i == 1 )
						|| ( begins && ends ) )
					{
						break;
					}
					*/
					
					break;
				}
				
				previous = part;
				_position++;
			}
			return result;
		}
		
		/**
		* 	@private
		*/
		protected function testChildGroups(
			pattern:Pattern,
			candidates:Array ):Boolean
		{
			var g:uint = 0;
			var part:Pattern = null;
			var result:Boolean = true;
			var children:Vector.<Pattern>;			
			var candidate:Array;
			var field:String = getField( this );			
			
			//handle nested groups
			if( isGroup( "" + pattern ) )
			{
				children = Pattern( pattern ).getGroups();
				if( children.length > 0 )
				{
					
					//trace("Pattern::test()", "[FOUND NESTED CHILD GROUPS]", children, _position, candidate[ 0 ].id );
					
					for( g = 0;g < children.length;g++ )
					{
						part = children[ g ];
						
						trace("Pattern::test()", "[FOUND NESTED CHILD GROUPS]", part, part.handles() );
						
						//skip non-matching parts
						if( part != null
							&& !part.handles() )
						{
							continue;
						}
						
						//increment the pattern match position
						//for each nested group
						_position++;
						candidate = getCandidate( candidates );
						if( part != null
							&& part.handles() )
						{
							//result = part.test( candidate );
							
							result = part.match( field, candidate );

							trace("Pattern::test()", "[FOUND NESTED CHILD GROUPS RESULT]", result );
							
							//invalid group
							if( result === false )
							{					
								break;
							}
						}
					}
				}
			}
			return result;
		}
		
		/**
		* 	Determines whether a comparison is equal
		* 	to the string representing this part of the pattern.
		* 
		* 	@param comparison The candidate to campare against.
		* 
		* 	@return Whether the comparison is equal to the match
		* 	associated with this pattern rule.
		*/
		public function equals( comparison:String ):Boolean
		{
			return source == comparison;
		}
		
		/**
		* 	Determines whether this pattern handles
		* 	pattern matching.
		*/
		public function handles():Boolean
		{
			return this.normal;
		}
		
		/**
		* 	Determines whether a value is considered
		* 	to be a meta character.
		* 
		* 	@param value The value to test against.
		* 
		* 	@return Whether the value is a meta character.
		*/
		public function character( value:String ):Boolean
		{
			return Pattern.character( value );
		}
		
		/**
		* 	Expands the list of pattern parts
		* 	to a complete list of acceptable
		* 	match patterns for the parts.
		* 
		* 	An expected value can be any of the
		* 	match patterns returned by this method.
		* 
		* 	@param parts The list of candidate parts.
		* 
		* 	@return The expanded list of pattern matches.
		*/
		public function expand( parts:Vector.<Pattern> ):Vector.<Pattern>
		{
			var output:Vector.<Pattern> = new Vector.<Pattern>();
			var part:Pattern = null;
			var next:Pattern = null;
			var previous:Pattern = null;			
			for( var i:int = 0;i < parts.length;i++ )
			{
				part = parts[ i ];
				if( i < parts.length - 1 )
				{
					next = parts[ i + 1 ];
				}
				//next is an alternator or
				//we're the last part add the part
				if( i == ( length - 1 )
					|| part.handles() )
				{
					output.push( part );
				}
				previous = part;
			}
			return output;
		}
		
		
		/**
		* 	Retrieve patterns of this match that
		* 	are direct children not those of any
		* 	nested pattern group, essentially the
		* 	pattern parts that should match at the
		* 	current match position.
		* 
		* 	@return A list of child match patterns
		*/
		public function getChildMatchPatterns():Vector.<Pattern>
		{
			var output:Vector.<Pattern> = new Vector.<Pattern>();
			var part:Pattern = null;
			for( var i:int = 0;i < patterns.length;i++ )
			{
				part = patterns[ i ];
				if( part.handles() )
				{
					if( part.group )
					{
						output.push( part );
					}else{
						//stop when we encounter a nested
						//group as that constitutes the next
						//position in processing
						break;
					}
				}
			}
			
			return output;
		}
		
		/**
		* 	Retrieves all child pattern groups.
		* 
		* 	@return A list of child pattern groups.
		*/
		public function getGroups():Vector.<Pattern>
		{
			var types:Vector.<Class> = new Vector.<Class>( 1, true );
			types[ 0 ] = Pattern;
			return getPatternParts( types );
		}
		
		/**
		* 	Determines whether this pattern is grouping.
		*/
		public function get group():Boolean
		{
			return patterns.length > 0
				&& isGroup( patterns[ 0 ].toString() );
		}

		public function isGroup( source:String ):Boolean
		{
			trace("Pattern::isGroup()", source );
			return __group.test( source );
		}
		
		/**
		* 	Determines wether a list of candidates
		* 	has the named property.
		* 
		* 	@param field The property name to test on the target
		* 	objects.
		* 	@param expected The expected value for the property.
		* 	@param candidates The list of candidates
		* 	to match against.
		* 
		* 	@return Whether this pattern matches the candidate
		* 	list.
		*/
		public function match(
			field:String,
			candidates:Array ):Boolean
		{
			trace("[MATCH TEST] Pattern::match()", extract( candidates ), regex, regex.test( "" + extract( candidates ) ) );

			//expecting a value but no valid list
			//of candidate objects
			if( candidates == null
				|| candidates.length == 0 )
			{
				return false;
			}
			
			return regex.test( "" + extract( candidates ) );
		}		
		
		/**
		* 	Gets a regular expression representation
		* 	of this pattern.
		* 
		* 	@return This pattern as a regular expression.
		*/
		public function get regex():RegExp
		{
			if( _regex == null )
			{
				if( patterns.length == 0 )
				{
					if( _regex.source != this.source )
					{
						_regex = new RegExp( this.source );
					}
				}else{
					_regex = new RegExp( toString() );
				}
			}
			return _regex;
		}
		
		/**
		* 	Retrieves a string representation of this pattern.
		* 
		* 	@return A string representation of this pattern.
		*/
		public function toString():String
		{
			return patterns.length > 0 ? patterns.join( "" ) : _source;
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
			return char == POSITIVE_LOOKAHEAD
				|| char == NEGATIVE_LOOKAHEAD
				|| char == NON_CAPTURING
				|| char == NAMED	
				|| char == STARTS_WITH
				|| char == ASTERISK
				|| char == DOT
				|| char == PLUS
				|| char == OPTIONAL
				|| char == ENDS_WITH
				|| char == ALTERNATOR
				|| char == RANGE
				|| char == OPEN_GROUP
				|| char == CLOSE_GROUP
				|| char == OPEN_MIN_MAX
				|| char == CLOSE_MIN_MAX
				|| char == OPEN_CLASS
				|| char == CLOSE_CLASS
				|| char == OPEN_NAME
				|| char == CLOSE_NAME;
		}
		
		/**
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
		* 	opens a group.
		* 
		* 	@return Whether this pattern opens a group.
		*/
		internal function opens():Boolean
		{
			var valid:Boolean = (
				source == Pattern.OPEN_GROUP
				|| source == Pattern.OPEN_CLASS
				|| source == Pattern.OPEN_MIN_MAX
				|| source == Pattern.OPEN_NAME );
				
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
		* 	closes a group a currently open group.
		* 
		* 	@return Whether this pattern closes a group.
		*/
		internal function closes():Boolean
		{
			var valid:Boolean = (
				source == Pattern.CLOSE_GROUP
				|| source == Pattern.CLOSE_CLASS
				|| source == Pattern.CLOSE_MIN_MAX
				|| source == Pattern.CLOSE_NAME );
			
			if( valid && _open )
			{
				_open = false;
			}
			return valid;
		}				
	}
}