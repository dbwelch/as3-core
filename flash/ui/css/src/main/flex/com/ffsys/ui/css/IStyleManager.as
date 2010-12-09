package com.ffsys.ui.css {
	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.*;
	
	/**
	*	Describes the contract for style managers.
	*	
	*	Style managers manage the loading of a collection
	*	of style sheets and locating styles from a number
	*	of style sheets.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public interface IStyleManager extends ICssStyleSheet {
		
		/**
		*	Adds a style sheet to this manager.
		*	
		*	If no specific style sheet is specified this method
		*	will create one using the style sheet factory.
		* 
		*	@param sheet A style sheet implementation to register
		* 	with the style manager.
		*	@param request The url request to load the style
		*	sheet data from.
		*/
		function addStyleSheet(
			sheet:ICssStyleSheet = null,
			request:URLRequest = null ):ICssStyleSheet;
		
		/**
		*	Removes a style sheet from this manager.
		*	
		*	@param sheet The style sheet to remove.
		*/
		function removeStyleSheet(
			sheet:ICssStyleSheet ):Boolean;
			
		/**
		*	Gets a style sheet by identifier.
		*	
		*	@param id The identifier for the style sheet.
		*	
		*	@return The style sheet with the specified identifier
		*	or null if no corresponding style sheet was located.
		*/
		function getStyleSheet( id:String ):ICssStyleSheet;			
			
		/**
		*	Loads all the style sheets associated with this
		*	style manager.
		*	
		*	@return The loader queue used to load the style sheets.
		*/
		function load():ILoaderQueue;
	}
}