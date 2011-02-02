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
		private var _qualifier:QualifierPattern;
		
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
		* 	Retrieves a string representation of this scan rule.
		* 
		* 	@return A string representation of this scan rule.
		*/
		override public function toString():String
		{
			return matched != null ? matched : ids.join( "" );
		}
	}
}