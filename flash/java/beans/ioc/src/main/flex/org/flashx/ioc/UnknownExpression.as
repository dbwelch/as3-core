package org.flashx.ioc
{

	/**
	*	Represents an unknown expression.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  01.01.2011
	*/
	public class UnknownExpression extends BeanResolver
	{
		/**
		* 	Creates an <code>UnknownExpression</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param value The name of the parsed value.
		*/
		public function UnknownExpression(
			beanName:String,
			name:String,
			value:String,
			expression:String,
			parameters:Array ):void
		{
			super( beanName, name, value );
			this.expression = expression;
			this.parameters = parameters;
		}
	}
}