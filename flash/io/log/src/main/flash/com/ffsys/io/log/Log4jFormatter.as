package com.ffsys.io.log {
	
	/**
	*	Implementation of <code>ILogFormatter</code>
	*	that formats a <code>LogEvent</code>
	*	to a Log4J XML packet.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  15.03.2008
	*/
	public class Log4jFormatter extends Object
		implements ILogFormatter {
		
		/**
		*	Creates a <code>Log4jFormatter</code>.
		*/		
		public function Log4jFormatter()
		{
			super();
		}
		
		/**
		*	@inheritDoc
		*/		
		public function format(
			event:LogEvent, logger:ILogger = null ):String
		{
			var buffer:String = "<log4j:event logger=\"";
			buffer += event.category;
			buffer += "\" timestamp=\"";
			buffer += event.timestamp;
			buffer += "\" level=\"";
			buffer += event.level;
			buffer += "\" thread=\"";
			buffer += logger.url;
			buffer += "\">\r\n";
			buffer += "<log4j:message><![CDATA[";
			buffer += event.message;
			buffer += "]]></log4j:message>\r\n";
			buffer += "<log4j:properties><log4j:data name=\"application\" value=\"";
			buffer += logger.applicationName;
			buffer += "\" />\r\n</log4j:properties>\r\n</log4j:event>\r\n\r\n";
			return buffer;
		}
	}
}