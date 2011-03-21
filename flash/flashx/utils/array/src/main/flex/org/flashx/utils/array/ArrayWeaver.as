/**
*	Utility classes for working with <code>Array</code> objects.
*/
package org.flashx.utils.array
{
	/**
	*	Responsible for interleaving the elements of multiple
	* 	arrays into a single array.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  28.05.2010
	*/
	public class ArrayWeaver extends Object
	{	
		/**
		* 	Creates an <code>ArrayWeaver</code> instance.
		*/
		public function ArrayWeaver()
		{
			super();
		}
		
		/**
		* 	Interleaves the elements of multiple arrays into a single array.
		* 
		* 	@param args The arrays to interleave.
		* 
		* 	@return The interleaved array.
		*/
		public function interleave( ... args ):Array
		{
			var output:Array = new Array();
			var candidates:Array = new Array();
			
			var i:int = 0;
			//find array elements from the arguments
			for( i = 0;i < args.length;i++ )
			{
				if( args[ i ] is Array )
				{
					candidates.push( args[ i ] );
				}
			}
			
			//now find the maximum array length
			var maximum:int = 0;
			for( i = 0;i < candidates.length;i++ )
			{
				maximum = Math.max( maximum, candidates[ i ].length );
			}
			
			var candidate:Array = null;
			for( i = 0;i < maximum;i++ )
			{
				for( var j:int = 0;j < candidates.length;j++ )
				{
					candidate = candidates[ j ];				
					
					//the index is out of bounds for the candidate
					//so remove the candidate
					if( i == candidate.length )
					{
						candidates.splice( j, 1 );
						j--;
						continue;
					}		
					//add the candidates element to the output
					output.push( candidate[ i ] );						
				}
			}
			
			return output;
		}
		
		/**
		* 	Interleaves the elements of multiple arrays into a single array.
		* 
		* 	This methods expects the arrays to interleave to be elements
		* 	of the <code>target</code> parameter.
		* 
		* 	@param target The target array containing the arrays to interleave.
		* 
		* 	@return The interleaved array.
		*/
		public function weave( target:Array ):Array
		{
			return interleave.apply( this, target );
		}
	}
}