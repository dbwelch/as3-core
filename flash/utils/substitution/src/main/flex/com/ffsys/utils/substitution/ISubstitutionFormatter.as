package com.ffsys.utils.substitution {
	
	/**
	*	Describes the contract for Objects that perform
	*	formatting of the replacement values that are
	*	found while performing substitution.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.09.2007
	*/
	public interface ISubstitutionFormatter {
		function format( replacement:Object ):Object;
	}
	
}
