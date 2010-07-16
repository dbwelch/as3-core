package com.ffsys.io.loaders.message {
	
	/**
	*	Represents a <code>message</code>
	*	that can be displayed while a resource
	*	is loading.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.09.2007
	*/
	public class LoadMessage extends Object
		implements ILoadMessage {
		
		/**
		*	@private	
		*/
		private var _message:String = "";
		
		/**
		*	@private
		*/		
		private var _id:String;
		
		/**
		*	@private	
		*/		
		private var _formatter:ILoadMessageFormatter;
		
		/**
		*	Creates a <code>LoadMessage</code> instance.
		*/
		public function LoadMessage()
		{
			super();
			this.formatter =
				new LoadMessageFormatter();
		}
		
		/**
		*	@inheritDoc
		*/
		public function hasMessage():Boolean
		{
			return ( message && message.length > 0 );
		}
		
		/**
		*	@inheritDoc
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
		*	@inheritDoc
		*/		
		public function set id( val:String ):void
		{
			_id = val;
		}
		
		public function get id():String
		{
			return _id;
		}		
		
		/**
		*	@inheritDoc
		*/		
		public function set formatter( val:ILoadMessageFormatter ):void
		{
			_formatter = val;
		}
		
		public function get formatter():ILoadMessageFormatter
		{
			return _formatter;
		}
		
		/**
		*	@inheritDoc
		*/		
		public function format( message:String = null, id:String = null ):String
		{
			//trace( "LoadMessage format : " + id );
			
			if( !message )
			{
				message = this.message;
			}
			
			if( !id )
			{
				id = this.id;
			}
			
			return formatter.format( message, id );
		}
		
		/**
		*	@inheritDoc
		*/		
		public function clone():ILoadMessage
		{
			var output:LoadMessage = new LoadMessage();
			output.formatter = formatter;
			output.id = id;
			output.message = message;
			return output;
		}
		
		public function toString():String
		{
			return "[object LoadMessage][" + message + "][" + id + "]";
		}
	}
}