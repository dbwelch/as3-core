package com.ffsys.di {
	
	import flash.net.URLRequest;
	import com.ffsys.io.loaders.core.*;
	
	/**
	*	Describes the contract for style managers.
	*	
	*	Style managers manage the loading of a collection
	*	of style beanss and locating styles from a number
	*	of style beanss.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public interface IBeanManager extends IBeanDocument {
		
		/**
		*	Adds a style beans to this manager.
		*	
		*	If no specific style beans is specified this method
		*	will create one using the style beans factory.
		* 
		*	@param beans A style beans implementation to register
		* 	with the style manager.
		*	@param request The url request to load the style
		*	beans data from.
		*/
		function addBeanDocument(
			beans:IBeanDocument = null,
			request:URLRequest = null ):IBeanDocument;
		
		/**
		*	Removes a style beans from this manager.
		*	
		*	@param beans The style beans to remove.
		* 
		* 	@return Whether the speciified beans document was removed.
		*/
		function removeBeanDocument(
			beans:IBeanDocument ):Boolean;
			
		/**
		*	Gets a bean store by identifier.
		*	
		*	@param id The identifier for the bean store.
		*	
		*	@return The bean store with the specified identifier
		*	or null if no corresponding bean store was located.
		*/
		function getBeanDocument( id:String ):IBeanDocument;
			
		/**
		*	Loads all the beans associated with this
		*	bean manager.
		*	
		*	@return The loader queue used to load the beans.
		*/
		function load():ILoaderQueue;
	}
}