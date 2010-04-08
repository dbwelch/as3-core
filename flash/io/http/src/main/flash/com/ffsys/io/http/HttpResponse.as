package com.ffsys.io.http {
	
	/**
	*	Encapsulates a response received
	*	from a HTTP server.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.08.2007
	*/
	public class HttpResponse extends Object {
		
		/**
		*	@private
		*/
		private var _version:Number;
		
		/**
		*	@private	
		*/
		private var _status:int;
		
		/**
		*	@private
		*/
		private var _headers:Array;
		
		/**
		*	Creates an <code>HttpResponse</code> instance.
		*	
		*	@param headers The raw <code>String</code> response
		*	headers.
		*/
		public function HttpResponse( headers:String = null )
		{
			super();
			_headers = new Array();
			
			if( headers )
			{
				parse( headers );
			}
		}
		
		/**
		*	The HTTP version.	
		*/
		public function get version():Number
		{
			return _version;
		}
		
		/**
		*	The HTTP status code for the response.
		*/
		public function get status():int
		{
			return _status;
		}
	
		/**
		*	An <code>Array</code> of
		*	<code>HttpResponseHeader</code> instances
		*	representing the response headers received.
		*/
		public function get headers():Array
		{
			return _headers;
		}	
	
		/**
		*	Parses the response headers into an
		*	<code>Array</code> of <code>HttpResponseHeader</code>
		*	instances.
		*	
		*	@param data The raw HTTP header data.
		*	
		*	@return An <code>Array</code> of
		*	<code>HttpResponseHeader</code> instances.
		*/
		public function parse( data:String ):Array
		{
			
			var re:RegExp = new RegExp( "^HTTP/([0-9]{1,}\.?[0-9]?) ([0-9]+).*" );
			var matches:Array = response.match( re );			
			
			//--> add strict mode to throw a runtime
			//error when data is null or does not appear
			//to be a valid HTTP response
			if( !data || !matches || !matches.length )
			{
				return null;
			}
			
			//remove any carriage returns
			data = data.replace( /\r/g, "" );
			
			var headers:Array = data.split( "\n" );
			var response:String = headers.shift();
			
			_version = parseFloat( matches[ 1 ] );
			_status = parseInt( matches[ 2 ] );
			
			var output:Array = new Array();
			
			var i:int = 0;
			var l:int = headers.length;
			
			var header:HttpResponseHeader;
			
			for( ;i < l;i++ )
			{
				if( headers[ i ].match( /^\s*$/ ) )
				{
					continue;
				}
				
				header = new HttpResponseHeader();
				header.parse( headers[ i ] );
				output.push( header );
			}
			
			_headers = output;
			
			return output;
		}
		
		public function getHeader( key:String ):HttpResponseHeader
		{
			var i:int = 0;
			var l:int = _headers.length;
			
			key = key.toLowerCase();
			
			var header:HttpResponseHeader;
			var headerKey:String;
			
			for( ;i < l;i++ )
			{
				header = _headers[ i ];
				headerKey = header.name.toLowerCase();
				if( headerKey == key )
				{
					return header;
				}
			}
			
			return null;
		}
		
		/**
		*	Gets a <code>String</code> representation
		*	of this instance.
		*	
		*	@return The <code>String</code>
		*	representation of this instance.
		*/		
		public function toString():String
		{
			var str:String = "[object HttpResponse][" + status + "]\n";
			
			var i:int = 0;
			var l:int = _headers.length;
			
			for( ;i < l;i++ )
			{
				str += _headers[ i ].toString() + "\n";
			}
			
			return str;
		}
		
	}
}