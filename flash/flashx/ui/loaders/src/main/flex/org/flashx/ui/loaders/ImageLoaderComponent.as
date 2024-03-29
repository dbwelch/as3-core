package org.flashx.ui.loaders
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	import org.flashx.io.loaders.core.ILoader;
	import org.flashx.io.loaders.events.LoadEvent;
	import org.flashx.io.loaders.resources.ImageResource;
	import org.flashx.io.loaders.types.ImageLoader;
	
	/**
	*	Loads an image and adds it to the display list.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  16.06.2010
	*/
	public class ImageLoaderComponent extends AbstractLoaderComponent
	{
		private var _sprites:Vector.<Bitmap> = new Vector.<Bitmap>();
		
		/**
		* 	Creates an <code>ImageLoaderComponent</code> instance.
		* 
		* 	@param urls An array of images to load into the image loader.
		*/
		public function ImageLoaderComponent(
			urls:Array )
		{
			super( urls );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get length():uint
		{
			return _sprites.length;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function getSlideShowItemAtIndex(
			index:uint ):DisplayObject
		{
			if( index >= 0 && index < _sprites.length )
			{
				return _sprites[ index ];
			}
			
			return null;
		}
		
		/**
		* 	@inheritDoc
		*/
		override protected function getLoader( url:String ):ILoader
		{
			return new ImageLoader( new URLRequest( url ) );
		}
		
		/**
		*	@private
		*/
		override protected function loadComplete(
			event:LoadEvent ):void
		{
			var display:Bitmap = Bitmap(
				ImageResource( event.resource ).bitmap );
			if( display )
			{
				mouseChildren = false;	
				_sprites.push( display );
			}
			super.loadComplete( event );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function destroy():void
		{
			super.destroy();
			var display:Bitmap = null;
			for( var i:int = 0;i < _sprites.length;i++ )
			{
				display = Bitmap( _sprites[ i ] );
				if( display && display.bitmapData )
				{
					display.bitmapData.dispose();
				}
			}
			_sprites = null;
		}
	}
}