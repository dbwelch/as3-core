/**
*	Loader implementations for various types of file resources.
*/
package org.flashx.io.loaders.types {
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.utils.ByteArray;
	
	import org.flashx.events.Notifier;
	
	import org.flashx.io.loaders.core.AbstractLoader;
	import org.flashx.io.loaders.core.ILoadOptions;
	import org.flashx.io.loaders.events.LoadEvent;
	import org.flashx.io.loaders.resources.BinaryResource;
	
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
			
			if( data == null )
			{
				var loader:URLLoader = URLLoader( event.target );
				
				if( loader.data )
				{
					bytes = loader.data as ByteArray;
				}
			}else{
				bytes = data as ByteArray;
			}
			
			var evt:LoadEvent = null;
			
			if( bytes )
			{
				this.resource = new BinaryResource( bytes, uri, bytesTotal );
				
				evt = new LoadEvent(
					LoadEvent.DATA,
					event,
					this,
					resource
				);
				
				super.completeHandler( event, bytes );
				dispatchEvent( evt );
				Notifier.dispatchEvent( evt );
			}
			
			evt = new LoadEvent(
				LoadEvent.LOAD_FINISHED,
				event,
				this,
				this.resource
			);
			dispatchEvent( evt );			
        }
	}
}