package com.ffsys.swat.core
{
	/**
	*	Describes the contract for implementations that expose
	*	access to the application settings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.12.2010
	*/
	public interface ISettingAccess
	{
		/**
		*	Gets an application setting by identifier.
		*	
		*	@param id The fully qualified identifier for the property.
		* 
		* 	@return The setting value.
		*/		
		function getSetting( id:String ):Object;
	}
}