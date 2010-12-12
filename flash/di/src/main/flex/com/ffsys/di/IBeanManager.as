package com.ffsys.di {
	
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	import com.ffsy.core.IDestroy;
	import com.ffsys.io.loaders.core.*;
	
	/**
	*	Describes the contract for bean managers.
	*	
	*	Style managers manage the loading of a collection
	*	of bean beanss and locating beans from a number
	*	of bean beanss.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public interface IBeanManager
		extends IBeanAccess,
				IDestroy,
				IEventDispatcher {
		
		/**
		* 	Gets a list of all the documents stored by this implementation.
		*/
		function get documents():Vector.<IBeanDocument>;
		
		/**
		*	Adds a bean beans to this manager.
		*	
		*	If no specific bean beans is specified this method
		*	will create one using the bean beans factory.
		* 
		*	@param beans A bean beans implementation to register
		* 	with the bean manager.
		*	@param request The url request to load the bean
		*	beans data from.
		* 
		* 	@return The bean document.
		*/
		function addBeanDocument(
			beans:IBeanDocument = null,
			request:URLRequest = null ):IBeanDocument;
		
		/**
		*	Removes a bean beans from this manager.
		*	
		*	@param beans The bean beans to remove.
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