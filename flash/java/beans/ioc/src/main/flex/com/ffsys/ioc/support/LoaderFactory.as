package com.ffsys.ioc.support
{
	import com.ffsys.io.loaders.core.ILoader;	
	
	/**
	* 	A loader factory implementation that creates loaders
	* 	based on a file extension.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public class LoaderFactory extends Object
		implements ILoaderFactory
	{
		private var _extensions:IFileTypeClassMapping;
		
		/**
		* 	Creates a <code>LoaderFactory</code> instance.
		*/
		public function LoaderFactory()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get extensions():IFileTypeClassMapping
		{
			return _extensions;
		}
		
		public function set extensions( value:IFileTypeClassMapping ):void
		{
			_extensions = value;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderClassByFileExtension( extension:String ):Class
		{
			if( this.extensions != null )
			{
				return this.extensions.getMapping( extension );
			}
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderByFileExtension( extension:String ):ILoader
		{
			var instance:ILoader = null;
			var clazz:Class = getLoaderClassByFileExtension( extension );
			if( clazz == null )
			{
				throw new Error( "Could not locate a loader class for file extension '" + extension + "'." );
			}
			try
			{
				instance = ILoader( new clazz() );
			}catch( e:Error )
			{
				throw new Error( "Could not instantiate a loader with class '" + clazz + "'." );
			}
			return instance;
		}
	}
}