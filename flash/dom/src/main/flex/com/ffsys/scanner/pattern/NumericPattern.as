package com.ffsys.scanner.pattern
{
	import com.ffsys.scanner.*;
	
	/**
	* 	Represents a match rule.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.03.2011
	*/	
	public class NumericPattern extends Pattern
	{
		private var _id:uint = 0;
		
		/**
		* 	Creates a <code>NumericPattern</code> instance.
		* 
		* 	@param id The primary id to match against.
		*/
		public function NumericPattern( id:uint = 0 )
		{
			super();
			this.id = id;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function test( candidates:Vector.<Object> ):Boolean
		{
			trace("NumericPattern::test()", candidates );
			return false;
		}			
		
		/**
		* 	The primary id to match against.
		*/	
		public function get id():uint
		{
			return _id;
		}
		
		public function set id( value:uint ):void
		{
			_id = value;
			matched = "" + value;
			if( ids.indexOf( value ) == -1 )
			{
				ids.push( value );
			}
		}
	}
}