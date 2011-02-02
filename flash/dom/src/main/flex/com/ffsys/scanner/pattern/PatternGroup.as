package com.ffsys.scanner.pattern
{
	import com.ffsys.scanner.*;
	
	/**
	* 	Represents a pattern group.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/	
	public class PatternGroup extends Pattern
	{
		public static const OPEN_GROUP:String = "(";
		
		public static const CLOSE_GROUP:String = ")";
		
		public static const OPEN_CLASS:String = "[";
		
		public static const CLOSE_CLASS:String = "]";
		
		public static const OPEN_MIN_MAX:String = "{";
		
		public static const CLOSE_MIN_MAX:String = "}";
		
		public static const POSITIVE_LOOKAHEAD:String = "?=";
		
		public static const NEGATIVE_LOOKAHEAD:String = "?!";
		
		public static const NON_CAPTURING:String = "?:";
		
		public static const NAMED:String = "?P";
		
		private var _open:Boolean = false;
		
		/**
		* 	Creates a <code>PatternGroup</code> instance.
		*/
		public function PatternGroup()
		{
			super();
		}
		
		/**
		* 	Retrieve patterns of this match that
		* 	are direct children not those of any
		* 	nested pattern group, essentially the
		* 	pattern parts that should match at the
		* 	current match position.
		* 
		* 	@return A list of child match patterns
		*/
		public function getChildMatchPatterns():Vector.<Pattern>
		{
			var output:Vector.<Pattern> = new Vector.<Pattern>();
			var part:Pattern = null;
			for( var i:int = 0;i < pattern.length;i++ )
			{
				part = pattern[ i ];
				//if( part.handles() )
				//{
					if( !( part is CaptureGroup ) )
					{
						output.push( part );
					}else{
						//stop when we encounter a nested
						//group as that constitutes the next
						//position in processing
						break;
					}
				//}
			}
			
			return output;
		}
		
		/**
		* 	Determines whether this group is currently open.
		*/
		public function get open():Boolean
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
		* 	Determines whether the candidate string
		* 	opens a group.
		* 
		* 	@param candidate The candidate string.
		* 
		* 	@return Whether the candidate opens a group.
		*/
		public function opens( candidate:String ):Boolean
		{
			var valid:Boolean = candidate == OPEN_GROUP
				|| candidate == OPEN_CLASS
				|| candidate == OPEN_MIN_MAX;
				
			if( valid )
			{
				_open = true;
			}
				
			return valid;
		}
		
		/**
		* 	Determines whether the candidate string
		* 	closes a group.
		* 
		* 	@param candidate The candidate string.
		* 
		* 	@return Whether the candidate closes a group.
		*/
		public function closes( candidate:String ):Boolean
		{
			var valid:Boolean = candidate == CLOSE_GROUP
				|| candidate == CLOSE_CLASS
				|| candidate == CLOSE_MIN_MAX;
			
			if( valid && _open )
			{
				_open = false;
			}
			
			return valid;
		}
		
		/**
		* 	Determines whether a candidate represents a valid
		* 	character sequence for candidates that are longer
		* 	than a single character.
		*/
		public function multiple( candidate:String ):Boolean
		{
			return candidate == POSITIVE_LOOKAHEAD
				|| candidate == NEGATIVE_LOOKAHEAD
				|| candidate == NON_CAPTURING
				|| candidate.indexOf( NAMED ) == 0
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function toString():String
		{
			//include the open group character with the
			//other parts of the pattern
			return matched + pattern.join( "" );
		}
	}
}