package com.ffsys.io.loaders.types {
	
	/**
	*	Describes the contract for instances
	*	that offer access to a loaded
	*	<code>String</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface ITextAccess {
		
		/**
		*	The <code>String</code> contents
		*	of the loaded text file.
		*	
		*	@return The contents of the
		*	loaded text file.
		*/
		function get text():String;
	}
}