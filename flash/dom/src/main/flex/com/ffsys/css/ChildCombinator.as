package com.ffsys.css
{
	/**
	* 	A combinator selector for child elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class ChildCombinator extends CombinatorSelector
	{		
		/**
		* 	Creates a <code>ChildCombinator</code> instance.
		* 
		* 	@param operand The operand for the expression.
		* 	@param operator An operator for the selector.
		* 	@param value A value for the expression.
		*/
		public function ChildCombinator(
			operand:String = null,
			operator:String = null,
			value:String = null )
		{
			super( operand, operator, value );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get delimiter():RegExp
		{
			return />+/;
		}
	}
}