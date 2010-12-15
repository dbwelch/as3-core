package com.ffsys.di
{
	
	/**
	*	Represents a bean method reference.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanMethod extends BeanResolver
		implements IBeanResolver {
			
		/**
		* 	Creates a <code>BeanMethod</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param value The parsed value.
		*/
		public function BeanMethod(
			beanName:String = null,
			name:String = null,
			value:String = null ):void
		{
			super( beanName, name, value );	
		}

		/**
		* 	This method differs from other implementations in that it expects
		* 	the <code>bean</code> parameter to be the object that contains
		* 	the method reference.
		* 
		* 	@inheritDoc
		*/
		public function resolve(
			document:IBeanDocument,
			descriptor:IBeanDescriptor,
			bean:Object ):Object
		{
			if( document != null )
			{
				var method:Object = null;

				try
				{
					method = bean[ this.value ];
				}catch( e:Error )
				{
					throw new Error( "Could not locate method reference with identifier '" + this.value + "'." );
				}

				if( method && !( method is Function ) )
				{
					throw new Error( "The method reference '" + this.value + "' does not correspond to a function." );
				}

				return method as Function;
			}
			return null;
		}
	}
}