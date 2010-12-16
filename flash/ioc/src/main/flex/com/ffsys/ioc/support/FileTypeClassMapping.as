/**
*	Support classes for the inversion of control container.
*/
package com.ffsys.ioc.support
{
	import com.ffsys.io.loaders.types.*;
	
	/**
	*	Encapsulates the mappings between a file extension and
	* 	a loader class.
	* 
	* 	This implementation enforces the convention that all file
	* 	extensions are treated as lowercase.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public class FileTypeClassMapping extends Object
		implements IFileTypeClassMapping
	{
		private var _mappings:Object;
		
		/**
		* 	Creates a <code>FileTypeClassMapping</code> instance.
		*/
		public function FileTypeClassMapping()
		{
			super();
			configure();
		}
		
		/**
		*	Configures default file type class mappings.
		*/
		protected function configure():void
		{
			clear();
			setMapping( "png", ImageLoader );
			setMapping( "jpg", ImageLoader );
			setMapping( "jpeg", ImageLoader );
			setMapping( "txt", TextLoader );
			setMapping( "xml", XmlLoader );
			setMapping( "swf", MovieLoader );
			setMapping( "mp3", SoundLoader );
			setMapping( "flv", VideoLoader );
			setMapping( "m4v", VideoLoader );
			setMapping( "properties", PropertiesLoader );			
		}
		
		/**
		* 	@inheritDoc
		*/
		public function clear():void
		{
			_mappings = new Object();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function setMapping( extension:String, loaderClass:Class ):void
		{
			if( extension && loaderClass )
			{
				extension = sanitize( extension );
				_mappings[ extension ] = loaderClass;
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		public function hasMapping( extension:String ):Boolean
		{
			if( extension != null )
			{
				extension = sanitize( extension );
			}
			return ( _mappings[ extension ] is Class );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getMapping( extension:String ):Class
		{
			if( extension != null && hasMapping( extension ) )
			{
				extension = sanitize( extension );
				return Class( _mappings[ extension ] );
			}
			return null;
		}
		
		/**
		* 	@private
		*/
		protected function sanitize( extension:String ):String
		{
			if( extension != null )
			{
				return extension.toLowerCase();
			}
			return null;
		}
	}
}