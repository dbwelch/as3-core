package com.ffsys.ui.containers
{
	import flash.display.DisplayObject;	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.ILoaderQueue;	
	
	import com.ffsys.ui.common.ComponentIdentifiers;
	import com.ffsys.ui.display.IImageDisplay;	
	import com.ffsys.ui.layout.HorizontalLayout;
	
	/**
	*	Responsible for managing injecting or loading
	* 	images into a collection of image display
	* 	implementations.
	* 
	* 	An image container uses a horizontal layout by default.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.12.2010
	*/
	public class ImageContainer extends Container
		implements IImageContainer
	{
		private var _images:Vector.<IImageDisplay> = new Vector.<IImageDisplay>();
		
		/**
		* 	Creates an <code>ImageContainer</code> instance.
		*/
		public function ImageContainer()
		{
			super();
			this.layout = new HorizontalLayout();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get images():Vector.<IImageDisplay>
		{
			return _images;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function inject( images:Vector.<DisplayObject> ):Vector.<IImageDisplay>
		{
			if( images != null )
			{
				var component:IImageDisplay = null;
				for( var i:int = 0;i < images.length;i++ )
				{
					if( i < _images.length )
					{
						component = _images[ i ];
					}else{
						component = getComponentBean(
							ComponentIdentifiers.IMAGE_DISPLAY ) as IImageDisplay;
							
						if( component != null )
						{
							_images.push( component );
						}
					}
					
					if( component != null )
					{
						component.image = images[ i ];
					}
					
					if( !this.contains( DisplayObject( component ) ) )
					{
						addChild( DisplayObject( component ) );
					}
				}
			}
			return _images;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function getLoaderQueue(
			requests:Vector.<URLRequest> ):ILoaderQueue
		{
			return null;
		}
	}
}