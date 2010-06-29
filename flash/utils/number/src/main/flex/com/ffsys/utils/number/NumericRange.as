package com.ffsys.utils.number {
	
	/**
	*	Represents a range between two numeric values.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.08.2007
	*/
	public class NumericRange extends Object {
		
		/**
		*	@private	
		*/
		private var _start:Number;
		
		/**
		*	@private
		*/
		private var _end:Number;
		
		/**
		*	Creates a <code>NumericRange</code> with
		*	the range defined by <code>start</code> and
		*	<code>end</code>.
		*	
		*	@param start The <code>start</code> value for the range.
		*	@param end The <code>end</code> value for the range.
		*/
		public function NumericRange(
			start:Number = 0, end:Number = 1 )
		{
			super();
			this.start = start;
			this.end = end;
		}
		
		/**
		*	The <code>start</code> value for the range.
		*/
		public function set start( val:Number ):void
		{
			_start = val;
		}
		
		public function get start():Number
		{
			return _start;
		}
		
		/**
		*	The <code>end</code> value for the range.
		*/		
		public function set end( val:Number ):void
		{
			_end = val;
		}
		
		public function get end():Number
		{
			return _end;
		}
		
		/**
		* 	Inverts the start and end values for this numeric range.
		*/
		public function invert():void
		{
			//store the start value
			var startValue:Number = _start;
			_start = this.end;
			_end = startValue;
		}
	}
}