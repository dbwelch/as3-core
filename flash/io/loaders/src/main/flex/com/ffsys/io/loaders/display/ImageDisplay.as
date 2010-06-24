package com.ffsys.io.loaders.display {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	/**
	*	Encapsulates loaded bitmap data that can be added
	*	to the display list of a Flash application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.07.2007
	*/
	public class ImageDisplay extends AbstractDisplay
		implements IDisplayImage {
		
		/**
		*	@private	
		*/
		protected var _bitmapData:BitmapData;
		
		/**
		*	@private	
		*/
		protected var _asset:Bitmap;
		
		/**
		*	Creates an <code>ImageDisplay</code> instance.
		*	
		*	@param The bitmap data that represents the image.	
		*/
		public function ImageDisplay(
			bitmapData:BitmapData = null )
		{
			super();
			
			this.bitmapData = bitmapData;
		}
		
		/*
		*	IDestroy implementation.	
		*/
		
		/**
		*	@inheritDoc	
		*/
		override public function destroy():void
		{
			if( _bitmapData )
			{
				_bitmapData.dispose();
			}
			
			_bitmapData = null;
			_asset = null;
			
			super.destroy();
		}
		
		/**
		*	The bitmap used to display the loaded
		*	bitmap data.
		*/
		public function get asset():Bitmap
		{
			return _asset;
		}
		
		/**
		*	@inheritDoc	
		*/
		public function set bitmapData( val:BitmapData ):void
		{
			_bitmapData = val;
			
			if( bitmapData )
			{
				_asset = new Bitmap( bitmapData );
				
				addChild( _asset );
				
	            //ensure our width/height match those of the loaded asset
				this.width = bitmapData.width;
				this.height = bitmapData.height;
			}
		}

		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
		
		/**
		*	@inheritDoc	
		*/		
		override public function set width( val:Number ):void
		{
			super.width = val;
			
			if( _asset )
			{
				_asset.width = val;
			}
		}
		
		/**
		*	@inheritDoc	
		*/		
		override public function set height( val:Number ):void
		{
			super.height = val;
			
			if( _asset )
			{
				_asset.height = val;
			}
		}
		
		/**
		*	@inheritDoc	
		*/
		public function clone():IDisplayImage
		{	
			return new ImageDisplay( bitmapData );
		}
	}
}