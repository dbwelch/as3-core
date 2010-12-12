package com.ffsys.io.loaders.types {
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLLoaderDataFormat;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import com.ffsys.events.Notifier;
	
	import com.ffsys.io.loaders.core.AbstractDisplayLoader;
	import com.ffsys.io.loaders.core.ILoadOptions;
	import com.ffsys.io.loaders.events.LoadEvent;
	import com.ffsys.io.loaders.resources.ImageResource;
	
	/**
	*	Loads bitmap image files.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class ImageLoader extends AbstractDisplayLoader {
		
		/**
		* 	Creates an <code>ImageLoader</code> instance.
		* 
		* 	@param request The request to load the file from.
		* 	@param options The load options.
		*/
		public function ImageLoader(
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
			var bitmap:Bitmap = loader.contentLoaderInfo.content as Bitmap;
			var bitmapData:BitmapData = bitmap.bitmapData;
			
			this.resource = new ImageResource(
				bitmapData, uri );
			
			var evt:LoadEvent = new LoadEvent(
				LoadEvent.DATA,
				event,
				this,
				resource as ImageResource
			);
			
			super.completeHandler( event, bitmapData );			
			dispatchEvent( evt );
			Notifier.dispatchEvent( evt );
			
			//clean up the Loader as we only
			//want the BitmapData
			unload();
			_composite = null;
        }
	}
}