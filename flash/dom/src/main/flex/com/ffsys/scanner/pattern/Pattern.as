package com.ffsys.scanner.pattern
{
	import com.ffsys.scanner.*;
	
	/**
	* 	Represents a scan rule.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/	
	public class Pattern extends PatternMatcher
	{
		private var _ids:Vector.<uint> = null;
		private var _quantifier:PatternQuantifier;
		private var _value:* = NaN;
		
		/**
		* 	@private
		* 
		* 	A string match for this rule when built
		* 	from a string definition.
		*/
		internal var matched:String = null;
		
		/**
		* 	Creates a <code>Pattern</code> instance.
		*/
		public function Pattern( ids:Vector.<uint> = null )
		{
			super();
			this.ids = ids;
		}
		
		/**
		* 	Determines whether this pattern is an alternator.
		*/
		public function get alternator():Boolean
		{
			return matched == MetaCharacter.ALTERNATOR;
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
		* 	Determines whether this pattern handles
		* 	pattern matching.
		*/
		public function handles():Boolean
		{
			return this is MatchPattern || this is CaptureGroup
				|| character( this.value );
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
			return MetaCharacter.character( value );
		}
		
		/**
		* 	A quantifier associated with this pattern.
		*/
		public function get quantifier():PatternQuantifier
		{
			return _quantifier;
		}
		
		public function set quantifier( value:PatternQuantifier ):void
		{
			_quantifier = value;
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
			return false;
		}
		
		/**
		* 	A list of ids that this rule should match against.
		*/
		public function get ids():Vector.<uint>
		{
			if( _ids == null )
			{
				_ids = new Vector.<uint>();
			}
			return _ids;
		}
		
		public function set ids( value:Vector.<uint> ):void
		{
			_ids = value;
		}
		
		/**
		* 	The value to match against a candidate property
		* 	value.
		*/	
		public function get value():*
		{
			return _value;
		}
		
		public function set value( value:* ):void
		{
			_value = value;
			matched = "" + value;
			if( value is int
				&& ids.indexOf( value ) == -1 )
			{
				ids.push( value );
			}
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
			return matched == comparison;
		}
		
		/**
		* 	Determines whether this scan rule matches
		* 	the specified list of candidates.
		* 
		* 	@param candidates The list of candidate idss.
		* 
		* 	@return Whether this rule matches the candidate idss
		* 	exactly.
		*/
		public function compare( candidates:Vector.<uint> ):Boolean
		{
			return false;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function toString():String
		{
			return matched != null ? matched : ids.join( "" );
		}
	}
}