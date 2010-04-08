package com.ffsys.io.loaders.types {
	
	import flash.text.StyleSheet;
	
	/**
	*	Describes the contract for instances
	*	that offer access to a loaded
	*	<code>StyleSheet</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IStylesheetAccess {
		
		/**
		*	The <code>StyleSheet</code> created
		*	when the css file was loaded.
		*	
		*	@return A <code>StyleSheet</code> instance.
		*/
		function get stylesheet():StyleSheet;
	}
}