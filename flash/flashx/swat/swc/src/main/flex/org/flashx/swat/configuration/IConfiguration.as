package org.flashx.swat.configuration {
	
	/**
	*	Describes the contract for objects that
	*	encapsulate configuration information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.06.2010
	*/
	public interface IConfiguration
		extends IConfigurationElement {
		
		/**
		*	Application meta data.
		*/
		function set meta( val:ApplicationMeta ):void;
		function get meta():ApplicationMeta;
	}
}