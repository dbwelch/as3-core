/**
*	Utility classes for working with boolean values.
*/
package org.flashx.utils.boolean {
	
	/**
	*	Utility methods for working with boolean types.
	*	
	*	This is useful when deserializing <code>String</code>
	*	values to <code>Boolean</code> values.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.06.2007
	*/
	public class BooleanUtils extends Object {
		
		/**
		*	Constant representing a <code>true</code> value.
		*/
		static public const TRUE_STRING:String = "true";
		
		/**
		*	Constant representing a <code>false</code> value.
		*/
		static public const FALSE_STRING:String = "false";
		
		/**
		*	@private
		*/
		public function BooleanUtils()
		{
			super();
		}
		
		/**
		*	Determines whether a given <code>String</code>
		*	consists of either a <code>true</code> or
		*	<code>false</code> literal value.
		*	
		*	@param source The <code>String</code> to inspect.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	<code>source</code> contains a <code>Boolean</code>
		*	value.
		*/
		static public function stringIsBoolean( source:String ):Boolean
		{
			return ( source == TRUE_STRING || source == FALSE_STRING );
		}
		
		/**
		*	Returns a <code>Boolean</code> corresponding to
		*	the <code>String</code> value contained within
		*	<code>source</code>.
		*	
		*	Prior to calling this method you should test
		*	that the <code>source</code> value does contain a
		*	<code>Boolean</code> value
		*	by calling <code>stringIsBoolean</code>.
		*	
		*	@param source The <code>String</code> to convert to a
		*	<code>Boolean</code> value.
		*	
		*	@return <code>true</code> if the <code>source</code> equals
		*	<code>true</code> otherwise <code>false</code>.
		*	
		*	@see com.ffsys.utils.boolean.BooleanUtils#stringIsBoolean
		*/
		static public function stringToBoolean( source:String ):Boolean
		{
			if( source == TRUE_STRING )
			{
				return true;
			}
			return false;
		}
	}
}