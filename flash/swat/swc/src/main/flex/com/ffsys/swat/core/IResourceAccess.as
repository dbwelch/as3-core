package com.ffsys.swat.core
{
	import flash.display.Bitmap;
	import flash.media.Sound;
	
	/**
	*	Describes the contract for implementations that provide
	* 	access to loaded resource data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface IResourceAccess
	{
		/**
		* 	Gets a loaded XML document by identifier.
		* 
		* 	@param id The identifier for the xml resource.
		* 
		* 	@return The <code>XML</code> if it could be retrieved
		* 	otherwwise <code>null</code>.
		*/
		function getXmlDocument( id:String ):XML;
	
		/**
		*	Gets a loaded image bitmap.
		*	
		*	@param id The identifier for the loaded
		*	resource.
		* 
		* 	@return The <code>Bitmap</code> if it could be retrieved
		* 	otherwwise <code>null</code>.
		*/
		function getImage( id:String ):Bitmap;
	
		/**
		*	Gets a loaded sound.
		*	
		* 	@return The <code>Sound</code> if it could be retrieved
		* 	otherwwise <code>null</code>.
		*/
		function getSound( id:String ):Sound;
	}
}