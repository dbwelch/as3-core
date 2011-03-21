package org.flashx.io.log {
	
	/**
	*	Describes the methods and properties for
	*	instances that format a <code>LogEvent</code>
	*	prior to sending to log output.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.03.2008
	*/
	public interface ILogFormatter {
		
		/**
		*	Gets a formatted <code>String</code>
		*	representation of a <code>LogEvent</code>.
		*	
		*	@param event The <code>LogEvent</code> to format.
		*	
		*	@return The formatted <code>String</code> to
		*	be sent to the log output.
		*/
		function format( event:LogEvent, logger:ILogger = null ):String;
	}
}
