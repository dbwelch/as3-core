package org.flashx.ioc
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	*	Represents an existing instance that is injected into a bean document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public class InjectedBeanDescriptor extends BeanDescriptor
	{
		/**
		* 	Creates an <code>InjectedBeanDescriptor</code> instance.
		*
		* 	@param id An identifier for the bean.
		* 	@param target The existing target instance this bean should represent.
		* 	@param singleton Whether this is a singleton bean.
		*/
		public function InjectedBeanDescriptor(
			id:String = null,
			target:Object = null,
			singleton:Boolean = true )
		{
			super( id );
			this.singleton = singleton;
			if( target != null )
			{
				convert( target );
			}
			if( this.singleton )
			{
				_singletonInstance = target;
			}
		}
		
		/**
		* 	@private
		*/
		private function convert( target:Object ):void
		{
			var clazz:Class = null;
			try
			{
				clazz = Class( getDefinitionByName( getQualifiedClassName( target ) ) );
			}catch( e:Error )
			{
				throw new Error( "Could not determine class of injected bean instance '" + target + "'." );
			}
			transfer( target );
			_instanceClass = clazz;
		}
	}
}