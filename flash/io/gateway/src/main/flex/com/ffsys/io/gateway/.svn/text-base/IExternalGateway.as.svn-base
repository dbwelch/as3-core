package com.ffsys.io.gateway {
	
	/**
	*	Describes the contract for instances that make external
	*	calls whether they be HTTP or ExternalInterface.
	*
	*	Allows all external calls to be marshalled so that certain
	*	browsers do not drop calls.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public interface IExternalGateway {
		
		/**
		*	Called on the <code>IExternalGateway</code>
		*	implementation when the queued external request
		*	should be invoked.
		*	
		*	The implementation of this method should proceed
		*	with making the external request.
		*	
		*	@param ...args The arguments supplied when the <code>invoke</code>
		*	method of <code>ExternalGatewayManager</code> was called.
		*/
		function invoke( ...args:Array ):*;
	}
}