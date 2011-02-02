package com.ffsys.scanner.pattern
{
	import com.ffsys.scanner.*;
	
	/**
	* 	Represents a pattern part used to match
	* 	against the property value of a target
	* 	object.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/	
	public class MatchPattern extends Pattern
	{		
		/**
		* 	Creates a <code>MatchPattern</code> instance.
		* 
		* 	@param value The value to match against.
		*/
		public function MatchPattern( value:* = NaN )
		{
			super();
			this.value = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function match(
			field:String,
			expected:*,
			candidates:Vector.<Object> ):Boolean
		{
			
			trace("MatchPattern::test()", field, this.value, candidates );			
			
			//expecting a value but no valid list
			//of candidate objects
			if( expected is Object
				&& field == null
				|| candidates == null
				|| candidates.length == 0 )
			{
				return false;
			}
			
			if( candidates.length == 1 )
			{
				var target:Object = candidates[ 0 ];
				var hasProp:Boolean = target != null
					&& target.hasOwnProperty( field );
				if( hasProp )
				{
					var value:* = target[ field ];
					return value === this.value;
				}
			}
			
			return false;
		}
	}
}