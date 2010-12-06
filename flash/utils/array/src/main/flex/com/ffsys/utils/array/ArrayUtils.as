package com.ffsys.utils.array {
	
	/**
	*	Utility methods for working with
	*	array instances.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.07.2007
	*/
	public class ArrayUtils extends Object {
		
		/**
		*	@private	
		*/
		public function ArrayUtils()
		{
			super();
		}
		
		/**
		*	Fills an <code>Array</code> with references to
		*	<code>instance</code> the number of times
		* 	specified by the <code>length</code> parameter.
		*	
		*	If the <code>instance</code> parameter is a <code>Number</code>
		*	and the <code>multiply</code> flag is specified each entry
		*	in the <code>Array</code> will be multiplied by it's index in
		*	the <code>Array</code>.
		*	
		*	@param instance The <code>Object</code> to fill the <code>Array</code> with.
		*	@param length The length of the filled <code>Array</code>.
		*	@param multiply A flag indicating whether numeric values should be multiplied
		*	by their index.
		*	
		*	@return The filled <code>Array</code>.
		*/
		static public function fill(
			instance:Object,
			length:int,
			multiply:Boolean = false ):Array
		{
			var output:Array = new Array();
			var i:int = 0;
			
			var val:Object;
			
			for( ;i < length;i++ )
			{
				val = instance;

				if( ( instance is Number ) && multiply )
				{
					val = Number( instance ) * i;
				}
				
				output.push( val );
			}
			
			return output;
		}
		
		/**
		*	Determines whether an <code>Array</code>
		*	contains a given <code>Object</code>.
		*	
		*	If the <code>source</code> is <code>null</code>
		*	or empty this method will return <code>false</code>.
		*	
		*	@param source The <code>Array</code> to inspect.
		*	@param value The <code>Object</code> to search for.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	<code>value</code> exists in <code>source</code>.
		*/
		static public function contains(
			source:Array, value:Object ):Boolean
		{
			//--> refactor to use Array.indexOf()
			
			if( source )
			{			
				var i:int = 0;
				var l:int = source.length;
			
				for( ;i < l;i++ )
				{
					if( source[ i ] === value )
					{
						return true;
					}
				}
			}
			
			return false;
		}
	}
}