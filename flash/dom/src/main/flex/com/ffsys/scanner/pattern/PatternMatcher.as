package com.ffsys.scanner.pattern
{
	/**
	* 	Validates a scan rule pattern
	* 	against a list of target objects.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/
	dynamic public class PatternMatcher extends Array
	{
		/**
		* 	The default target property name when matching against
		* 	numeric pattern parts.
		*/
		public static const NUMERIC:String = "id";
		
		/**
		* 	The default target property name when matching against
		* 	alphanumeric pattern parts.
		*/
		public static const NAMED:String = "name";
		
		private var _pattern:Vector.<Pattern>;
		private var _numericField:String = NUMERIC;
		private var _namedField:String = NAMED;		
		
		private var _owner:PatternMatcher;
		private var _position:uint = 0;
		
		/**
		* 	Creates a <code>PatternMatcher</code> instance.
		*/
		public function PatternMatcher()
		{
			super();
		}
		
		/**
		* 	An owner for this pattern matcher.
		*/
		public function get owner():PatternMatcher
		{
			return _owner;
		}
		
		/**
		* 	@private
		*/
		internal function setOwner( owner:PatternMatcher ):void
		{
			_owner = owner;
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
				for( i = 0;i < pattern.length;i++ )
				{
					part = pattern[ i ];
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
		* 	The target property name when matching against
		* 	numeric pattern parts.
		*/
		public function get numericField():String
		{
			return _numericField;
		}
		
		public function set numericField( value:String ):void
		{
			_numericField = value;
		}
		
		/**
		* 	The target property name when matching against
		* 	alphanumeric pattern parts.
		*/
		public function get namedField():String
		{
			return _namedField;
		}
		
		public function set namedField( value:String ):void
		{
			_namedField = value;
		}
		
		/**
		* 	The scan rule pattern to test against.
		*/
		public function get pattern():Vector.<Pattern>
		{
			if( _pattern == null )
			{
				_pattern = new Vector.<Pattern>();
			}
			return _pattern;
		}
		
		/**
		* 	The first part of this pattern.
		*/
		public function get first():Pattern
		{
			if( pattern.length > 0 )
			{
				return pattern[ 0 ];
			}
			return null;
		}
		
		/**
		* 	The last part of this pattern.
		*/
		public function get last():Pattern
		{
			if( pattern.length > 0 )
			{
				return pattern[ pattern.length - 1 ];
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
				if( pattern.length > 0
					&& part is PatternQuantifier )
				{
					last.quantifier = part as PatternQuantifier;
				}
				part.setOwner( this );
				pattern.push( part );
				return true;
			}
			return false;
		}
		
		private function getCandidate(
			candidates:Vector.<Object> ):Vector.<Object>
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
			return numericField;
		}
		
		/**
		* 	Tests whether the rule pattern matches
		* 	the candidates list.
		* 
		* 	@param candidates The list of candidate objects.
		* 
		* 	@return Whether the pattern matches the candidate list.
		*/
		public function test( candidates:Vector.<Object> ):Boolean
		{
			var empty:Boolean = candidates == null || candidates.length == 0;
			
			trace("[TEST] PatternMatcher::test() [CANDIDATES]", candidates );
			
			//copy the input
			if( !empty )
			{
				candidates = candidates.slice();
			}
			
			var parts:Vector.<Object> = null;
			
			var i:uint = 0;
			var g:uint = 0;								//nested group iterator
			var tmp:Vector.<Pattern> = pattern.slice();	//copy our pattern
			var l:uint = tmp.length;
			var candidate:Vector.<Object> = null;
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
				first = pattern[ 0 ];
				last = pattern[ pattern.length - 1 ];
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
				//parts = new Vector.<Object>( 1, true );
				return !empty
					&& candidates.length == 1
					&& first is MatchPattern
					&& first.test( candidates );
			}
			
			begins = first is MetaCharacter
				&& first.equals( MetaCharacter.STARTS_WITH );
			ends = first != last
				&& last is MetaCharacter
				&& last.equals( MetaCharacter.ENDS_WITH );
				
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
								
				if( part is PatternQuantifier )
				{
					//previous match pattern with no qualifier
					if( previous != null
					 	&& previous.handles()
						&& previous.quantifier == null )
					{
						previous.quantifier = part as PatternQuantifier;
					}
					trace("PatternMatcher::test()", "[SKIPPING QUANTIFIER]", part );
					continue;
				}	
				
				candidate = getCandidate( candidates );
				
				result = testChildGroups( part, candidates );
				
				//trace("PatternMatcher::test() begins/ends:", begins, ends );
				
			
				trace("[TEST] PatternMatcher::test()", _position, part );	
				
				result = part.match( field, candidate );
				
				trace("[RESULT] PatternMatcher::test()", _position, result );
				
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
		
		public function isGroup( pattern:Pattern ):Boolean
		{
			return pattern is PatternGroup;
		}
		
		/**
		* 	@private
		*/
		protected function testChildGroups(
			pattern:Pattern,
			candidates:Vector.<Object> ):Boolean
		{
			var g:uint = 0;
			var part:Pattern = null;
			var result:Boolean = true;
			var children:Vector.<Pattern>;			
			var candidate:Vector.<Object>;
			var field:String = getField( this );			
			
			//handle nested groups
			if( isGroup( pattern ) )
			{
				children = PatternGroup( pattern ).getGroups();
				if( children.length > 0 )
				{
					
					//trace("PatternMatcher::test()", "[FOUND NESTED CHILD GROUPS]", children, _position, candidate[ 0 ].id );
					
					for( g = 0;g < children.length;g++ )
					{
						part = children[ g ];
						
						trace("PatternMatcher::test()", "[FOUND NESTED CHILD GROUPS]", part, part.handles() );
						
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

							trace("PatternMatcher::test()", "[FOUND NESTED CHILD GROUPS RESULT]", result );
							
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
		* 	Gets a regular expression representation
		* 	of this pattern.
		* 
		* 	@return This pattern as a regular expression.
		*/
		public function toRegExp():RegExp
		{
			return new RegExp( toString() );
		}
		
		/**
		* 	Retrieves a string representation of this pattern.
		* 
		* 	@return A string representation of this pattern.
		*/
		public function toString():String
		{
			return pattern.join( "," );
		}
	}
}