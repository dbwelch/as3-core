package com.ffsys.ioc
{
	/**
	*	Represents a bean constant reference.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanConstant extends BeanResolver
		implements IBeanResolver {

		/**
		* 	Creates a <code>BeanConstant</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param value The parsed value.
		*/
		public function BeanConstant(
			beanName:String = null,
			name:String = null,
			value:String = null ):void
		{
			super( beanName, name, value );		
		}

		/**
		* 	@inheritDoc
		*/
		public function resolve(
			document:IBeanDocument,
			descriptor:IBeanDescriptor,
			bean:Object ):Object
		{
			if( document != null )
			{
				var constants:Object = document.constants;

				if( constants == null )
				{
					throw new Error( "Cannot handle a constant reference expression with no declared constants." );
				}

				//convert to camel case
				var camel:String = toCamelCase();
				if( !constants.hasOwnProperty( camel ) )
				{
					throw new Error( "The constant reference '" + camel + "' has not been declared." );
				}

				//extract the constant from the constants bean declaration
				var value:Object = constants[ camel ];
				return value;
			}
			return null;
		}
	}
}