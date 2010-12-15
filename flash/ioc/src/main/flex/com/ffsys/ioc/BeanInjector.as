package com.ffsys.ioc
{
	import flash.utils.getDefinitionByName;
	
	import com.ffsys.utils.object.ClassUtils;
	
	/**
	*	An implementation for injecting bean properties
	* 	that searches all public variables for beans that match
	* 	by identifier and type.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2010
	*/
	public class BeanInjector extends Object
		implements IBeanInjector
	{
		/**
		* 	Creates a <code>BeanInjector</code> instance.
		*/
		public function BeanInjector()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function inject(
			document:IBeanDocument,
			beanName:String,
			bean:Object ):Object
		{
			if( document != null && bean != null )
			{
				var list:XMLList = ClassUtils.getPublicVariables( bean ).children();
				var beanNames:Array = document.beanNames;
				
				var node:XML = null;
				var name:String = null;
				var type:String = null;
				var clazz:Class = null;
				for each( node in list )
				{
					name = node.@name;
					
					//TODO: ensure that we compare bean names after the bean name has been converted to camel case
					
					//no matching bean for this property name
					if( beanNames.indexOf( name ) == -1 )
					{
						continue;
					}

					type = node.@type;
					try
					{
						clazz = Class( getDefinitionByName( type ) );
					}catch( e:Error ) 
					{
						//fail silently if we can't retrieve the type of a property
					}
					
					if( clazz )
					{
						var classes:Vector.<Class> = new Vector.<Class>( 1 );
						classes.push( clazz );
						var found:Object = document.getBeanByType( name, classes );
						if( found != null && ( found is clazz ) )
						{
							//update the property value with the injected bean
							bean[ name ] = found;
						}
					}
				}
			}
			return bean;
		}
	}
}