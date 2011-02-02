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
					&& part is QuantifierPattern )
				{
					last.quantifier = part as QuantifierPattern;
				}
				part.setOwner( this );
				pattern.push( part );
				return true;
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
		public function test( candidates:Vector.<Object> ):Boolean
		{
			var empty:Boolean = candidates == null || candidates.length == 0;
			
			//copy the input
			if( !empty )
			{
				candidates = candidates.slice();
			}
			
			var parts:Vector.<Object> = null;
			
			var i:uint = 0;
			var l:uint = pattern.length;
			var candidate:Vector.<Object> = null;
			var begins:Boolean = false;
			var ends:Boolean = false;
			var part:Pattern = null;
			var next:Pattern = null;
						
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
			
			trace("PatternMatcher::test() [GOT LAST]", last, pattern.length );
			
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
			
			var result:Boolean = true;
			var matches:Boolean = true;
			var field:String = numericField;
			var expected:*;
				
			for( ;i < l;i++ )
			{
				part = pattern[ i ];
				isMatchPattern = part.handles();
				if( begins && i == 0 )
				{
					//candidate = new Vector.<Object>();
					candidates.unshift( first );
				}else if( ends && i == ( l - 1 ) )
				{
					//candidate = new Vector.<Object>();
					candidates.push( last );
				}
				
				candidate = candidates.slice( i, i + 1 );
				
				/*
				if( i < ( pattern.length - 1 ) )
				{
					next = pattern[ i + 1 ];
				}
				*/
				
				expected = part.value;
				
				trace("PatternMatcher::test() begins/ends:", begins, ends );
				
				matches = part.match( field, expected, candidate );
			
				trace("PatternMatcher::test()", matches );
				
				if( !matches )
				{
					//starts with failed to match
					//or a match that is begin and end qualified ^.*$
					//failed to match
					if( ( begins
						&& i == 1 )
						|| ( begins && ends ) )
					{
						result = false;
						break;
					}
				}
			}
			return result;
		}
		
		public function toString():String
		{
			return pattern.join( "," );
		}
	}
}