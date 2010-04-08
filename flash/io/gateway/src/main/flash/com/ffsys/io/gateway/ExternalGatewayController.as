package com.ffsys.io.gateway {

	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.ffsys.utils.array.ArrayUtils;
	
	/**
	*	Manages all external calls out of the
	*	input output layer.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  04.08.2007
	*/
	public class ExternalGatewayController extends Object {
		
		static public const DEFAULT_INTERVAL:int = 100;
		
		/**
		*	@private	
		*/
		private var _calls:Array;
		
		/**
		*	@private	
		*/
		private var _interval:int;
		
		/**
		*	@private	
		*/		
		private var _timer:Timer;
		
		public function ExternalGatewayController()
		{
			super();
			_calls = new Array();
			_interval = DEFAULT_INTERVAL;
			_timer = new Timer( _interval );
			_timer.addEventListener( TimerEvent.TIMER, tick );
			_timer.start();
		}
		
		public function set interval( val:int ):void
		{
			_interval = val;
		}
		
		public function get interval():int
		{
			return _interval;
		}
		
		/**
		*	@private	
		*/		
		private function tick( event:TimerEvent ):void
		{
			if( _calls.length > 0 )
			{
				call( _calls.shift() );
			}else{
				_timer.stop();
			}
		}
		
		/**
		*	@private	
		*/		
		private function call( obj:Object ):*
		{
			return obj.object.invoke.apply( obj.object, obj.args );
		}

		public function invoke(
			object:IExternalGateway, args:Array = null ):*
		{
			var obj:Object = new Object();
			obj.object = object;
			obj.args = args;
			
			var output:*;
			
			//invoke it immediately
			if( !_timer.running )
			{
				output = call( obj );
			}else{
				
				if( !ArrayUtils.contains( _calls, obj ) )
				{
					_calls.push( obj );
				}
			}
			
			_timer.start();
			
			return output;
		}
	}
}