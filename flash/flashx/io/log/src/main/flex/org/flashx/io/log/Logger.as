package org.flashx.io.log {
	
	/**
	*	Default <code>ILogger</code>
	*	implementation that outputs to <code>trace</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.03.2008
	*/
	public class Logger extends Object 
		implements ILogger {
			
		private static const DEFAULT_URL:String =
			"/";

		private static const DEFAULT_APPLICATION_NAME:String =
			"defaultApplicationLogger";			
			
		/**
		*	@private
		*/
		private var _applicationName:String;
		
		/**
		*	@private	
		*/
		private var _url:String;
		
		/**
		*	@private	
		*/
		protected var _formatter:ILogFormatter;			
		
		/**
		*	@private	
		*/
		
		public function Logger(
			applicationName:String = DEFAULT_APPLICATION_NAME,
			url:String = DEFAULT_URL )
		{
			super();
			
			this.formatter = new LogFormatter();
			
			this.applicationName = applicationName;
			this.url = url;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set formatter( val:ILogFormatter ):void
		{
			_formatter = val;
		}
		
		public function get formatter():ILogFormatter
		{
			return _formatter;
		}
		
		/**
		*	@inheritDoc
		*/
		public function set applicationName( val:String ):void
		{
			_applicationName = val;
		}
		
		public function get applicationName():String
		{
			return _applicationName;
		}
		
		/**
		*	@inheritDoc
		*/				
		public function set url( val:String ):void
		{
			_url = val;
		}
		
		public function get url():String
		{
			return _url;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function log( event:LogEvent ):void
		{
			if( !formatter )
			{
				trace( event );
				return;
			}
			
			var output:String =
				formatter.format( event, this );
			trace( output );
		}
	}
}