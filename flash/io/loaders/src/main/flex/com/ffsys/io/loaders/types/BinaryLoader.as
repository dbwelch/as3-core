/**
*	Loader implementations for various types of file resources.
*/
package com.ffsys.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.utils.ByteArray;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.BinaryResource;
	
	/**
	*	Loads binary files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class BinaryLoader extends AbstractLoader {
		
		/**
		* 	Creates a <code>BinaryLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/		
		public function BinaryLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		/**
		* 	@inheritDoc
		*/
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
				this.resource = new BinaryResource( bytes );
				
				var evt:LoadEvent = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					resource as BinaryResource
				);
				
				dispatchEvent( evt );
				Notifier.dispatchEvent( evt );
			}
        }
	}
}