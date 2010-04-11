package com.ffsys.io.loaders.resources {
	
	/**
	*	Describes the contract for Objects that store a String
	*	name of a callback Function to invoke once a resource
	*	is available.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2007
	*/
	public interface IResourceCallback {
		function set callback( val:String ):void;
		function get callback():String;
	}
	
}
