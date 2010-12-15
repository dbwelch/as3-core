package com.ffsys.ioc
{
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;
	
	/**
	*	Represents a file dependency declared in a bean file.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public class BeanFileDependency extends BeanResolver
		implements IBeanResolver {
		
		private var _loaderClass:Class;

		/**
		* 	Creates a <code>BeanFileDependency</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param value The parsed value.
		* 	@param loaderClass The class of loader to instantiate.
		*/
		public function BeanFileDependency(
			beanName:String = null,
			name:String = null,
			value:String = null,
			loaderClass:Class = null ):void
		{
			super( beanName, name, value );
			this.loaderClass = loaderClass;
		}
		
		/**
		* 	The class of loader to use when loading the dependency.
		*/
		public function get loaderClass():Class
		{
			return _loaderClass;
		}
		
		public function set loaderClass( value:Class ):void
		{
			_loaderClass = value;
		}
		
		/**
		* 	Gets the loader repsonsible for loading this file dependency.
		* 
		* 	@return The loader to use to load the bean file dependency.
		*/
		public function getLoader():ILoader
		{
			var loader:ILoader = null;
			if( this.loaderClass && this.value )
			{
				loader = ILoader(
					new loaderClass( new URLRequest( String( this.value ) ) ) );
				loader.customData = this;
			}
			return loader;
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
				var descriptor:IBeanDescriptor = document.getBeanDescriptor( this.beanName );
				
				if( !descriptor )
				{
					throw new Error( "Could not locate file dependency bean with name '"
						+ this.beanName + "'." );
				}
				
				var properties:Object = descriptor.properties;
				if( properties )
				{
					//update the bean descriptor property
					//with the loaded resource data
					properties[ this.name ] = bean;
				}
			}
			return null;
		}
	}
}