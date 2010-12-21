package com.ffsys.ioc
{
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Represents a mapping between a class type, bean property
	* 	name and a bean descriptor that the type and property
	* 	should be resolved to.
	* 
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.12.2010
	*/
	public class BeanTypeInjector extends BeanResolver
		implements IBeanResolver {
			
		private var _type:Class;
		private var _descriptor:IBeanDescriptor;

		/**
		* 	Creates a <code>BeanTypeInjector</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param descriptor The descriptor that the type
		* 	property should resolve to.
		*/
		public function BeanTypeInjector(
			beanName:String = null,
			name:String = null,
			type:Class = null,
			descriptor:IBeanDescriptor = null ):void
		{
			super( beanName, name, null );
			_type = type;
			_descriptor = descriptor;
		}
		
		/**
		* 	The type this type injector represents.
		*/
		public function get type():Class
		{
			return _type;
		}
		
		public function set type( value:Class ):void
		{
			_type = value;
		}
		
		/**
		* 	The bean descriptor that represents the value to
		* 	assign to the property when the target bean is of
		* 	the type associated with this injector.
		*/
		public function get descriptor():IBeanDescriptor
		{
			return _descriptor;
		}
		
		public function set descriptor( value:IBeanDescriptor ):void
		{
			_descriptor = value;
		}

		/**
		* 	@inheritDoc
		*/
		override public function resolve(
			document:IBeanDocument,
			descriptor:IBeanDescriptor,
			bean:Object ):Object
		{
			if( document != null && bean != null && this.descriptor != null )
			{	
				if( bean is type )
				{
					if( bean.hasOwnProperty( this.name ) )
					{
						var value:Object = this.descriptor.getBean();
						try
						{
							bean[ this.name ] = value;
						}catch( e:Error )
						{
							throw new BeanError(
								BeanError.TYPE_INJECTOR_PROPERTY_SET,
									type, name, bean, value  );
						}
						return true;
					}
				}
			}
			return false;
		}
	}
}