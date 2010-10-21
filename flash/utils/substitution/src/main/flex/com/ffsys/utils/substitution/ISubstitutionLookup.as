package com.ffsys.utils.substitution {
	
	/**
	*	Describes the contract for Objects that perform
	*	their own substiution lookup.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.09.2007
	*/
	public interface ISubstitutionLookup {
		
		/**
		* 	Gets a substitution property by identifier.
		* 
		* 	@param id The property identifier.
		* 
		* 	@return An object or null if the property is invalid.
		*/
		function getSubstitutionLookup( id:String ):Object;
	}
}
