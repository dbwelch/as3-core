package com.ffsys.pattern
{
	/**
	* 	Represents a collection of patterns.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/
	dynamic public class PatternSet extends Array
	{	
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
		
		private var _patterns:Vector.<Pattern>;
		private var _name:String;
		private var _owner:PatternSet;
		private var _index:int = -1;
		
		/**
		* 	@private
		*/
		internal var _regex:RegExp;
		
		/**
		* 	Creates a <code>PatternSet</code> instance.
		*/
		public function PatternSet()
		{
			super();
		}
		
		/**
		* 	An owner for this pattern.
		*/
		public function get owner():PatternSet
		{
			return _owner;
		}
		
		/**
		* 	@private
		*/
		internal function setOwner( owner:PatternSet ):void
		{
			_owner = owner;
		}
		
		/**
		* 	The index of this pattern in the context
		* 	of an owner pattern.
		*/
		public function get index():int
		{
			return _index;
		}
		
		/**
		* 	@private
		*/
		internal function setIndex( index:int ):void
		{
			_index = index;
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
		* 	The first part of this pattern.
		*/
		public function get firstChild():Pattern
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
		public function get lastChild():Pattern
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
		* 	Clears this pattern so that it is empty.
		*/
		public function clear():void
		{
			_patterns = null;
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
				part.setOwner( this as Pattern );
				part.setIndex( patterns.length );
				patterns.push( part );
				return true;
			}
			return false;
		}
		
		/**
		*	Removes pattern(s) from this pattern.
		* 
		* 	@param start The index to start removing
		* 	from.
		* 	@param end The end index to stop removing from.
		* 
		* 	@return A pattern or <code>null</code> if the start
		* 	index is out of range.
		*/
		public function remove( start:int = -1, end:int = -1 ):Pattern
		{
			//behave like pop() by default
			if( start == -1 && patterns.length > 0 )
			{
				start = ( patterns.length == 1 ) ? 0 : patterns.length - 2;
			}
			
			if( start >= 0 && start < patterns.length )
			{
				if( end == -1 )
				{
					end = start + 1;
				}
				
				if( end <= start )
				{
					end = start + 1;
				}
				
				var count:uint = uint( end - start );
				patterns.splice( start, count );
			}
			return null;
		}
		
		/**
		* 	Retrieves a child pattern at the specified
		* 	index.
		* 
		* 	@param index The index for the child pattern.
		*
		* 	@return The pattern at the specified index
		* 	or <code>null</code> if the index is out of
		* 	bounds.
		*/
		public function getPatternAt( index:int ):Pattern
		{
			if( index < 0 || index >= patterns.length )
			{
				return null;
			}
			return this.patterns[ index ];
		}
		
		/**
		* 	Retrieves a copy of the last pattern
		* 	match results.
		*/
		public function get results():Array
		{
			//TODO: move to composite vector
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
			return false;
		}
		
		/**
		* 	The patterns belonging to this pattern.
		*/
		public function get children():Pattern
		{
			return null;
		}
		
		/**
		* 	A name for this pattern.
		*/
		public function get name():String
		{
			return _name;
		}
		
		public function set name( value:String ):void
		{
			_name = value;
		}
		
		/**
		* 	An <code>XML</code> representation of this pattern.
		*/
		public function get xml():XML
		{
			return null;
		}
		
		/**
		* 	A regular expression representation
		* 	of this pattern.
		*/
		public function get regex():RegExp
		{		
			return _regex;
		}
		
		/**
		* 	Gets a string representation of this pattern
		* 	that indicates it is a pattern as opposed to
		* 	a string or regular expression.
		* 
		* 	If this pattern is the root of a pattern hierarchy
		* 	it's string representation is encapsulated with pattern://,
		* 	otherwise the diminutive ptn:// is used.
		* 
		* 	@return A string representation of this pattern
		* 	that distinguishes it from a string or regular
		* 	expression.
		*/
		public function toPatternString():String
		{
			return null;
		}
		
		/**
		* 	Retrieves a string representation of this pattern.
		* 
		* 	@return A string representation of this pattern.
		*/
		public function toString():String
		{
			return null;
		}
		
		/**
		* 	Determines whether this pattern set is the
		* 	root of a pattern hierarchy.
		*/
		public function get root():Boolean
		{
			return ( owner == null );
		}
	}
}