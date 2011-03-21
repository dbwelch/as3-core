package org.flashx.io.loaders.core {
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.Event;
	import flash.events.TimerEvent;	
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.Socket;
	import flash.system.Security;
	import flash.utils.Timer;
	
	import org.flashx.io.loaders.resources.IResource;
	import org.flashx.io.loaders.resources.IResourceList;
	
	/**
	*	Abstract super class for Objects that load data via
	*	a Socket connection.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.08.2007
	*/
	public class AbstractSocketLoader extends AbstractLoader {
		
		private var _socket:Socket;
		private var _domain:String;
		private var _relative:String;
		private var _port:int;
		
		/**
		* 	Creates an <code>AbstractSocketLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function AbstractSocketLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super();
			socket = new Socket();
			port = 80;
			socket.addEventListener( Event.CONNECT, connectHandler );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function load():void
		{
			
			/*
			this.request = request;
			
			//domain with protocol
			domain = AddressUtils.getDomain( uri );
			
			//Security.loadPolicyFile( "xmlsocket://" + domain + ":" + port );
			
			//get the relative path
			relative = uri.replace( domain, "" );
			
			if( relative == "" )
			{
				relative = AddressUtils.DELIMITER;
			}
			
			//strip the protocol from the domain
			domain = AddressUtils.getDomain( domain, true );
			
			Security.loadPolicyFile( "xmlsocket://" + domain + ":" + port );
			
			trace( "Abstract stream loader domain : " + domain );
			trace( "Abstract stream loader relative : " + relative );
			
			connect();
			
			//_timer = new Timer( 2000 );
			//_timer.addEventListener( TimerEvent.TIMER, onTimer );
			//_timer.start();
			*/
		}
		
		private var _timer:Timer;
		
		/**
		* 	@private
		*/
		private function onTimer( event:TimerEvent ):void
		{
			connect();
			_timer.stop();
		}
		
		/**
		* 	Invoked when the socket is connected.
		* 
		* 	@param event The event that triggered this handler.
		*/
		protected function connectHandler( event:Event ):void
		{
			trace( "Connected : " + event );
		}		
		
		/**
		* 	Attempts to connect the socket.
		*/
		public function connect():void
		{
			try
			{
				socket.connect( domain, port );
			}catch( e:Error )
			{
				throw new Error(
					"Could not create Socket connection to '"
						+ domain + "' on port " + port );
			}
			
			trace( "Connect : " + domain );
			trace( "Connect : " + socket.connected );
		}
		
		/**
		* 	The socket used for the load process.
		*/
		public function get socket():Socket
		{
			return _socket;
		}		
		
		public function set socket( val:Socket ):void
		{
			_socket = val;
		}
		
		/**
		* 	The domain to connect to.
		*/
		public function get domain():String
		{
			return _domain;
		}		
		
		public function set domain( val:String ):void
		{
			_domain = val;
		}
		
		/**
		* 	A relative path to use after the domain.
		*/
		public function get relative():String
		{
			return _relative;
		}
				
		public function set relative( val:String ):void
		{
			_relative = val;
		}
		
		/**
		* 	The port to connect to.
		*/
		public function get port():int
		{
			return _port;
		}						
		
		public function set port( val:int ):void
		{
			_port = val;
		}			
		
		/**
		* 	@inheritDoc
		*/
		override public function close():void
		{
			if( socket.connected )
			{
				socket.close();
			}
		}
	}
}