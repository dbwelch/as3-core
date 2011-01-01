package com.ffsys.ui.display
{
	import flash.display.DisplayObject;	
	import flash.net.URLRequest;
	
	import com.ffsys.io.loaders.core.ILoader;
	import com.ffsys.io.loaders.events.LoadEvent;	
	import com.ffsys.io.loaders.resources.ImageResource;
	import com.ffsys.io.loaders.types.ImageLoader;
	
	import com.ffsys.ui.buttons.ButtonComponent;
	
	/**
	*	A component used to display a bitmap image.
	* 
	* 	This implementation can display an existing bitmap
	* 	display object or load an external file into it's
	* 	display area.
	* 
	* 	This component extends the interactive component hierarchy so can
	* 	by <code>interactive</code> if required.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.12.2010
	*/
	public class ImageDisplay extends ButtonComponent
		implements IImageDisplay
	{
		private var _image:DisplayObject;
		
		/**
		* 	Creates an <code>ImageDisplay</code> instance.
		*/
		public function ImageDisplay()
		{
			super();
			this.interactive = false;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get image():DisplayObject
		{
			return _image;
		}
		
		public function set image( value:DisplayObject ):void
		{
			if( _image != null
			 	&& contains( _image ) )
			{
				removeChild( _image );
			}
			
			_image = value;
			
			if( _image != null
			 	&& !contains( _image ) )
			{
				addChild( _image );
			}
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function applyStyles():Array
		{
			var output:Array = super.applyStyles();
			
			//trace("ImageDisplay::applyStyles()", _image );
			
			if( _image != null )
			{
				_image.x = this.paddings.left;
				_image.y = this.paddings.top;
				
				/*
				trace("ImageDisplay::applyStyles()",
					_image.x, _image.y, _image.width, _image.height, this.layoutWidth, this.layoutHeight );
				*/
				
				if( this.background != null )
				{
					this.background.draw(
						this.layoutWidth, this.layoutHeight );
						
					//trace("ImageDisplay::applyStyles() BACKGOUND WIDTH: ", this.background.width );
				}

				if( this.border != null )
				{
					this.border.draw(
						this.layoutWidth, this.layoutHeight );
				}
			}

			return output;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get layoutWidth():Number
		{
			var w:Number = super.layoutWidth;
			if( _image != null )
			{
				w = _image.width;
			}
			w += this.paddings.left + this.paddings.right;
			return w;
		}
		
		/**
		*	@inheritDoc	
		*/
		override public function get layoutHeight():Number
		{
			var h:Number = super.layoutHeight;
			if( _image != null )
			{
				h = _image.height;
			}			
			h += this.paddings.top + this.paddings.bottom;
			return h;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoader( request:URLRequest ):ILoader
		{
			var loader:ILoader = new ImageLoader( request );
			loader.addEventListener( LoadEvent.DATA, imageAvailable );
			return loader;
		}
		
		/**
		* 	@private
		* 
		* 	Invoked when the image is loaded to add it to the display list.
		* 
		* 	@param event The load event.
		*/
		private function imageAvailable( event:LoadEvent ):void
		{
			if( event.resource is ImageResource )
			{
				this.image = ImageResource( event.resource ).bitmap;
			}
		}
	}
}