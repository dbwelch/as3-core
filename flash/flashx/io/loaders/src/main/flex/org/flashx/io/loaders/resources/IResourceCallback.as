package org.flashx.io.loaders.resources {
	
	/**
	*	Describes the contract for implementations that
	*	store the name of a callback function to invoke
	* 	once a resource is available.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2007
	*/
	public interface IResourceCallback {
		
		/**
		*	The name of a callback function associated with this loader.
		* 
		* 	This is useful when declaring loader implementations in external
		* 	files.
		*/		
		function set callback( val:String ):void;
		function get callback():String;
	}
}