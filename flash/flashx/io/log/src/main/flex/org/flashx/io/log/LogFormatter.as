package org.flashx.io.log {
	
	/**
	*	Implementation of <code>ILogFormatter</code>
	*	that simply passes through the source
	*	<code>message</code> associated with the
	*	<code>LogEvent</code>.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.03.2008
	*/
	public class LogFormatter extends Object
		implements ILogFormatter {
		
		/**
		*	Creates a <code>LogFormatter</code>.
		*/		
		public function LogFormatter()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/		
		public function format(
			event:LogEvent, logger:ILogger = null ):String
		{
			if( event )
			{
				return event.message;
			}
			
			return null;
		}
	}
}