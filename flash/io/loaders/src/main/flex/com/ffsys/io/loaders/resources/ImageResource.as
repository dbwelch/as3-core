package com.ffsys.io.loaders.resources {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import com.ffsys.core.IDispose;
	
	import com.ffsys.io.loaders.display.IDisplayImage;
	import com.ffsys.io.loaders.display.ImageDisplay;
	import com.ffsys.io.loaders.types.IImageAccess;	
	
	import com.ffsys.utils.flex.FlexUtils;
	
	/**
	*	Represents a remote resource that encapsulates Bitmap data
	*	that can be added to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  03.09.2007
	*/
	public class ImageResource extends AbstractResource
		implements 	IImageAccess,
		 			IDispose {
			
		private var _accessed:Boolean;
		
		public function ImageResource(
			data:Object = null,
			uri:String = null,
			bytesTotal:uint = 0 )
		{
			super( data, uri, bytesTotal );
		}
		
		public function dispose():void
		{
			if( bitmapData )
			{
				//trace("ImageResource::dispose(), " + this );
				
				bitmapData.dispose();
				
				//test forcing a runtime error as we've already disposed
				//of the bitmap data - passes: runtime error is thrown
				//trace( bitmapData.width );				
			}
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		public function get bitmapData():BitmapData
		{
			return data as BitmapData;
		}
		
		public function get image():IDisplayImage
		{
			if( !bitmapData )
			{
				throw new Error(
					"ImageResource, invalid BitmapData - resource may have been disposed." );
			}
			
			var display:IDisplayImage;
			display = IDisplayImage( FlexUtils.getImageDisplay() );
			display.bitmapData = bitmapData;
			return display;
		}
	}
}