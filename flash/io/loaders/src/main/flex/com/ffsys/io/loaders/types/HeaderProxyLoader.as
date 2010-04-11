package com.ffsys.io.loaders.types {

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.net.URLLoader;
	
	import com.ffsys.io.http.HttpResponse;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.LoadOptions;
	import com.ffsys.io.loaders.events.HeaderLoadEvent;
	import com.ffsys.io.loaders.resources.HttpResource;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Makes an HTTP request using a URLStream and stops
	*	loading once the HTTP Header has been received.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  02.08.2007
	*/
	public class HeaderProxyLoader extends TextLoader {
	
		static public const PROXY_URI:String = "assets/common/scripts/head_proxy/";
		static public const URI_FIELD_NAME:String = "uri";
	
		private var _response:HttpResponse;
		
		private var _proxyUri:String;
		private var _uriFieldName:String;
		private var _method:String;
		
		public function HeaderProxyLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			
			this.proxyUri = PROXY_URI;
			this.uriFieldName = URI_FIELD_NAME;
			this.method = URLRequestMethod.GET;
			
			super( request, options );
		}
		
		public function set proxyUri( val:String ):void
		{
			_proxyUri = val;
		}
		
		public function get proxyUri():String
		{
			return _proxyUri;
		}
		
		public function set uriFieldName( val:String ):void
		{
			_uriFieldName = val;
		}
		
		public function get uriFieldName():String
		{
			return _uriFieldName;
		}		
		
		public function set method( val:String ):void
		{
			_method = val;
		}
		
		public function get method():String
		{
			return _method;
		}		
		
		override public function load( request:URLRequest ):void
		{
			this.request = request;
			
			var vars:URLVariables = new URLVariables();
			vars[ uriFieldName ] = uri;
			
			request.data = vars;
			request.url = proxyUri;
			request.method = method;			
			
			super.load( request );
		}
		
        override protected function completeHandler( event:Event, data:Object = null ):void
		{
			//headers are never cached so we don't call
			//super.completeHandler()
			var loader:URLLoader = URLLoader( event.target );
			var txt:String = new String( loader.data );
			
			try {
			
				var response:HttpResponse = new HttpResponse( txt );
				
				resource = new HttpResource( response, uri );				
				
				var evt:HeaderLoadEvent = new HeaderLoadEvent(
					event,
					this,
					resource as HttpResource
				);
				
				if( queue )
				{
					queue.addResource( this );
				}			
				
				dispatchEvent( evt );
				
				Notifier.dispatchEvent( evt );
			
				dispatchLoadCompleteEvent();
			
			}catch( e:Error )
			{
				throw new Error(
					"Invalid HTTP response received for : " +
					this.uri + "\n\n" + e.toString() );
			}
        }
		
	}
	
}
