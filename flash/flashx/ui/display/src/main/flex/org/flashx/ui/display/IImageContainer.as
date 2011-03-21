package org.flashx.ui.display
{
	import flash.display.DisplayObject;
	import flash.net.URLRequest;
	
	import org.flashx.io.loaders.core.ILoaderQueue;
	import org.flashx.ui.display.IImageDisplay;
	import org.flashx.ui.containers.IContainer;	
	
	/**
	*	Describes the contract for image containers
	* 	that can inject or load a sequence of image resources.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  31.12.2010
	*/
	public interface IImageContainer extends IContainer
	{
		/**
		* 	The collection of image display implementations.
		*/
		function get images():Vector.<IImageDisplay>;
		
		/**
		* 	Injects a collection of existing images into
		* 	this collection.
		* 
		* 	@param images The collection of images to inject.
		* 
		* 	@return The collection of image display instances
		* 	corresponding to the images.
		*/
		function inject( images:Vector.<DisplayObject> ):Vector.<IImageDisplay>;
		
		/**
		* 	Gets a loader queue used to load the image
		* 	resources from a list of url requests.
		* 
		* 	@param requests The list of url requests.
		* 
		* 	@return The loader queue.
		*/
		function getLoaderQueue(
			requests:Vector.<URLRequest> ):ILoaderQueue;
	}
}