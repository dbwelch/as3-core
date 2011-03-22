package org.flashx.ioc.support
{
	import org.flashx.io.loaders.core.ILoader;
	
	/**
	*	Describes the contract for factory classes that create loader
	* 	implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.12.2010
	*/
	public interface ILoaderFactory
	{
		/**
		* 	The file extension to class mappings.
		*/
		function get extensions():IFileTypeClassMapping;
		function set extensions( value:IFileTypeClassMapping ):void;
		
		/**
		* 	Gets the class of loader for a given file extension.
		* 
		* 	@param extension The file extension.
		* 
		* 	@return The class of loader to use for a given mapping.
		*/
		function getLoaderClassByFileExtension( extension:String ):Class;
		
		/**
		* 	Gets a loader based on a file extension.
		* 
		* 	@param extension The file extension.
		* 
		* 	@return A loader instance.
		*/
		function getLoaderByFileExtension( extension:String ):ILoader;
	}
}