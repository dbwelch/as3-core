package com.ffsys.utils.collections.strings {
	
	/**
	*	Describes the contract for instances that encapsulate
	*	a collection of strings stored by identifier.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.10.2007
	*/
	public interface IStringAccess {
		
		/**
		*	Gets a string by identifier.
		*	
		*	@param id The identifier for the string,
		*	@param collection The identifier of a specific
		*	child collection to locate the string in.
		*	
		*	This method will throw an exception if the
		*	string could not be found.
		*	
		*	@return The string if it could be found.	
		*/
		function getStringById(
			id:String, collection:String = null ):String;
	}
}