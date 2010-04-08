package com.ffsys.io.log {
	
	/**
	*	Describes the contract for objects that can
	*	log a <code>LogEvent</code> instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.03.2008
	*/
	public interface ILogger {
		
		/**
		*	Sends a <code>LogEvent</code> to be logged.	
		*/
		function log( event:LogEvent ):void;
		
		/**
		*	The <code>ILogFormatter</code> implementation
		*	to use prior to sending a <code>LogEvent</code>
		*	to log output.
		*/
		function set formatter( val:ILogFormatter ):void;
		function get formatter():ILogFormatter;
		
		/**
		*	The <code>applicationName</code> to use when logging
		*	a <code>LogEvent</code>.
		*/		
		function set applicationName( val:String ):void;
		function get applicationName():String;
		
		/**
		*	The <code>url</code> to use when logging
		*	a <code>LogEvent</code>.
		*/
		function set url( val:String ):void;
		function get url():String;
	}
}