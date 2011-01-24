package com.ffsys.css
{
	/**
	* 	A common type for combinator selectors.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class CombinatorSelector extends OperatorSelector
	{		
		/**
		* 	Creates a <code>CombinatorSelector</code> instance.
		* 
		* 	@param operand The operand for the expression.
		* 	@param operator An operator for the selector.
		* 	@param value A value for the expression.
		*/
		public function CombinatorSelector(
			operand:String = null,
			operator:String = null,
			value:String = null )
		{
			super( operand, operator, value );
		}
		
		/**
		* 	The delimiter for this combinator selector.
		*/
		public function get delimiter():RegExp
		{
			return null;
		}
	}
}