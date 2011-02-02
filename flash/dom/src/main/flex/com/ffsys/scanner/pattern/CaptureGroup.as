package com.ffsys.scanner.pattern
{
	import com.ffsys.scanner.*;
	
	/**
	* 	Represents a group rule.
	* 
	* 	Groups alternate by default which described
	* 	in terms of a regular expression would look like
	* 	<code>(1|2|3)</code>. This example would match
	* 	a single token with an <code>id</code> of
	* 	either 1, 2 or 3.
	* 
	* 	When a group does not alternate it behaves
	* 	like a character class which described
	* 	in terms of a regular expression would look like
	* 	<code>[123]</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/	
	public class CaptureGroup extends Pattern
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
		* 	Creates a <code>CaptureGroup</code> instance.
		*/
		public function CaptureGroup()
		{
			super();
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
			
			if( valid )
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
	}
}