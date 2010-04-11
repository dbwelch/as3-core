package com.ffsys.io.gateway {
	
	/**
	*	Mono state for managing all external
	*	calls out of the input output layer.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class ExternalGatewayManager extends Object {
	
		/**
		*	@private	
		*/
		static private var _controller:ExternalGatewayController
			= new ExternalGatewayController();
		
		/**
		*	@private	
		*/		
		public function ExternalGatewayManager()
		{
			super();
		}
		
		static public function setInterval( val:int ):void
		{
			_controller.interval = val;
		}
		
		static public function getInterval():int
		{
			return _controller.interval;
		}

		static public function invoke(
			object:IExternalGateway, args:Array = null ):Boolean
		{
			return _controller.invoke( object, args );
		}
	}
}