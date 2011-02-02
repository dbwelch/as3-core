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
		
		/**
		* 	Creates a <code>PatternMatcher</code> instance.
		*/
		public function PatternMatcher()
		{
			super();
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
		* 	Adds a scan rule to the pattern to test
		* 	against.
		* 	
		* 	@param rule The scan rule to add.
		* 
		* 	@return Whether the scan rule was added.
		*/
		public function add( rule:Pattern ):Boolean
		{
			if( rule != null )
			{
				pattern.push( rule );
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
					&& first is NumericPattern
					&& first.test( candidates );
			}
			
			begins = first is MetaCharacter
				&& first.equals( MetaCharacter.STARTS_WITH );
			ends = first != last
				&& last is MetaCharacter
				&& last.equals( MetaCharacter.ENDS_WITH );
			
			/*
			//pad the candidates list to match any begin/end qualifiers	
			if( begins )
			{
				candidates.unshift( first );
			}
			if( ends )
			{
				candidates.push( last );
			}
			*/
				
			for( ;i < l;i++ )
			{
				part = pattern[ i ];
				isMatchPattern = part is NumericPattern;
				if( begins && i == 0 )
				{
					candidate = new Vector.<Object>();
					candidate.push( first );
				}else if( ends && i == ( l - 1 ) )
				{
					candidate = new Vector.<Object>();
					candidate.push( last );
				}else{
					candidate = candidates.slice( i, i + 1 );
				}
				
				if( i < ( pattern.length - 1 ) )
				{
					next = pattern[ i + 1 ];
				}

				trace("PatternMatcher::test()", part, isMatchPattern, candidate, part.test( candidate ) );
			}
			return true;
		}
		
		public function toString():String
		{
			return pattern.join( "," );
		}
	}
}