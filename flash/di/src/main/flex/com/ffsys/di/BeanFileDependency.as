package com.ffsys.di
{
	import flash.net.URLRequest;
	
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
		*/
		public function BeanFileDependency(
			beanName:String = null,
			name:String = null,
			value:String = null,
			loaderClass:Class = null ):void
		{
			super( beanName, name, value );
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
		* 	@inheritDoc
		*/
		public function resolve( document:IBeanDocument, bean:Object ):Object
		{
			if( document != null )
			{	
				//
			}

			return null;
		}
	}
}