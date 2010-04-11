package com.ffsys.io.loaders.types {
	
	import com.ffsys.io.http.HttpResponse;
	
	/**
	*	Describes the contract for instances that offer
	*	access to loaded HTTP response data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IHttpAccess {
		
		/**
		*	The <code>HttpResponse</code> created
		*	when the HTTP response was received.
		*	
		*	@return An <code>HttpResponse</code>
		*	instance.
		*/
		function get response():HttpResponse;
	}
}