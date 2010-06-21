package com.ffsys.ui.loaders
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
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
		
		/**
		* 	Creates an <code>ImageLoaderComponent</code> instance.
		* 
		* 	@param urls An array of images to load into the image loader.
		* 	@param deferred Whether the load operation should be
		* 	deferred until the load method is invoked manually.
		*/
		public function ImageLoaderComponent(
			urls:Array )
		{
			super( urls );
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
			var display:DisplayObject = DisplayObject( evt.image );
			DisplayObjectContainer( container ).addChild( display );
			
			super.loadComplete( event );
		}
	}
}