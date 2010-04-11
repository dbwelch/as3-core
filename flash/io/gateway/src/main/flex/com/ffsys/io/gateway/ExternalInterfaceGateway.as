package com.ffsys.io.gateway {
	
	import flash.external.ExternalInterface;
	
	/**
	*	Ensures that all ExternalInterface
	*	calls go via the ExternalGatewayManager
	*	if you must have the call invoked
	*	immediately (require a return value)
	*	call the invoke() method.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  05.08.2007
	*/
	public class ExternalInterfaceGateway extends Object
		implements IExternalGateway {
		
		public function ExternalInterfaceGateway( method:String, ...args )
		{
			super();
			call( method, args );
		}
		
		public function invoke( ...args ):*
		{
			var method:String = args.shift();
			return ExternalInterface.call( method, args );
		}
		
		public function call( ...args ):void
		{
			ExternalGatewayManager.invoke( this, args );
		}
	}
}