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
	public interface IStyleManager extends ICssStyleCollection {
		
		/**
		*	Adds a style sheet to this manager.
		*	
		*	@param request The url request to load the style
		*	sheet data from.
		*	@param sheet A style sheet implementation to load
		*	the style sheet data into.	
		*/
		function addStyleSheet(
			request:URLRequest,
			sheet:ICssStyleCollection ):void;
			
		/**
		*	Removes a style sheet from this manager.
		*	
		*	@param sheet The style sheet to remove.
		*/
		function removeStyleSheet(
			sheet:ICssStyleCollection ):Boolean;
			
		/**
		*	Loads all the style sheets associated with this
		*	style manager.
		*	
		*	@return The loader queue used to load the style sheets.
		*/
		function load():ILoaderQueue;
	}
}