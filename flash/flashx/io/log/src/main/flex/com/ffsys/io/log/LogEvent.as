package com.ffsys.io.log {
	
	import flash.events.Event;
	
	/**
	*	Encapsulates information to be logged via
	*	an <code>ILogger</code> implementation.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Vish Vishvanath, Mischa Williamson
	*	@since  09.03.2008
	*/
	public class LogEvent extends Event {
		
		static public const LOG:String = "LOG";
		static public const DEFAULT_LOG_CATEGORY:String = "default";
		
    	static public const DEBUG:String 	= "DEBUG";
    	static public const INFO:String 	= "INFO";
    	static public const WARN:String 	= "WARN";
    	static public const ERROR:String 	= "ERROR";
    	static public const FATAL:String 	= "FATAL";
		
		/**
		*	@private	
		*/
		private var _message:String;
		
		/**
		*	@private	
		*/		
		private var _level:String;
		
		/**
		*	@private	
		*/		
		private var _category:String;
		
		/**
		*	@private	
		*/		
		private var _className:String;
		
		/**
		*	@private	
		*/		
		private var _methodName:String;
		
		/**
		*	@private	
		*/		
		private var _lineNumber:uint;
		
		private var _timestamp:Number;
		
		public function LogEvent(
			message:String,
			level:String = DEBUG,
			category:String = DEFAULT_LOG_CATEGORY,
			className:String = null,
			methodName:String = null,
			lineNumber:uint = 0 )
		{
			super( LOG );
			
			this.message = message;
			this.level = level;
			this.category = category;
			this.className = className;
			this.methodName = methodName;
			this.lineNumber = lineNumber;
			
			_timestamp = new Date().time;
		}
		
		public function get timestamp():Number
		{
			return _timestamp;
		}
		
		/**
		*	The <code>message</code> for the log event.
		*/
		public function set message( val:String ):void
		{
			_message = val;
		}
		
		public function get message():String
		{
			return _message;
		}
		
		/**
		*	The <code>level</code> for the log event.	
		*/
		public function set level( val:String ):void
		{
			_level = val;
		}
		
		public function get level():String
		{
			return _level;
		}
		
		/**
		*	An optional <code>category</code> that contains
		*	the log event.
		*/
		public function set category( val:String ):void
		{
			_category = val;
		}
		
		public function get category():String
		{
			return _category;
		}
		
		/**
		*	The name of the <code>Class</code> that generated
		*	the log event.	
		*/
		public function set className( val:String ):void
		{
			_className = val;
		}
		
		public function get className():String
		{
			return _className;
		}
		
		/**
		*	The name of the method that generated
		*	the log event.	
		*/
		public function set methodName( val:String ):void
		{
			_methodName = val;
		}
		
		public function get methodName():String
		{
			return _methodName;
		}
		
		/**
		*	The line number in the source file that generated
		*	the log event.	
		*/
		public function set lineNumber( val:uint ):void
		{
			_lineNumber = val;
		}
		
		public function get lineNumber():uint
		{
			return _lineNumber;
		}
	}
}