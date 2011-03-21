package org.flashx.io.log {
	
	/**
	*	Mono state for logging
	*	<code>LogEvent</code> instances.
	*	
	*	Uses a <code>Logger</code> instance by default.
	*	
	*	<pre>Log.log( new LogEvent( "A log message" ) );</pre>
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.03.2008
	*/
	public class Log extends Object {
		
		/**
		*	@private	
		*/
		static private var _logger:ILogger;
		
		/**
		*	@private	
		*/
		public function Log()
		{
			super();
		}
		
		/**
		*	The current <code>ILogger</code> implementation used to
		*	send <code>LogEvent</code> instances.
		*/
		static public function set logger( val:ILogger ):void
		{
			_logger = val;
		}
		
		static public function get logger():ILogger
		{
			return _logger;
		}
		
		/**
		*	Wraps a message into a 
		*	<code>LogEvent</code> and sends the event
		*	to be logged.
		*	
		*	@param message The message to log.
		*/
		static public function output( message:String ):void
		{
			log( new LogEvent( message ) );
		}
		
		/**
		*	Sends an event to be logged.
		*	
		*	@param event The event to be logged.
		*/
		static public function log( event:LogEvent ):void
		{
			if( !logger )
			{
				logger = new Logger();
			}
			
			logger.log( event );
		}
	}
}