package com.ffsys.io.loaders.display {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import mx.core.BitmapAsset;
	
	/**
	*	Encapsulates loaded bitmap data that can be added
	*	to the display list of a Flex application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  27.07.2007
	*/
	public class FlexImageDisplay extends FlexAbstractDisplay
		implements IDisplayImage {
		
		/**
		*	@private	
		*/
		protected var _bitmapData:BitmapData;
		
		/**
		*	@private	
		*/
		protected var _asset:BitmapAsset;	
		
		/**
		*	Creates a <code>FlexImageDisplay</code> instance.
		*	
		*	@param bitmapData The <code>BitmapData</code> that
		*	represents the image to be displayed.
		*/
		public function FlexImageDisplay(
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
			_bitmapData = null;
			_asset = null;
			
			super.destroy();
		}
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			if( _asset )
			{
				addChild( _asset );
			}
				
		}
		
		/**
		*	Gets the bitmap asset used to display the
		*	underlying <code>BitmapData</code>.
		*/
		public function get asset():BitmapAsset
		{
			return _asset;
		}

		public function set bitmapData( val:BitmapData ):void
		{
			_bitmapData = val;
			
			if( bitmapData )
			{
				_asset = new BitmapAsset( bitmapData );
				
	            //ensure our width/height match those of the loaded asset
				this.width = bitmapData.width;
				this.height = bitmapData.height;
			}
		}

		public function get bitmapData():BitmapData
		{
			return _bitmapData;
		}
		
		override public function set width( val:Number ):void
		{
			super.width = val;
			
			if( _asset )
			{
				_asset.width = val;
			}
		}
		
		override public function set height( val:Number ):void
		{
			super.height = val;
			
			if( _asset )
			{
				_asset.height = val;
			}
		}
		
		public function clone():IDisplayImage
		{	
			return new FlexImageDisplay( bitmapData );
		}
		
	}
	
}
