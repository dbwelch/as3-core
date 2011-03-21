package org.flashx.swat.core {
	
	/**
	*	Describes the contract for implementations that expose
	*	access to the localized message and error strings for
	*	the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.07.2010
	*/
	public interface IMessageAccess {
		
		/**
		*	Gets a message from the loaded properties files.
		*	
		*	@param id The fully qualified identifier for the property.
		*	@param replacements Replacement values for the located property.
		* 
		* 	@return The message string.
		*/
		function getMessage( id:String, ... replacements ):String;
		
		/**
		*	Gets an error message from the loaded properties files.
		*	
		*	@param id The fully qualified identifier for the property.
		*	@param replacements Replacement values for the located property.
		* 
		* 	@return The error message string.
		*/
		function getError( id:String, ... replacements ):String;
	}
}