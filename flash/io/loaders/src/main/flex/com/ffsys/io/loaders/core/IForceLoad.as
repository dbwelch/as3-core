package com.ffsys.io.loaders.core {
	
	/**
	*	Describes the contract for instances
	*	that maintain a boolean indicating
	*	whether a resource should be forced to load even
	*	if it has already been loaded.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.11.2007
	*/
	public interface IForceLoad {
		
		/**
		* 	Determines whether a resource should be reloaded
		* 	even if it has already been loaded.
		*/
		function set forceLoad( val:Boolean ):void;
		function get forceLoad():Boolean;
	}
}