package com.ffsys.io.loaders.types {
	
	import flash.net.URLVariables;
	
	/**
	*	Describes the contract for instances
	*	that offer access to loaded
	*	<code>URLVariables</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IVariableAccess {
		
		/**
		*	The <code>URLVariables</code> received
		*	from the server.
		*	
		*	@return The loaded <code>URLVariables</code>.
		*/
		function get vars():URLVariables;
	}
}