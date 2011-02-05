package com.ffsys.pattern
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
	dynamic public class Pattern extends PatternSet
	{
		/**
		* 	A meta character that indicates
		* 	the start position or negation
		* 	when specified as the first character
		* 	in a character class.
		*/
		public static const CARET:String = "^";
		
		/**
		* 	Represents a wildcard character.
		*/
		public static const DOT:String = ".";
		
		/**
		* 	A quantifier character that indicates
		* 	zero or more occurences.
		*/
		public static const ASTERISK:String = "*";
		
		/**
		* 	A quantifier character that indicates one
		* 	or more occurences.
		*/
		public static const PLUS:String = "+";
		
		/**
		* 	A quantifier character that indicates zero or one occurence
		* 	or as a greedy behaviour modifier (makes the match lazy)
		* 	to a previous quantifier.
		*/
		public static const QUESTION_MARK:String = "?";
		
		/**
		* 	A meta character that indicates alternation.
		*/
		public static const PIPE:String = "|";
		
		/**
		* 	A meta character that indicates a character range.
		* 
		* 	Only applicable within character classes.
		*/
		public static const HYPHEN:String = "-";
		
		/**
		* 	A meta character that indicates the end position.
		*/
		public static const DOLLAR:String = "$";
		
		/**
		* 	A meta character that indicates the start of a group.
		*/
		public static const LPAREN:String = "(";
		
		/**
		* 	A meta character that indicates the end of a group.
		*/
		public static const RPAREN:String = ")";
		
		/**
		* 	A meta character that indicates the start of a
		* 	character class.
		*/
		public static const LBRACKET:String = "[";
		
		/**
		* 	A meta character that indicates the end of a
		* 	character class.
		*/
		public static const RBRACKET:String = "]";
		
		/**
		* 	A meta character that indicates the start
		* 	of a qualifier range.
		*/
		public static const LBRACE:String = "{";
		
		/**
		* 	A meta character that indicates the end
		* 	of a qualifier range.
		*/
		public static const RBRACE:String = "}";
		
		/**
		* 	A meta character that indicates the start
		* 	of a name for a named group.
		*/
		public static const LESS_THAN:String = "<";
		
		/**
		* 	A meta character that indicates the end
		* 	of a name for a named group.
		*/
		public static const GREATER_THAN:String = ">";
		
		/**
		*	The meta sequence representing a
		* 	positive lookahead group.
		*/
		public static const POSITIVE_LOOKAHEAD_SEQUENCE:String = "?=";
		
		/**
		*	The meta sequence representing a
		* 	negative lookahead group.
		*/
		public static const NEGATIVE_LOOKAHEAD_SEQUENCE:String = "?!";
		
		/**
		*	The meta sequence representing a
		* 	non-capturing group.
		*/
		public static const NON_CAPTURING_SEQUENCE:String = "?:";
		
		/**
		*	The meta sequence representing a
		* 	named group.
		*/
		public static const NAMED_GROUP_SEQUENCE:String = "?P";
		
		private var _patterns:Vector.<Pattern>;
		private var _parts:Pattern;
		private var _position:uint = 0;
		private var _source:* = NaN;
		private var _field:String;
		private var _compiled:String;

		private var _open:Boolean = false;
		
		//stores the minimum and maximum occurences
		//for this pattern
		internal var _min:Number = -1;
		internal var _max:Number = -1;
		
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
			}else if( isCaptureGroup() || range )
			{
				if( _min == -1 && _max == -1 )
				{
					_min = 1;
					_max = 1;
				}
				
				if( nextSibling != null
					&& nextSibling.quantifier )
				{
					_min = nextSibling.minimum;
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
			}else if( isCaptureGroup() || range )
			{
				if( _min == -1 && _max == -1 )
				{
					_min = 1;
					_max = 1;
				}
				
				if( nextSibling != null
					&& nextSibling.quantifier )
				{
					_max = nextSibling.maximum;
				}				
			}			
			return _max;
		}
		
		/**
		*	Gets the qualifier for a group.
		*/
		public function get qualifier():String
		{
			if ( source == POSITIVE_LOOKAHEAD_SEQUENCE
				|| source == NEGATIVE_LOOKAHEAD_SEQUENCE
				|| source == NON_CAPTURING_SEQUENCE
				|| source == NAMED_GROUP_SEQUENCE
				|| namedQualifier )
			{
				return source;
			}
			return null;
		}
		
		public function get namedQualifier():Boolean
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
		* 	Determines whether this is a lazy quantifier.
		*/
		public function get lazy():Boolean
		{
			if( isCaptureGroup() || range
				&& ( nextSibling != null
				&& nextSibling.quantifier ) )
			{
				return nextSibling.lazy;
			}
			return quantifier
				&& source != QUESTION_MARK
				&& ( ( source.indexOf( QUESTION_MARK ) == source.length - 1 )
				|| ( nextSibling != null
					&& nextSibling.source == QUESTION_MARK ) );
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
			if( isCaptureGroup() )
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
		* 	Determines whether this pattern
		* 	represents a named capture group
		* 	declaration: <code>?P</code>.
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
			return isMetaSequence( this.source );
		}
		
		/**
		* 	Determines whether a string is considered
		* 	to be a meta character or meta sequence.
		* 
		* 	@param char The string to test against.
		* 
		* 	@return Whether the value is a meta character
		* 	or meta sequence.
		*/
		public function isMetaSequence( char:String ):Boolean
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
		
		/**
		* 	Determines whether this is a pattern
		* 	part that does not contain any special
		* 	characters.
		*/
		public function get chunk():Boolean
		{
			return !root && !meta;
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
		* 	A next sibling pattern if available.
		*/
		public function get nextSibling():Pattern
		{
			try
			{
				return this.owner.patterns[ this.index + 1 ];
			}catch( e:Error )
			{
				//no valid owner or index is out of range
			}
			return null;
		}
		
		/**
		* 	A previous sibling pattern if available.
		*/
		public function get previousSibling():Pattern
		{
			try
			{
				return this.owner.patterns[ this.index - 1 ];
			}catch( e:Error )
			{
				//no valid owner or index is out of range
			}			
			return null;
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
				_parts = new Pattern();
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
			return 	( root && !empty && first.source == CARET )
				||	( owner != null
					&& owner.root
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
			return 	( root && !empty && last.source == DOLLAR )
				||	( owner != null
					&& owner.root
					&& source == DOLLAR
					&& ( index == owner.patterns.length - 1 ) );
		}
		
		/**
		* 	@inheritDoc
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
			pattern:Pattern, value:*, position:uint = 0 ):PatternMatchResult
		{
			var match:PatternMatchResult = new PatternMatchResult( position, pattern, value );
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
				value, re, re.test( value as String ), match, match.result );
			
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
			var matched:PatternMatchResult = null;
			
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
				if( i == ( patterns.length - 1 )
					|| part.chunk )
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
			var next:Pattern = null;
			var group:Pattern = null;
			for( var i:int = 0;i < targets.length;i++ )
			{
				ptn = targets[ i ];
				
				if( ptn.isCaptureGroup() )
				{
					extract( ptn, output );
				}else
				{
					if( ptn.meta || ptn.chunk )
					{
						//convert plain patterns to groups
						group = new Pattern();
						group.add( new Pattern( LPAREN ) );	
						group.add( ptn );
						
						//look ahead and swallow non-group patterns
						while( ++i < targets.length )
						{
							next = targets[ i ];
							if( next.isCaptureGroup() )
							{
								i--;
								break;
							}
							//close and re-open the group when
							//we encounter a range
							if( next.range )
							{
								//trace("[FOUND RANGE ADD TO PREVIOUS] Pattern::explode()", next, ptn, group );
								group.add( new Pattern( RPAREN ) );
								group.add( new Pattern( LPAREN ) );
								group.add( next );					
							}else
							{
								group.add( next );
								//trace("[FOUND QUANTIFIER/CHUNK ADD TO PREVIOUS] Pattern::explode()", next, ptn, group );								
							}
						}
						group.add( new Pattern( RPAREN ) );
						output.add( group );
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
				
				var group:Boolean = target.requiresGrouping();
				
				//trace("[TEST FOR ADDITIONAL GROUPING] Pattern::extract()", group );
				
				if( group )
				{
					output.add( new Pattern( LPAREN ) );
				}
				
				//create a group to encapsulate
				//each extracted group
				var tmp:Pattern = new Pattern();
				
				//double the opening group so we maintain
				//the original grouping
				tmp.add( new Pattern( LPAREN ) );
				
				//add the positional group to the output
				output.add( tmp );
				
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
			tmp.add( new Pattern( RPAREN ) );
					
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
			
			if( group )
			{
				output.add( new Pattern( RPAREN ) );
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
			return ( source != null && source == LPAREN )
				|| this.group && ( first.toString() == LPAREN );
		}
		
		override public function get children():Pattern
		{
			if( isCaptureGroup() )
			{
				//TODO: stash this and invalidate	
				var output:Pattern = new Pattern();
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
					output.add( ptn );
				}
				return output;
			}
			return null;
		}
		
		internal function requiresGrouping():Boolean
		{
			if( isCaptureGroup() )
			{
				//trace("[REQUIRES GROUPING] Pattern::requiresGrouping()", toString() );
				
				var ptns:Pattern = this.children;
				var ptn:Pattern = null;
				var groups:uint = 0;
				var alternators:uint = 0;
				for( var i:int = 0;i < ptns.length;i++ )
				{
					ptn = ptns.get( i );
					if( ptn.isCaptureGroup() )
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
					if( ptns.first.isCaptureGroup() )
					{
						return false;
					//single chunk contents
					}else if( ptns.first.chunk )
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
		
		/**
		* 	Determines whether this pattern is a character
		* 	range, <code>[0-9]</code>.
		*/
		public function get range():Boolean
		{
			return ( source != null && source == LBRACKET )
				|| this.group && ( first.toString() == LBRACKET );
		}
		
		/**
		* 	Determines whether this pattern is a character
		* 	range and is negated, <code>[^0-9]</code>.
		*/
		public function get negated():Boolean
		{
			return range
				&& first != null
				&& first.nextSibling != null
				&& first.nextSibling.source == CARET;
		}
		
		/**
		* 	@inheritDoc
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
		* 	@inheritDoc
		*/
		override public function get name():String
		{
			var nm:String = super.name;
			if( nm == null )
			{
				switch( source )
				{
					case PIPE:
						nm = "alternator";
						break;
					case DOT:
						nm = "dot";
						break;
				}
				if( nm == null )
				{
					if( isCaptureGroup() )
					{
						nm = "group";
					}else if( range )
					{
						nm = "range";
					}else if( quantifier )
					{
						nm = "quantifier";
					}else if( meta )
					{
						nm = "meta";
					}else if( chunk )
					{
						nm = "data";
					}				
				}
			}
			return nm == null ? "pattern" : nm;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get xml():XML
		{
			//TODO: stash this XML and invalidate
			
			var i:int = 0;
			var name:String = this.name;
			var x:XML = new XML( "<" + name + " />" );
			if( !root && !isCaptureGroup() )
			{	
				if( range || meta || chunk )
				{
					x = new XML( "<" + name + "><![CDATA[" + toString() + "]]></" + name + ">" );
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
			if( quantifier || range || isCaptureGroup() )
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
			
			//shortcut out for simple types
			if( !root && !isCaptureGroup() )
			{	
				if( range || meta || chunk )
				{
					return x;
				}
			}			
			
			//handle complex types
			var ptns:Vector.<Pattern> = this.patterns;
			var group:Boolean = !root && isCaptureGroup();
			if( group )
			{
				ptns = children.patterns;
			}
			
			if( group )
			{
				x.@qualified = this.qualified;
				if( field != null )
				{
					x.@field = this.field;
				}
			}
			
			if( root || source == CARET || source == DOLLAR )
			{
				x.@begins = begins;
				x.@ends = ends;
			}
			
			if( root )
			{			
				x.appendChild( new XML( "<![CDATA[" + this.source + "]]>" ) );
				
				if( length > 0 )
				{
					var results:XML = new XML( "<" + RESULTS + "/>" );
					var match:PatternMatchResult = null;
					for( i = 0;i < length;i++ )
					{
						match = this[ i ] as PatternMatchResult;
						results.appendChild( match.xml );
					}
					x.appendChild( results );
				}
			}else
			{
				x.appendChild( new XML( "<source><![CDATA[" + toString() + "]]></source>" ) );
			}
			
			if( ptns != null && ptns.length > 0 )
			{
				var children:XML = new XML( "<patterns />" );
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
					//by the preceeding pattern they apply to
					if( !ptn.quantifier )
					{
						children.appendChild( child );
					}
					
					//apply the quantifier source as an
					//attribute of the preceeding element
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
		
		/**
		* 	@inheritDoc
		*/
		override public function toPatternString():String
		{
			var prefix:String = root ? PATTERN : PTN;
			return prefix + ":" + DELIMITER + toString() + DELIMITER;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function toString():String
		{
			var delimiter:String = "";
			if( name == PARTS )
			{
				delimiter = ",";
			}
			return patterns.length > 0 ? patterns.join( delimiter ) : _source;
		}
		
		/**
		* 	Determines whether the last attempt
		* 	to compile a pattern completed successfully.
		*/
		public function get compiled():Boolean
		{
			return _compiled == "";
		}
		
		/**
		* 	Compiles a string to a pattern.
		* 
		* 	Any existing patterns belonging to this pattern
		* 	are removed before attempting to compile.
		* 
		* 	@param candidate The string candidate to compile.
		* 	@param target An optional target to compile into,
		* 	if not specified the pattern is compiled into this
		* 	pattern.
		* 
		* 	@return A compiled pattern.
		*/
		public function compile( candidate:String, target:Pattern = null ):Pattern
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
				var chunk:String = null;
				var tmp:Pattern = null;

				var current:Pattern = null;				
						
				trace("[CANDIDATE] PatternBuilder::build()", _compiled );

				//candidate for valid actionscript property names
				var prop:String = "(?:[a-zA-Z_\\$]{1}[a-zA-Z0-9_\\$]*)";
				
				var expr:String = "\\\\?(?:\\?!|\\?:|\\?=|\\?P|\\[|\\]|[()|^\\$:<>.\\-]){1}";

				var re:RegExp = new RegExp( "(" + expr + ")" );
				var results:Array = re.exec( _compiled );
				
				//no regex special character match
				if( results == null )
				{
					ptn = new Pattern( _compiled );
					parentTarget.add( ptn );
					parts.add( ptn );
					return target;
				}
				
				var position:int = results.index;				
				
				//grab any inital non-meta chunk
				if( position > 0 )
				{
					chunk = _compiled.substr( 0, results.index );
					ptn = getCompilationPattern( chunk );
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
						current = new Pattern( ptn.source );
						current.add( ptn );
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
						chunk = _compiled.substr( 0, next );
					
						if( __quantity.test( chunk ) )
						{
							results = __quantity.exec( chunk );
							var c:String = results[ 1 ] as String;
							var just:Boolean = __justquantity.test( chunk );
							
							//trace("Pattern::compile()", "[FOUND QUANTITY CHUNK]", chunk, results, c, just, ptn );
							
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
									getCompilationPattern( chunk.substr( 0, c.length ) ),
									true );
								
								//re-assign the current chunk value
								chunk = chunk.substr( c.length );
							}else if( just && c != null )
							{
								chunk = c;
							}
						}

						ptn = new Pattern( chunk );
						
						//trace("[COMPILE] Pattern::compile()", "[ADDING CHUNK]", chunk );
						
						//adding a chunk to a named property
						//group - <propertyName>
						if( parentTarget.group
							&& parentTarget.owner is Pattern
							&& parentTarget.first != null
							&& parentTarget.first.toString() == LESS_THAN )
						{	
							//assign the named property field to
							//the parent group
							Pattern( parentTarget.owner ).field = chunk;
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
							ptn = new Pattern(
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
		*/
		internal function getCompilationPattern(
			chunk:String ):Pattern
		{
			return new Pattern( chunk );
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPattern(
			parent:Pattern,
			ptn:Pattern,
			part:Boolean = false ):String
		{
			parent.add( ptn );
			if( part )
			{
				addCompilationPart( ptn );
			}
			_compiled = _compiled.substr( ptn.source.length );
			return _compiled;
		}
		
		/**
		* 	@private
		*/
		internal function addCompilationPart(
			ptn:Pattern ):Pattern
		{
			parts.add( ptn );
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
		*	INTERNAL EXPRESSIONS
		*/
		
		private static var __group:RegExp = new RegExp(
			"^(?:"
			+ "\\" + LPAREN
			+ "|\\" + LBRACKET
			+ "|\\" + LBRACE
			+ "|\\" + LESS_THAN + ")"
		);		

		private static var __quantifierRangeExpr:String =
			"(?:\\{(?:[0-9]+)(?:,[0-9]*)?\\})";
		
		private static var __quantifierRange:RegExp =
			new RegExp( "^(" + __quantifierRangeExpr + ")+$" );
				
		private static var __quantifiers:String =
			"(?:" + __quantifierRangeExpr + "|\\*|\\+|\\?){1}"
			+ "(?:\\?)?";	//additional lazy quantifier
		
		private static var __quantity:RegExp = new RegExp( "(" + __quantifiers + ")" );
		private static var __justquantity:RegExp = new RegExp( "^(" + __quantifiers + ")$" );
	}
}