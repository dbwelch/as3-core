package com.ffsys.swat.configuration {
	
	import flash.display.Bitmap;
	import flash.filters.BitmapFilter;
	import flash.media.Sound;
	
	import com.ffsys.ui.css.ICssStyleSheet;
	import com.ffsys.ui.css.IStyleManager;
	
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
		*	Gets the style manager for the application.
		*/
		function get styleManager():IStyleManager;
		
		/**
		*	The style sheet for the application.
		*/
		function get stylesheet():ICssStyleSheet;
		
		/**
		* 	Locates a style from the specified identifier searching
		* 	all style sheets that have been loaded by the style manager.
		* 
		* 	@param id The identifier for the style.
		* 
		* 	@return The copy of the style object if it was found otherwise
		* 	null.
		*/
		function getStyle( id:String ):Object;
		
		/**
		* 	Sets a style on the style manager.
		* 
		* 	@param styleName The name of the style.
		* 	@param style The object containing the style information.
		*/
		function setStyle( styleName:String, style:Object ):void;
		
		/**
		*	Gets a bitmap filter by identifier.
		* 
		* 	@param id The identifer for the filter.
		*/
		function getFilter( id:String ):BitmapFilter;
	}
}