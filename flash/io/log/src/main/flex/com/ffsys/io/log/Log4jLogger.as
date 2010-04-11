package com.ffsys.io.log {
	
	import flash.events.Event;
	import flash.events.ErrorEvent;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;	
	
	/**
	*	Implementation of <code>ILogger</code> that
	*	sends log messages in the Log4J XML format
	*	to an XML socket receiver.
	*	
	*	Defaults to opening a socket connection to
	*	<code>localhost:2112</code>.
	*	
	*	Create a new XML Receiver in Chainsaw with
	*	a port of 2112 and run the application.
	*	
	*	<pre>
	*	var logger:Log4jLogger = new Log4jLogger();
	*	logger.log( new LogEvent( "A log4j log message" ) );
	*	</pre>
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Vish Vishvanath / Mischa Williamson
	*	@since  09.03.2008
	*/
	public class Log4jLogger extends Logger {
			
		/**
		*	@private	
		*/
		private static const DEFAULT_HOST:String =
			"localhost";
		
		/**
		*	@private	
		*/	
		private static const DEFAULT_PORT:uint =
			2112;
			
		/**
		*	@private	
		*/			
		private var _host:String;
		
		/**
		*	@private	
		*/
		private var _port:uint;
		
		public function Log4jLogger(
			host:String = DEFAULT_HOST,
			port:uint = DEFAULT_PORT,
			applicationName:String = null,
			url:String = null )
		{
			super( applicationName, url );
			
			this.formatter =  new Log4jFormatter();
			
			this.host = host;
			this.port = port;
			
			connect();
		}
		
		/**
		*	The <code>host</code> to connect to when opening
		*	the socket connection.
		*/
		public function set host( val:String ):void
		{
			_host = val;
		}
		
		public function get host():String
		{
			return _host;
		}
		
		/**
		*	The <code>port</code> to connect to when opening
		*	the socket connection.
		*/
		public function set port( val:uint ):void
		{
			_port = val;
		}
		
		public function get port():uint
		{
			return _port;
		}
		
		/**
		*	@inheritDoc
		*/
		override public function log( event:LogEvent ):void
		{
			var buffer:String = formatter.format( event, this );
			send( buffer );
		}
		
		/**
		*	Gets a Log4J XML representation of a
		*	<code>LogEvent</code> as a <code>String</code>.
		*	
		*	@param event The <code>LogEvent</code> to convert.
		*	
		*	@return A <code>String</code> representing the Log4J XML.
		*/
		
		/*
		private function getLogXml( event:LogEvent ):String
		{
			var buffer:String = "<log4j:event logger=\"";
			buffer += event.category;
			buffer += "\" timestamp=\"";
			buffer += event.timestamp;
			buffer += "\" level=\"";
			buffer += event.level;
			buffer += "\" thread=\"";
			buffer += url;
			buffer += "\">\r\n";
			buffer += "<log4j:message><![CDATA[";
			buffer += event.message;
			buffer += "]]></log4j:message>\r\n";
			buffer += "<log4j:properties><log4j:data name=\"application\" value=\"";
			buffer += applicationName;
			buffer += "\" />\r\n</log4j:properties>\r\n</log4j:event>\r\n\r\n";
			return buffer;
		}
		*/
		
		private var _socket:Socket;
		
		private function connect():void
		{
			_socket = new Socket();
			
			_socket.addEventListener(
				Event.CONNECT, connectHandler, false, 0, true );
			_socket.addEventListener(
				IOErrorEvent.IO_ERROR, errorHandler, false, 0, true );
			_socket.addEventListener(
				SecurityErrorEvent.SECURITY_ERROR, errorHandler, false, 0, true );
				
			_socket.connect( host, port );
		}
		
		private function send(
			buffer:String = null ):void
		{
			
			if ( _socket && buffer && buffer.length > 0 )
			{
				_socket.writeUTFBytes( buffer );
				_socket.flush();
			}
		}
		
		private function connectHandler( event:Event ):void
		{
			//-->
		}

		private function errorHandler( event:ErrorEvent ):void
		{
			trace( event.text );
		}
	}
}