package java.util.regex
{
	/**
	* 	An engine that performs match operations on a character
	* 	sequence by interpreting a Rule.
	* 
	* 	A matcher is created from a rule by invoking the rule's matcher method.
	* 	Once created, a matcher can be used to perform three different kinds of match operations:
	* 
	* 	<ul>
	* 		<li>The matches method attempts to match the entire
	* 		input sequence against the pattern.</li>
	* 		<li>The lookingAt method attempts to match the input sequence,
	* 		starting at the beginning, against the pattern.</li>
	* 		<li>The find method scans the input sequence looking for the
	* 		next subsequence that matches the pattern.</li>
	* 	</ul>
	* 
	* 	Each of these methods returns a boolean indicating success or failure.
	* 	More information about a successful match can be obtained by querying
	* 	the state of the matcher.
	* 
	* 	A matcher finds matches in a subset of its input called the region.
	* 	By default, the region contains all of the matcher's input. The region
	* 	can be modified via theregion method and queried via the regionStart
	* 	and regionEnd methods. The way that the region boundaries interact with
	* 	some pattern constructs can be changed. See useAnchoringBounds and
	* 	useTransparentBounds for more details.
	* 
	* 	This class also defines methods for replacing matched subsequences
	* 	with new strings whose contents can, if desired, be computed from the
	* 	match result. The appendReplacement and appendTail methods can be used
	* 	in tandem in order to collect the result into an existing string buffer,
	* 	or the more convenient replaceAll method can be used to create a string
	* 	in which every matching subsequence in the input sequence is replaced.
	* 
	* 	The explicit state of a matcher includes the start and end indices of
	* 	the most recent successful match. It also includes the start and end
	* 	indices of the input subsequence captured by each capturing group in
	* 	the pattern as well as a total count of such subsequences. As a convenience,
	* 	methods are also provided for returning these captured subsequences in string form.
	* 
	* 	The explicit state of a matcher is initially undefined; attempting to
	* 	query any part of it before a successful match will cause an IllegalStateException
	* 	to be thrown. The explicit state of a matcher is recomputed by every match operation.
	* 
	* 	The implicit state of a matcher includes the input character sequence as well
	* 	as the append position, which is initially zero and is updated by the
	* 	appendReplacement method.
	* 
	* 	A matcher may be reset explicitly by invoking its reset() method or,
	* 	if a new input sequence is desired, its reset(CharSequence) method. Resetting a
	* 	matcher discards its explicit state information and sets the append position to zero.
	*/
	public class Matcher extends Object
		implements MatchResult
	{
		private var _ptn:Pattern;
		private var _input:*;
		
		/**
		* 	@private
		* 	
		* 	Creates a <code>Matcher</code> instance.
		* 
		* 	@param ptn The pattern this matcher is using.
		* 	@param input The input to use for matching.
		*/
		public function Matcher( ptn:Pattern, input:* )
		{
			super();
			_ptn = ptn;
			_input = input;
		}
		
		/**
		* 	Retrieves a copy of the last pattern
		* 	match results.
		*/
		public function get results():Array
		{
			//TODO: move to composite vector
			//return slice();
			return null;
		}
		
		/**
		* 	Retrieves a list of the matches
		* 	that failed during the last pattern
		* 	match.
		*/
		public function get failures():Vector.<PatternMatch>
		{
			var output:Vector.<PatternMatch> =
				new Vector.<PatternMatch>();
			var match:PatternMatch = null;
			for( var i:int = 0;i < results.length;i++ )
			{
				match = PatternMatch( results[ i ] );
				if( !match.result )
				{
					output.push( match );
				}
			}
			return output;
		}		
		
		/**
		* 	@inheritDoc
		*/
		public function start( group:int = -1 ):int
		{
			return -1;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function end( group:int = -1 ):int
		{
			return -1;			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function group( group:int = -1 ):int
		{
			return -1;			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function groupCount():int
		{
			if( _ptn != null )
			{
				return _ptn.groupCount();
			}
			return 0;
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
		public function test( value:* ):Boolean
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
				matched = match( _ptn, value );
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
			var re:RegExp = _ptn.regex;
			//comparing against an object property
			if( _ptn.field != null && value.hasOwnProperty( _ptn.field ) )
			{
				//access the underlying property and
				//coerce to a string
				value = "" + value[ _ptn.field ];
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
				output = _ptn.createPattern();
			}
			
			if( targets == null )
			{
				targets = new Vector.<Pattern>();
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
						grp = _ptn.createPattern();
						grp.appendChild( _ptn.createPattern( Pattern.LPAREN ) );	
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
								grp.appendChild( _ptn.createPattern( Pattern.RPAREN ) );
								grp.appendChild( _ptn.createPattern( Pattern.LPAREN ) );
								grp.appendChild( next );					
							}else
							{
								grp.appendChild( next );
								//trace("[FOUND QUANTIFIER/CHUNK ADD TO PREVIOUS] Pattern::explode()", next, ptn, grp );								
							}
						}
						grp.appendChild( _ptn.createPattern( Pattern.RPAREN ) );
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
					output.appendChild( _ptn.createPattern( Pattern.LPAREN ) );
				}
				
				//create a group to encapsulate
				//each extracted group
				var tmp:Pattern = _ptn.createPattern();
				
				//double the opening group so we maintain
				//the original grouping
				tmp.appendChild( _ptn.createPattern( Pattern.LPAREN ) );
				
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
								if( next.toString().indexOf( Pattern.LESS_THAN ) == 0 )
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
			tmp.appendChild( _ptn.createPattern( Pattern.RPAREN ) );
					
			if( i < ( l - 1 ) )
			{
				l = ptns.length;
				if( ptns[ l - 1 ] is Pattern
				 	&& ptns[ l - 1 ].source == Pattern.RPAREN )
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
				output.appendChild( _ptn.createPattern( Pattern.RPAREN ) );
			}
			return tmp;
		}
		
		/**
		* 	@private
		*/
		internal function requiresGrouping():Boolean
		{
			if( _ptn.group )
			{
				//trace("[REQUIRES GROUPING] Pattern::requiresGrouping()", toString() );
				
				var ptns:PatternList = _ptn as PatternList;
				var ptn:Pattern = null;
				var groups:uint = 0;
				var alternators:uint = 0;
				for( var i:int = 0;i < ptns.childNodes.length;i++ )
				{
					ptn = ptns.childNodes[ i ];
					if( ptn.group )
					{
						groups++;
					}
					
					if( ptn.source == Pattern.PIPE )
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
	}
}