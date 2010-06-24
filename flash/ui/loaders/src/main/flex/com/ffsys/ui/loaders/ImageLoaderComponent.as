package com.ffsys.ui.loaders
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.events.ILoadEvent;
	import com.ffsys.io.loaders.events.ImageLoadEvent;
	import com.ffsys.io.loaders.types.ImageLoader;
	import com.ffsys.io.loaders.display.ImageDisplay;
	
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
		/**
		* 	@private
		* 
		* 	Force compilation of the image display class.
		*/
		static private var _display:ImageDisplay;
		
		private var _sprites:Vector.<Sprite> = new Vector.<Sprite>();
		
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
			event:ILoadEvent ):void
		{
			var evt:ImageLoadEvent = ImageLoadEvent( event );
			var display:Sprite = Sprite( evt.image );
			
			if( display )
			{
				display.mouseEnabled = false;
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
			
			var display:ImageDisplay = null;
			for( var i:int = 0;i < _sprites.length;i++ )
			{
				display = ImageDisplay( _sprites[ i ] );
				display.destroy();
			}
		}
	}
}