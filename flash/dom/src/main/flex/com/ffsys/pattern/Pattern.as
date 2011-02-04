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
	dynamic public class Pattern extends Array
	{
		private static var __group:RegExp = new RegExp(
			"^(?:"
			+ "\\" + LPAREN
			+ "|\\" + OPEN_RANGE
			+ "|\\" + OPEN_MIN_MAX
			+ "|\\" + OPEN_NAME + ")"
		);
		
		/**
		* 	The delimiter used to mark the
		* 	beginning and end of a pattern.
		*/
		public static const DELIMITER:String = "/";
		
		/**
		* 	The name for a root pattern.
		*/
		public static const PATTERN:String = "pattern";
		
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
		* 	A meta character that indicates the start position.
		*/
		public static const CARET:String = "^";
		
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
		public static const PIPE:String = "|";
		
		/**
		* 	A meta character that indicates a range.
		*/
		public static const HYPHEN:String = "-";
		
		/**
		* 	A meta character that indicates zero or one occurence.
		*/
		public static const QUESTION_MARK:String = "?";	
		
		/**
		* 	A meta character that indicates the end position.
		*/
		public static const DOLLAR:String = "$";
		
		//
		public static const LPAREN:String = "(";
		
		public static const RPAREN:String = ")";
		
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
		
		private var _patterns:Vector.<Pattern>;
		private var _parts:Pattern;
		private var _owner:Pattern;
		private var _position:uint = 0;
		private var _source:* = NaN;
		private var _field:String;
		private var _name:String;
		
		//the actual regex we use for matching
		//this is required as the source property is read only
		//and we want to instantiate a new regex when our source property has changed
		private var _regex:RegExp;

		private var _open:Boolean = false;
		
		//stores the minimum and maximum occurences
		//for this pattern
		internal var min:uint = 1;
		internal var max:uint = 1;
		
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
				|| source == NAMED
				|| namedQualifier );
		}
		
		public function get namedQualifier():Boolean
		{
			var src:String = toString();
			var namedStart:int = src.indexOf( OPEN_NAME );
			var namedEnd:int = src.indexOf( CLOSE_NAME );
			
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
			return ( source == ASTERISK
				|| source == PLUS
				|| source == QUESTION_MARK
				|| quantifierRange );
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
		* 	A list of patterns belonging to this pattern.
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
		* 	Determines whether this pattern
		* 	has any patterns.
		*/
		public function get empty():Boolean
		{
			return patterns.length == 0;
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
			return root && !empty && first.source == CARET;
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
			return root && !empty && last.source == DOLLAR;
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
			if( index < 0 || index >= patterns.length )
			{
				return null;
			}
			return this.patterns[ index ];
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
		* 	Retrieves a copy of the last pattern
		* 	match results.
		*/
		public function get results():Array
		{
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
		
		
		public function get children():Pattern
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
						|| ptn.qualifier() )
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
			return ( source != null && source == OPEN_RANGE )
				|| this.group && ( first.toString() == OPEN_RANGE );
		}
		
		/**
		* 	Determines whether this pattern is a character
		* 	range and is negated, <code>[^0-9]</code>.
		*/
		public function get negated():Boolean
		{
			return range && first != null && first.source == CARET;
		}
		
		/**
		* 	Determines whether this pattern is a quantifier
		* 	range, <code>{1,2}</code>.
		*/
		public function get quantifierRange():Boolean
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
		* 	A name for this pattern.
		*/
		public function get name():String
		{
			if( _name )
			{
				return _name;
			}
			
			var nm:String = null;
			
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
			
			return nm == null ? "pattern" : nm;
		}
		
		public function set name( value:String ):void
		{
			_name = value;
		}
		
		public function get xml():XML
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
				return x;
			}
			
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
			
			if( root )
			{
				x.@begins = begins;
				x.@ends = ends;				
				x.appendChild( new XML( "<source><![CDATA[" + this.source + "]]></source>" ) );
				
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
				for( i = 0;i < ptns.length;i++ )
				{
					ptn = ptns[ i ];
					child = ptn.xml;
					children.appendChild( child );
				}
			}
			
			return x;
		}
		
		public function toPatternString():String
		{
			var prefix:String = root ? PATTERN : PTN;
			return prefix + ":" + DELIMITER + toString() + DELIMITER;
		}
		
		/**
		* 	Retrieves a string representation of this pattern.
		* 
		* 	@return A string representation of this pattern.
		*/
		public function toString():String
		{
			var delimiter:String = "";
			if( name == PARTS )
			{
				delimiter = ",";
			}
			return patterns.length > 0 ? patterns.join( delimiter ) : _source;
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
				|| char == CARET
				|| char == ASTERISK
				|| char == DOT
				|| char == PLUS
				|| char == QUESTION_MARK
				|| char == DOLLAR
				|| char == PIPE
				|| char == HYPHEN
				|| char == LPAREN
				|| char == RPAREN
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
				source == Pattern.LPAREN
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
				source == Pattern.RPAREN
				|| source == Pattern.CLOSE_RANGE
				|| source == Pattern.CLOSE_MIN_MAX
				|| source == Pattern.CLOSE_NAME );
			
			if( valid && _open )
			{
				_open = false;
			}
			return valid;
		}
		
		/**
		* 	@private
		*/
		internal function get root():Boolean
		{
			return ( owner == null );
		}
		
		/**
		* 	Builds a candidate string to the patterns
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

				var current:Pattern = null;				
						
				trace("[CANDIDATE] PatternBuilder::build()", candidate );

				//candidate for valid actionscript property names
				var prop:String = "(?:[a-zA-Z_\\$]{1}[a-zA-Z0-9_\\$]*)";

				//candidate for group capturing
				var namedgroup:String = "";

				//the main expression used to capture regex special characters
				var expr:String = "\\\\?(?:\\?!|\\?:|\\?=|\\?P|\\[|\\]|\\?|\\+|[(){}*\\|^\\$:<>.\\-]){1}";

				var re:RegExp = new RegExp( "(" + expr + ")" );
				var results:Array = re.exec( candidate );

				trace("PatternBuilder::build()", re, results );

				//no regex special character match
				if( results == null )
				{
					ptn = new Pattern( candidate );
					parentTarget.add( ptn );
					parts.add( ptn );
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
					parts.add( ptn );					
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
						if( !( ptn.source == OPEN_NAME ) )
						{
							parts.add( ptn );
						}
						
						//add the opening meta group character
						//to a pattern used to represent the entire
						//group contents
						current = new Pattern( ptn.source );
						current.add( ptn );
						current.setOpen( true );
						ptn = current;
						//trace("PatternBuilder::build() [OPENING GROUP]", current, parentTarget );
					
						//trace("PatternBuilder::build() [OPENING GROUP NEW PARENT]", parentTarget );
					}else
					{
						if( !ptn.qualifier()
							&& !( ptn.source == CLOSE_NAME ) )
						{
							parts.add( ptn );
						}
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
						//opening a group update the parent target *after* adding the group
						parentTarget = current;
						//trace("PatternBuilder::build() [OPENING GROUP - OWNER IS THIS]", current.owner == this );
					}
					
					//trace("[ADDING PATTERN] PatternBuilder::build()", ptn, parentTarget );					
					
					if(	closes
						&& current != null )
					{
						current.setOpen( false );
						//trace("PatternBuilder::build()", "[CLOSING GROUP]", ptn, current, parentTarget, current.owner == this );
						parentTarget = current.owner;
						current = parentTarget;
					}

					//look for the next meta character sequence
					var next:int = candidate.search( re );
					if( next > 0 )
					{
						//extract the non-meta character chunk
						chunk = candidate.substr( 0, next );
						ptn = new Pattern( chunk );	
						
						//chomp the string
						candidate = candidate.substr( chunk.length );
						
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
						}else
						{
							parts.add( ptn );
						}
						
						parentTarget.add( ptn );

						///trace("[ADDING CHUNK] PatternBuilder::build()", chunk, parentTarget );
					}
					
					//trace("[NEW LENGTH] Pattern::build()", patterns.length );
					
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

				//trace("[MATCHES] PatternBuilder::build()", this, patterns.length, patterns );
			}
		}				
	}
}