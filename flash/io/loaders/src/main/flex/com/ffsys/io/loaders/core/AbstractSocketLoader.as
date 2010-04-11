package com.ffsys.io.loaders.core {
	
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.Socket;
	
	import flash.system.Security;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import com.ffsys.io.loaders.message.ILoadMessage;
	import com.ffsys.io.loaders.resources.IResource;
	import com.ffsys.io.loaders.resources.IResourceList;
	
	import com.ffsys.io.loaders.events.ILoadEvent;
	import com.ffsys.io.loaders.events.LoadStartEvent;
	import com.ffsys.io.loaders.events.LoadProgressEvent;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.events.ResourceNotFoundEvent;
	
	import com.ffsys.utils.address.AddressUtils;
	import com.ffsys.utils.identifier.IdentifierUtils;
	
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
		
		public function AbstractSocketLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super();
			
			socket = new Socket();
			port = 80;
			
			socket.addEventListener( Event.CONNECT, connectHandler );
			
			//_decorator = new LoaderDecorator( request, options );
		}
		
		/*
		public function getParentId():String
		{
			return IdentifierUtils.getParentId( uri );
		}		
		
		public function addResponderListeners(
			target:IEventDispatcher,
			startMethod:Function = null,
			progressMethod:Function = null,			
			loadedMethod:Function = null,
			resourceNotFoundMethod:Function = null ):void
		{
			
			if( !target )
			{
				throw new Error( "ILoader: cannot modify responder listeners on a null target." );
			}
			
			if( startMethod != null )
			{
				addEventListener( LoadStartEvent.LOAD_START, startMethod, false, 0, true );
			}
			
			if( progressMethod != null )
			{
				addEventListener( LoadProgressEvent.LOAD_PROGRESS, progressMethod, false, 0, true );
			}			
			
			if( loadedMethod != null )
			{
				addEventListener( LoadEvent.DATA, loadedMethod, false, 0, true );
			}
			
			if( resourceNotFoundMethod != null )
			{
				addEventListener( ResourceNotFoundEvent.RESOURCE_NOT_FOUND, resourceNotFoundMethod, false, 0, true );
			}

		}
		
		public function removeResponderListeners(
			target:IEventDispatcher,
			startMethod:Function = null,
			progressMethod:Function = null,			
			loadedMethod:Function = null,
			resourceNotFoundMethod:Function = null ):void
		{
			
			if( !target )
			{
				throw new Error( "ILoader: cannot modify responder listeners on a null target." );
			}
			
			if( startMethod != null )
			{
				removeEventListener( LoadStartEvent.LOAD_START, startMethod );
			}
			
			if( progressMethod != null )
			{
				removeEventListener( LoadProgressEvent.LOAD_PROGRESS, progressMethod );
			}			
			
			if( loadedMethod != null )
			{
				removeEventListener( LoadEvent.DATA, loadedMethod );
			}
			
			if( resourceNotFoundMethod != null )
			{
				removeEventListener( ResourceNotFoundEvent.RESOURCE_NOT_FOUND, resourceNotFoundMethod );
			}

		}		
		*/
		
		override public function get type():String
		{
			return LoaderClassType.SOCKET_TYPE;
		}
		
		override public function load( request:URLRequest ):void
		{
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
		}
		
		private var _timer:Timer;
		
		private function onTimer( event:TimerEvent ):void
		{
			connect();
			_timer.stop();
		}
		
		protected function connectHandler( event:Event ):void
		{
			trace( "Connected : " + event );
		}		
		
		public function connect():void
		{
		
			try
			{
				socket.connect( domain, port );
			}catch( e:Error )
			{
				throw new Error( "Could not create Socket connection to '" + domain + "' on port " + port );
			}
			
			trace( "Connect : " + domain );
			
			trace( "Connect : " + socket.connected );
		}
		
		static public const DELIMITER:String = "\r\n";
		
		private function getCustomHeaders():String
		{
			var requestHeaders:Array = this.request.requestHeaders;
			var header:URLRequestHeader;
			
			var output:String = "";
			
			if( requestHeaders.length > 0 )
			{
				for each( header in requestHeaders )
				{
					output += header.name + ":" + header.value + DELIMITER;
				}
			}
			
			return output;
		}
		
		private function getHeadRequest():String
		{
			var output:String = "HEAD " + relative + " HTTP/1.1" + DELIMITER;
			output += "Host: " + domain + DELIMITER;
			output += getCustomHeaders();
			return output;
		}
		
		public function head():void
		{
			var headRequest:String = getHeadRequest();
			trace( "Head request socket : " + socket );
			
			trace( "Head request : " + headRequest );
			
			if( socket )
			{
			
				socket.writeUTFBytes( headRequest + DELIMITER + DELIMITER );
				socket.flush();
			}
		}
		
		public function set socket( val:Socket ):void
		{
			_socket = val;
		}
		
		public function get socket():Socket
		{
			return _socket;
		}
		
		public function set domain( val:String ):void
		{
			_domain = val;
		}
		
		public function get domain():String
		{
			return _domain;
		}
		
		public function set relative( val:String ):void
		{
			_relative = val;
		}
		
		public function get relative():String
		{
			return _relative;
		}				
		
		public function set port( val:int ):void
		{
			_port = val;
		}
		
		public function get port():int
		{
			return _port;
		}			
		
		override public function close():void
		{
			if( socket.connected )
			{
				socket.close();
			}
		}
		
	}
	
}

