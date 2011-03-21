package org.flashx.ui.css {
	
	import flash.net.URLRequest;
	
	import org.flashx.ioc.*;
	import org.flashx.io.loaders.core.*;
	
	/**
	*	Describes the contract for style managers.
	*	
	*	Style managers manage the loading of a collection
	*	of style sheets and provide access to the loaded style information.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public interface IStyleManager
		extends IBeanManager,
		 		IStyleAccess {
			
		/**
		* 	Gets the document cast to a style sheet implementation.
		*/
		function get stylesheet():ICssStyleSheet;
		
		/**
		*	Adds a style sheet load request to this manager.
		*
		*	@param request The url request to load the style
		*	sheet data from.
		* 
		* 	@return The style sheet the loaded data will be placed into.
		*/
		function addStyleSheet(
			request:URLRequest ):ICssStyleSheet;
		
		/**
		*	Removes a style sheet load request from this manager.
		*	
		*	@param request The request that was previously added.
		* 
		* 	@return Whether the specified request was removed from the list
		* 	of style sheets to load.
		*/
		function removeStyleSheet(
			request:URLRequest ):Boolean;
	}
}