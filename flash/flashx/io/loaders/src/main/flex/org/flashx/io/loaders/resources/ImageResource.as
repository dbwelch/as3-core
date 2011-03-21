package org.flashx.io.loaders.resources {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.flashx.core.IDispose;
	
	/**
	*	Represents a remote resource that encapsulates bitmap data.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class ImageResource extends AbstractResource
		implements 	IDispose {
		
		/**
		* 	Creates an <code>ImageResource</code> instance.
		* 
		* 	@param data The data this resource encapsulates.
		* 	@param uri The <code>URI</code> the data was loaded from.
		* 	@param bytesTotal The total number of bytes loaded.
		*/		
		public function ImageResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		/**
		* 	@inheritDoc
		*/
		public function dispose():void
		{
			if( bitmapData )
			{
				bitmapData.dispose();
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			dispose();
			super.destroy();
		}
		
		/**
		* 	The data for this resource coerced to bitmap data.
		*/		
		public function get bitmapData():BitmapData
		{
			return data as BitmapData;
		}
		
		/**
		* 	Gets a bitmap display object.
		*/
		public function get bitmap():Bitmap
		{
			if( bitmapData )
			{
				return new Bitmap( bitmapData );
			}
			return null;
		}
	}
}