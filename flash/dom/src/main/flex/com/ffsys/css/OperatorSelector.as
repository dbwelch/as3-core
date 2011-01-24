package com.ffsys.css
{
	/**
	* 	A common type for selectors that have an operator.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	public class OperatorSelector extends Selector
	{
		private var _operand:String;
		private var _operator:String;
		private var _value:String;
		
		/**
		* 	Creates a <code>OperatorSelector</code> instance.
		* 
		* 	@param operator The operator for the selector.
		*/
		public function OperatorSelector(
			operand:String = null,
			operator:String = null,
			value:String = null )
		{
			super();
			this.operand = operand;
			this.operator = operator;
			this.value = value;
		}
		
		/**
		* 	A operand value prior to the operator.
		*/
		public function get operand():String
		{
			return _operand;
		}
		
		public function set operand( value:String ):void
		{
			_operand = value;
		}
		
		/**
		* 	The operator for the selector.
		*/
		public function get operator():String
		{
			return _operator;
		}
		
		public function set operator( value:String ):void
		{
			_operator = value;
		}
		
		/**
		* 	A value after the operator.
		*/
		public function get value():String
		{
			return _value;
		}
		
		public function set value( value:String ):void
		{
			_value = value;
		}		
	}
}