package com.ffsys.swat.configuration {
	
	import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	/**
	*	Describes the contract for implementations
	*	that expose access to loaded media.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  18.07.2010
	*/
	public interface IMediaAccess {
		
		/**
		*	Gets a loaded image bitmap.
		*	
		*	@param id The identifier for the loaded
		*	resource.
		*/
		function getImage( id:String ):Bitmap;
		
		/**
		*	Gets a loaded sound.
		*	
		*	@param id The identifier for the loaded
		*	resource.
		*/
		function getSound( id:String ):Sound;
		
		/**
		*	Gets a bitmap filter by identifier.
		*/
		function getFilter( id:String ):BitmapFilter;	
	}
}