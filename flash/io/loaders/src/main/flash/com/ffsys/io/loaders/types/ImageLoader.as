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
	import com.ffsys.io.loaders.core.LoadOptions;
	import com.ffsys.io.loaders.core.LoaderClassType;
	
	import com.ffsys.io.loaders.events.ImageLoadEvent;
	
	import com.ffsys.io.loaders.resources.ImageResource;
	
	import com.ffsys.io.loaders.core.ILoadOptions;
	
	/**
	*	Represents a loader for Bitmap data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  07.07.2007
	*/
	public class ImageLoader extends AbstractDisplayLoader {
		
		public function ImageLoader(
			request:URLRequest = null,
			options:ILoadOptions = null )
		{
			super( request, options );
			dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		override public function get type():String
		{
			return LoaderClassType.IMAGE_TYPE;
		}				
		
        override protected function completeHandler(
			event:Event, data:Object = null ):void
		{
			var bitmap:Bitmap = loader.contentLoaderInfo.content as Bitmap;
			var bitmapData:BitmapData = bitmap.bitmapData;
			
			resource = new ImageResource( bitmapData, uri );			
			
			var evt:ImageLoadEvent = new ImageLoadEvent(
				event,
				this,
				resource as ImageResource
			);
			
			if( queue )
			{
				queue.addResource( this );
			}
			
			super.completeHandler( event, bitmapData );
						
			dispatchEvent( evt );
			
			Notifier.dispatchEvent( evt );
			
			dispatchLoadCompleteEvent();
			
			//clean up the Loader as we only
			//want the BitmapData
			unload();
			_loader = null;
        }
	
	}
	
}
