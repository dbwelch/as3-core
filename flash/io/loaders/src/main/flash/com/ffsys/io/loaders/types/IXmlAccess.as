package com.ffsys.io.loaders.types {
	
	/**
	*	Describes the contract for instances
	*	that offer access to a loaded
	*	<code>XML</code> document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IXmlAccess {
		
		/**
		*	The <code>XML</code> created
		*	when the loaded document
		*	became available.
		*	
		*	@return The loaded <code>XML</code>
		*	document.
		*/		
		function get xml():XML;
	}
}