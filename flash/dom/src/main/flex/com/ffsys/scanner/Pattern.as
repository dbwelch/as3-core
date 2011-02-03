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
			+ "|\\" + OPEN_RANGE
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
		
		public static const OPEN_RANGE:String = "[";
		
		public static const CLOSE_RANGE:String = "]";
		
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
		private var _parts:Vector.<Pattern>;
		
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
		* 	Determines whether this pattern
		* 	is a capture group qualifier.
		* 
		* 	@return Whether this pattern is a capture
		* 	group qualifier.
		*/
		public function qualifier():Boolean
		{
			return ( source == POSITIVE_LOOKAHEAD
				|| source == NEGATIVE_LOOKAHEAD
				|| source == NON_CAPTURING
				|| source == NAMED );
		}
		
		/**
		* 	Determines whether this pattern
		* 	is a quantifier character.
		* 
		* 	@return Whether this pattern is a capture
		* 	group qualifier.
		*/
		public function quantifier():Boolean
		{
			return ( source == ASTERISK
				|| source == PLUS
				|| source == OPTIONAL
				|| isQuantifierRange() );
		}
		
		/**
		*	Determines whether a capture group
		* 	has a qualifier specified.
		*/
		public function get qualified():Boolean
		{
			if( isCaptureGroup() )
			{
				if( patterns.length > 1
					&& patterns[ 0 ].toString() == OPEN_GROUP
					&& patterns[ 1 ] is Pattern )
				{
					return patterns[ 1 ].qualifier();
				}
			}
			return false;
		}
		
		/**
		* 	Determines whether this pattern
		* 	represents a named capture group
		* 	declaration: <code>?P</code>.
		*/
		public function named():Boolean
		{
			return meta && source == NAMED;
		}
		
		/**
		* 	Determines whether this pattern represents a
		* 	meta character sequence.
		*/
		public function get meta():Boolean
		{
			return Pattern.character( this.source );
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
				clear();
				//copy the candidate to our source
				_source = candidate.substr();
				
				
				if( Pattern.character( candidate ) )
				{
					//nothing to build for meta character sequences
					return;
				}
				
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
					ptn = new Pattern( candidate );
					parentTarget.add( ptn );
					parts.push( ptn );
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
					parts.push( ptn );					
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
						parts.push( ptn );
						
						//add the opening meta group character
						//to a pattern used to represent the entire
						//group contents
						current = new Pattern( ptn.source );
						current.add( ptn );
						current.setOpen( true );
						ptn = current;
						trace("PatternBuilder::build() [OPENING GROUP]", current, parentTarget );
					
						//trace("PatternBuilder::build() [OPENING GROUP NEW PARENT]", parentTarget );
					}else
					{
						parts.push( ptn );
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
						parts.push( ptn );

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
		* 	A list patterns belonging to this pattern.
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
		* 	All pattern parts as a flat list.
		*/
		public function get parts():Vector.<Pattern>
		{
			if( _parts == null )
			{
				_parts = new Vector.<Pattern>();
			}
			return _parts;
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
		* 	The last part of this pattern.
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
		* 	Clears this pattern so that it is empty.
		*/
		public function clear():void
		{
			_patterns = null;
			_source = "";
			_parts = null;
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
		
		/**
		* 	Retrieves a pattern at the specified
		* 	index.
		*
		* 	@return The pattern at the specified index
		* 	or <code>null</code> if the index is out of
		* 	bounds.
		*/
		public function get( index:int ):Pattern
		{
			if( index < 0 || index >= length )
			{
				return null;
			}
			return this.patterns[ index ];
		}		
		
		/**
		* 	The number of parts to this pattern.
		*/
		public function get length():uint
		{
			return this.patterns.length;
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
				return testObject( value as Object );
			}
			
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
				return compareList( [ value ] );
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
		* 	Returns a pattern that represents
		* 	the positional matches for this pattern.
		*/
		public function get positions():Pattern
		{
			return explode();
		}
		
		/**
		* 	Explodes this pattern into a tokenized
		* 	representation where each pattern part
		* 	represents an individual positional match.
		* 
		* 	@return A pattern representing this pattern
		* 	as patterns tokens for each position.
		*/
		public function explode(
			targets:Vector.<Pattern> = null,
			output:Pattern = null ):Pattern
		{
			if( output == null )
			{
				output = new Pattern();
			}
			
			if( targets == null )
			{
				targets = this.patterns;
			}
					
			var ptn:Pattern = null;
			var previous:Pattern = null;
			var group:Pattern = null;
			for( var i:int = 0;i < targets.length;i++ )
			{
				ptn = targets[ i ];
				
				/*
				//group quantifiers with a preceeding
				//normal statement or quantifier
				if( previous != null
					&& ptn.quantifier()
					&& ( previous.quantifier() || previous.normal ) )
				{
					//previous.source += ptn.source;
					
					trace("[FOUND QUANTIFIER ADDING TO PREVIOUS] Pattern::explode()", ptn );
					previous.add( ptn );
					continue;
				}
				*/
				
				if( ( ptn.meta || ptn.normal ) && group == null )
				{
					//convert plain patterns to groups
					group = new Pattern();
					group.add( new Pattern( OPEN_GROUP ) );	
					output.add( group );
				}
				
				if( group != null )
				{
					group.add( ptn );
				}
				
				//found a nested group
				if( ptn.group
					&& ptn.isCaptureGroup() )
				{
					if( group != null )
					{
						group.add( new Pattern( CLOSE_GROUP ) );					
					}
					
					//extract( ptn, output );
					
					group = null;
				}
				
				previous = ptn;
			}
			//trace("[EXPLODE] Pattern::explode()", output.patterns );
			return output;
		}
		
		/**
		* 	@private
		*/
		private function extract( target:Pattern, output:Pattern ):Pattern
		{
			if( target.group
				&& target.isCaptureGroup() )
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
				
				//create a group to encapsulate
				//each extracted group
				var tmp:Pattern = new Pattern();
				
				//double the opening group so we maintain
				//the original grouping
				tmp.add( new Pattern( OPEN_GROUP ) );
				
				//add the positional group to the output
				output.add( tmp );
				
				for( ;i < l;i++ )
				{
					ptn = ptns[ i ];
					
					//trace("[EXTRACTING] Pattern::extract()", ptn );
					
					//ignore invalid patterns
					//and and group qualifiers: '?:', '?!', '?=', '?P'
					if( ptn == null
						|| ptn.qualifier() )
					{
						//handle named groups: '?P<propertyName>'
						if( ptn.named() )
						{
							//trace("[FOUND NAMED GROUP] Pattern::extract()", ptn );

							//finished a named capture group
							if( i < ( ptns.length - 1 ) )
							{
								next = ptns[ i + 1 ];
								//found a named group declaration
								if( next.toString().indexOf( OPEN_NAME ) == 0 )
								{
									//skip the named group part: <propertyName>
									i++;
								}
								
								//trace("[CLOSED NAMED GROUP] Pattern::extract()", ptn );
							}		
						}
						continue;
					}
					
					//trace("[HANDLE EXTRACTION] Pattern::extract()", ptn, ptn.isCaptureGroup() );
					
					if( ptn.isCaptureGroup() )
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
					tmp.add( ptn );	
				}
			}
			
			//close the temp group
			tmp.add( new Pattern( CLOSE_GROUP ) );
					
			if( i < ( l - 1 ) )
			{
				l = ptns.length;
				
				if( ptns[ l - 1 ] is Pattern
				 	&& ptns[ l - 1 ].source == CLOSE_GROUP )
				{
					//ignore end group declarations
					l--;
				}
				
				//found remaining plain patterns
				//after a nested group extraction				
				if( grouped )
				{
					//i++;
				}
				
				var remainder:Vector.<Pattern> = ptns.slice( i + 1, l );
				
				trace("Pattern::extract()", "[FOUND MORE TO EXTRACT]", grouped,
					remainder );
				
				explode( remainder, output );
			}
			
			return tmp;
		}
		
		/**
		* 	Determines whether this pattern is grouping.
		*/
		public function get group():Boolean
		{
			return patterns.length > 0
				&& isGroup( first.toString() );
		}

		/**
		* 	@private
		*/
		private function isGroup( source:String ):Boolean
		{
			//trace("Pattern::isGroup()", source );
			return __group.test( source );
		}
		
		public function isCaptureGroup():Boolean
		{
			return ( source != null && source == OPEN_GROUP )
				|| this.group && ( first.toString() == OPEN_GROUP );
		}
		
		public function isRange():Boolean
		{
			return ( source != null && source == OPEN_RANGE )
				|| this.group && ( first.toString() == OPEN_RANGE );
		}
		
		public function isQuantifierRange():Boolean
		{
			return ( source != null && source == OPEN_MIN_MAX )
				|| this.group && ( first.toString() == OPEN_MIN_MAX );
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
				|| char == OPEN_RANGE
				|| char == CLOSE_RANGE
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
				|| source == Pattern.OPEN_RANGE
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
				|| source == Pattern.CLOSE_RANGE
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