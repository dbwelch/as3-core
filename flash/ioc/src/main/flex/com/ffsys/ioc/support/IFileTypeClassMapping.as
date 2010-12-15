package com.ffsys.ioc.support
{

	public interface IFileTypeClassMapping
	{
		
		/**
		* 	Clears all stored mappings.
		*/
		function clear():void;
		
		/**
		* 	Sets a file extension mapping to the specified loader class.
		* 
		* 	@param extension The file extension.
		* 	@param loaderClass The class of loader that should be instantiated
		* 	for the specified file extension.
		*/
		function setMapping( extension:String, loaderClass:Class ):void;
		
		/**
		* 	Determines whether a class mapping exists for the specified file extension.
		* 
		* 	@param extension The file extension.
		* 
		* 	@return A boolean indicating whether a mapping exists for the specified file extension.
		*/
		function hasMapping( extension:String ):Boolean;
		
		/**
		* 	Attempts to retrieve the class mapping for a given extension.
		* 
		* 	@param extension The file extension.
		* 
		* 	@return The loader class or <code>null</code> if no mapping was found.
		*/
		function getMapping( extension:String ):Class;		
	}

}

