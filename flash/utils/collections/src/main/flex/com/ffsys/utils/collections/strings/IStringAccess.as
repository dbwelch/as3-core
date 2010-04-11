package com.ffsys.utils.collections.strings {
	
	/**
	*	Describes the contract for Objects that provide access
	*	to collections of Strings.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.10.2007
	*/
	public interface IStringAccess {
		function getStringById(
			id:String, collection:String = null ):String;
	}
}