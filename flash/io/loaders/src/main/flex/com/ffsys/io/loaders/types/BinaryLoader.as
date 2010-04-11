package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.utils.ByteArray;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.LoadOptions;
	import com.ffsys.io.loaders.core.LoaderClassType;
	
	import com.ffsys.io.loaders.events.BinaryLoadEvent;
	
	import com.ffsys.io.loaders.resources.BinaryResource;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Represents a loader for ByteArray or raw binary data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class BinaryLoader extends AbstractLoader {
		
		public function BinaryLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		override public function get type():String
		{
			return LoaderClassType.BINARY_TYPE;
		}		
		
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			var bytes:ByteArray;
			
			if( !data )
			{
				var loader:URLLoader = URLLoader( event.target );
				
				if( loader.data )
				{
					bytes = loader.data as ByteArray;
					super.completeHandler( event, bytes );
				}
			}else{
				bytes = data as ByteArray;
			}
			
			if( bytes )
			{
				resource = new BinaryResource( bytes );			
				
				var evt:BinaryLoadEvent = new BinaryLoadEvent(
					event,
					this,
					resource as BinaryResource
				);
				
				if( queue )
				{
					queue.addResource( this );
				}				
				
				dispatchEvent( evt );
				
				Notifier.dispatchEvent( evt );
			}
			
			dispatchLoadCompleteEvent();
        }	
				
	}
	
}
