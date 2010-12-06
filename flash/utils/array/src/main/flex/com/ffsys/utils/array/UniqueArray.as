package com.ffsys.utils.array
{
	/**
	*	Responsible for ensuring array elements are unique.
	* 
	* 	This functionality uses strict equality for comparison
	* 	and ignores null values when performing duplicate comparison.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.06.2010
	*/
	public class UniqueArray extends Object
	{	
		/**
		* 	Creates a <code>UniqueArray</code> instance.
		*/
		public function UniqueArray()
		{
			super();
		}
		
		/**
		* 	@private
		* 
		* 	Determines whether an array element is unique.
		*/
		private function isUnique( element:*, index:int, arr:Array ):Boolean
		{
			return ( arr.indexOf( element ) == index );
		}
		
		/**
		* 	Creates a new array removing duplicate elements ensuring that
		* 	the elements are unique.
		* 
		* 	@param target The target array that should have unique elements.
		* 
		* 	@return A new array with duplicate elements removed.
		*/
		public function unique( target:Array ):Array
		{
			var output:Array = new Array();
			if( target != null )
			{
				output = target.filter( isUnique );
			}
			return output;
		}
	}
}