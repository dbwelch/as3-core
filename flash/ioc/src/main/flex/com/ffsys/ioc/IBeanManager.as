package com.ffsys.ioc {
	
	import flash.events.IEventDispatcher;
	import flash.net.URLRequest;
	
	import com.ffsys.core.IDestroy;
	import com.ffsys.io.loaders.core.*;
	
	import com.ffsys.utils.substitution.*;	
	
	/**
	*	Describes the contract for bean managers.
	*	
	* 	A bean manager is responsible for loading one or more
	* 	bean documents, resolving any external file dependencies
	* 	in the loaded bean documents and managing access to the beans
	* 	stored in the loaded documents.
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
		* 	Clears all load requests stored by this manager.
		*/
		function clear():void;
		
		/**
		* 	The document used to manage loaded bean definitions.
		*/
		function get document():IBeanDocument;
		function set document( value:IBeanDocument ):void;
		
		/**
		* 	Proxy access to the document bindings.
		*/
		function get bindings():IBindingCollection;
		function set bindings( value:IBindingCollection ):void;		
		
		/**
		*	Adds a document request to this manager.
		* 
		*	@param request The url request to load the bean
		*	beans data from.
		* 
		* 	@return The bean document the data is being loaded into.
		*/
		function addBeanDocument(
			request:URLRequest ):IBeanDocument;
		
		/**
		*	Removes a document request from this manager.
		*	
		*	@param request The request to remove.
		* 
		* 	@return Whether the speciified request was removed.
		*/
		function removeBeanDocument(
			request:URLRequest ):Boolean;
			
		/**
		*	Gets a loader queue of all the external url requests
		* 	associated with this manager.
		*	
		*	@return The loader queue used to load the beans.
		*/
		function getLoaderQueue():ILoaderQueue;
	}
}