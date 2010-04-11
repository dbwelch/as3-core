package com.ffsys.io.loaders.calculator {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import com.ffsys.io.core.IBytesTotal;
	import com.ffsys.io.loaders.events.LoadEvent;
	
	import com.ffsys.io.loaders.events.HeaderLoadEvent;
	import com.ffsys.io.loaders.events.LoadCompleteEvent;
	
	import com.ffsys.io.http.HttpConstants;
	import com.ffsys.io.http.HttpResponse;
	import com.ffsys.io.http.HttpResponseHeader;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.core.LoaderQueue;
	
	import com.ffsys.io.loaders.types.HeaderProxyLoader;
	
	/**
	*	Performs a sequential HEAD request for each item to
	*	be loaded.
	*
	*	Calculating a bytesTotal property of all the Content-Length
	*	HTTP headers encountered.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.08.2007
	*/
	public class CumulativeSizeCalculator extends LoaderQueue {
		
		private var _callback:IBytesTotal;
		
		public function CumulativeSizeCalculator(
			callback:IBytesTotal = null )
		{
			super();
			
			this.bytesTotal = 0;
			
			_callback = callback;
		}
		
		public function calculate():void
		{
			getCumulativeSize();
		}
		
		private function getCumulativeSize():void
		{
			//trace( "getCumulativeSize :" + _callback );
			//trace( "getCumulativeSize :" + _callback.bytesTotal );
			
			this.bytesTotal = 0;
			
			if( _callback && _callback.bytesTotal > 0 )
			{
				this.bytesTotal = _callback.bytesTotal;
				dispatchCompleteEvent();
				return;
			}
			
			var loader:ILoader;
			
			var requests:Array = getAllRequests();
			
			if( requests.length == 0 )
			{
				dispatchCompleteEvent();
				return;
			}
			
			var i:int;
			var l:int;
			
			//_queue = new LoaderQueue();
			
			addEventListener( LoadCompleteEvent.LOAD_COMPLETE, completeHandler );
			
			i = 0;
			l = requests.length;
			
			for( ;i < l;i++ )
			{
				loader = new HeaderProxyLoader();
				loader.addEventListener( LoadEvent.DATA, headerLoadHandler );
				addLoader( requests[ i ], loader );
			}
			
			load();
		}
		
		private function dispatchCompleteEvent():void
		{
			if( _callback )
			{
				_callback.bytesTotal = bytesTotal;
			}
		
			var event:Event = new Event( Event.COMPLETE );
			dispatchEvent( new LoadCompleteEvent( event, item as ILoader ) );
			//_queue = null;
		}
		
		private function headerLoadHandler( event:HeaderLoadEvent ):void
		{
			Event( event ).target.removeEventListener( Event( event ).type, headerLoadHandler );
			
			var response:HttpResponse = event.response;
			
			var contentLength:HttpResponseHeader = response.getHeader( HttpConstants.CONTENT_LENGTH );
			
			if( contentLength )
			{
				var size:Number = parseFloat( contentLength.value );
				
				if( !isNaN( size ) )
				{
					bytesTotal += size;					
				}
			}
			
			dispatchEvent( event );
		}
		
		private function completeHandler( event:LoadCompleteEvent ):void
		{
			event.target.removeEventListener( event.type, completeHandler );
			dispatchCompleteEvent();
		}
		
	}
	
}
