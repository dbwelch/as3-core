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
			candidates:Array ):Boolean
		{
			
			trace("[MATCH TEST] MatchPattern::test()", extract( candidates ), regex, regex.test( "" + extract( candidates ) ) );

			//expecting a value but no valid list
			//of candidate objects
			if( candidates == null
				|| candidates.length == 0 )
			{
				return false;
			}
			
			return regex.test( "" + extract( candidates ) );
		}
	}
}