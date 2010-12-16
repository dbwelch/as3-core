package com.ffsys.ioc
{
	
	/**
	*	Represents a bean method invocation.
	* 
	* 	This will invoke a method on a static or instance class.
	* 
	* 	The first parameter to this expression is the name of the method
	* 	to call and any remaining parameters are passed to the method when
	* 	it is invoked.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public class BeanMethodCall extends BeanResolver
		implements IBeanResolver {
			
		/**
		* 	Creates a <code>BeanMethodCall</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param value The parsed value.
		*/
		public function BeanMethodCall(
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
				var methodName:String = String( this.value );
				var result:* = null;
				var parameterStartIndex:int = this.value.indexOf( "," );
				var parameters:String = null;
				var params:Array = [];		
				if( parameterStartIndex > -1 )
				{
					parameters = strip( this.value.substr( parameterStartIndex + 1 ) );
					methodName = strip( this.value.substr( 0, parameterStartIndex ) );
					var args:BeanArray = new BeanArray( this.beanName, this.name, parameters );
					params = args.resolve( document, descriptor, bean ) as Array;
				}
				
				var reference:BeanMethod = new BeanMethod( this.beanName, this.name, methodName );
				var method:Function = reference.resolve( document, descriptor, bean ) as Function;
				if( method != null && params )
				{
					try
					{
						result = method.apply( bean, params );
					}catch( e:Error )
					{
						throw new BeanError( BeanError.BEAN_METHOD_INVOCATION, methodName, bean, params.join(",") );
					}
				}
				return result;
			}
			return null;
		}
	}
}