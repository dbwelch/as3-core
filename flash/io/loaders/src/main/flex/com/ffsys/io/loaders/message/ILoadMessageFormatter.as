package com.ffsys.io.loaders.message {
	
	/**
	*	Describes the contract for instances
	*	that format the <code>message</code>
	*	to be displayed while a resource is loading.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.09.2007
	*/
	public interface ILoadMessageFormatter {
		
		/**
		*	Performs formatting of the data
		*	encapsulated by an
		*	<code>ILoadMessage</code> implementation.
		*	
		*	@param message The source <code>message</code>
		*	assigned to the <code>ILoadMessage</code> instance.
		*	@param id The <code>id</code> assigned to the
		*	<code>ILoader</code> that has the
		*	<code>ILoadMessage</code> assigned to it.
		*/
		function format(
			message:String = null,
			id:String = null ):String;
	}
}