package com.ffsys.swat.core
{
	import flash.display.Bitmap;
	import flash.media.Sound;
		
	import com.ffsys.core.IDestroy;
	import com.ffsys.io.loaders.resources.IResourceList;
	
	/**
	*	Describes the contract for resource manager implementations.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IResourceManager
		extends	IDestroy,
				IResourceAccess
	{
		/**
		* 	The main resource list being managed.
		*/
		function get list():IResourceList;
		function set list( value:IResourceList ):void;
		
		/**
		* 	List of application setting resources.
		* 
		* 	This will be <code>null</code> if no settings
		* 	resources have been defined.
		*/
		function get settings():IResourceList;
		
		/**
		* 	List of xml resources.
		* 
		* 	This will be <code>null</code> if no xml
		* 	resources have been defined.
		*/
		function get xml():IResourceList;
		
		/**
		* 	List of text resources.
		* 
		* 	This will be <code>null</code> if no text
		* 	resources have been defined.
		*/
		function get text():IResourceList;
		
		/**
		* 	List of rsl resources.
		* 
		* 	This will be <code>null</code> if no rsl
		* 	resources have been defined.
		*/
		function get rsls():IResourceList;
		
		/**
		* 	List of image resources.
		* 
		* 	This will be <code>null</code> if no image
		* 	resources have been defined.
		*/
		function get images():IResourceList;
		
		/**
		* 	List of sound resources.
		* 
		* 	This will be <code>null</code> if no sound
		* 	resources have been defined.
		*/
		function get sounds():IResourceList;
	}
}