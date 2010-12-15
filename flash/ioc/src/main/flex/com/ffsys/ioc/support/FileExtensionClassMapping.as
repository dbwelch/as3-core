package com.ffsys.ioc.support
{
	import com.ffsys.io.loaders.types.*;
	
	/**
	*	Encapsulates the mappings between a file extension and
	* 	a loader class.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public class FileExtensionClassMapping extends Object
	{
		private var _mappings:Object;
		
		/**
		* 	Creates a <code>FileExtensionClassMapping</code> instance.
		*/
		public function FileExtensionClassMapping()
		{
			super();
			
			clear();
			setMapping( "png", ImageLoader );
			setMapping( "jpg", ImageLoader );
			setMapping( "jpeg", ImageLoader );
			
			setMapping( "xml", XmlLoader );
		}
		
		/**
		* 	Clears all stored mappings.
		*/
		public function clear():void
		{
			_mappings = new Object();
		}
		
		/**
		* 	Sets a file extension mapping to the specified loader class.
		* 
		* 	@param extension The file extension.
		* 	@param loaderClass The class of loader that should be instantiated
		* 	for the specified file extension.
		*/
		public function setMapping( extension:String, loaderClass:Class ):void
		{
			if( extension && loaderClass )
			{
				_mappings[ extension ] = loaderClass;
			}
		}
		
		/**
		* 	Determines whether a class mapping exists for the specified file extension.
		* 
		* 	@param extension The file extension.
		* 
		* 	@return A boolean indicating whether a mapping exists for the specified file extension.
		*/
		public function hasMapping( extension:String ):Boolean
		{
			return ( _mappings[ extension ] is Class );
		}
		
		/**
		* 	Attempts to retrieve the class mapping for a given extension.
		* 
		* 	@param extension The file extension.
		* 
		* 	@return The loader class or <code>null</code> if no mapping was found.
		*/
		public function getMapping( extension:String ):Class
		{
			if( extension != null && hasMapping( extension ) )
			{
				return Class( _mappings[ extension ] );
			}
			return null;
		}
	}
}