package com.ffsys.io.loaders.responder {
	
	/**
	*	Describes the contract for Objects that maintain a reference
	*	to an IResponder.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  08.09.2007
	*/
	public interface ILoadResponderReference {
		function set responder( val:ILoadResponder ):void;
		function get responder():ILoadResponder;
	}
	
}
