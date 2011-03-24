package org.flashx.utils.random {
	
	/**
	*	Utility functions for working with random values.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.08.2007
	*/
	public class RandomUtils extends Object {
		
		/**
		*	@private
		*/
		public function RandomUtils()
		{
			super();
		}
		
		/**
		*	Gets a random floating point number
		*	between the <code>minimum</code> and
		*	<code>maximum</code> values.
		*
		*	@minimum A <code>Number</code> of the
		*	minimum value range.
		*	@maximum A <code>Number</code> of the
		*	maximum value range.
		*
		*	@return A floating point <code>Number</code>
		*	in the given range.
		*/
		static public function getRandom( minimum:Number, maximum:Number ):Number
		{
			return minimum + ( Math.random() * ( maximum - minimum ) );
		}

		/**
		*	Gets a random integer between the
		*	<code>minimum</code> and
		*	<code>maximum</code> values.
		*	
		*	@minimum An integer of the
		*	<code>minimum</code> value range.
		*	@maximum An integer of the
		*	<code>maximum</code> value range.
		*
		*	@return A random integer in the given range.
		*/
		static public function getRandomInteger(
			minimum:int, maximum:int ):int
		{
			return Math.round( getRandom( minimum, maximum ) );
		}
		
		/**
		*	Gets a random <code>Boolean</code>.
		*
		*	@return A random <code>Boolean</code>.
		*/
		static public function getRandomBoolean():Boolean
		{
			return Boolean( Math.round( getRandom( 0, 1 ) ) );
		}		
	}
}