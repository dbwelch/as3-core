package com.ffsys.ioc
{
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.utils.properties.PropertiesMerge;	
	
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
		private var _properties:Object;

		/**
		* 	Creates a <code>BeanFileDependency</code> instance.
		* 
		* 	@param beanName The name of the bean.
		* 	@param name The name of the bean property.
		* 	@param value The parsed value.
		* 	@param loaderClass The class of loader to instantiate.
		* 	@param properties Properties to assign to the instantiated loader.
		*/
		public function BeanFileDependency(
			beanName:String = null,
			name:String = null,
			value:String = null,
			loaderClass:Class = null,
			properties:Object = null ):void
		{
			super( beanName, name, value );
			this.loaderClass = loaderClass;
			this.properties = properties;
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
		* 	Properties to assign to the instantiated loader.
		*/
		public function get properties():Object
		{
			return _properties;
		}
		
		public function set properties( value:Object ):void
		{
			_properties = value;
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
				if( this.properties != null )
				{
					var merger:PropertiesMerge = new PropertiesMerge();
					merger.merge( loader, properties );
				}
			}
			return loader;
		}

		/**
		* 	@inheritDoc
		*/
		override public function resolve(
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