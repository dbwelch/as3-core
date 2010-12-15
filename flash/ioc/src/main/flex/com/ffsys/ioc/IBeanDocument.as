package com.ffsys.ioc
{
	import flash.events.IEventDispatcher;
	
	import com.ffsys.core.IDestroy;	
	import com.ffsys.core.IStringIdentifier;
	
	import com.ffsys.io.loaders.core.ILoaderQueue;	
	import com.ffsys.utils.substitution.IBindingCollection;	
	
	
	/**
	*	Describes the contract for collections
	*	of beans.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.10.2010
	*/
	public interface IBeanDocument
		extends	IBeanAccess,
				IStringIdentifier,
				IDestroy,
				IEventDispatcher {
					
		/**
		* 	An injector to use when beans are retrieved from this document.
		*/
		function get injector():IBeanInjector;
		function set injector( value:IBeanInjector ):void;
		
		/**
		* 	The delimiter to use when parsing array values.
		* 
		* 	The default value is a vertical bar.
		*/
		function get delimiter():String;
		function set delimiter( value:String ):void;					
		
		/**
		* 	A collection of external file dependencies found when
		* 	the bean document was parsed.
		*/			
		function get files():Vector.<BeanFileDependency>;
		
		/**
		*	A queue that represents the dependencies that
		*	were found when the beans were parsed.
		*/
		function get dependencies():ILoaderQueue;
	
		/**
		*	Parses the text into this instance
		*	and returns a loader queue implementation
		*	responsible for loading any external file dependencies
		*	declared in the beans.
		*	
		*	@param text The beans text to parse.
		* 	@param parser A specific parser implementation to use.
		*	
		*	@return The loader queue responsible for loading
		*	external dependencies.
		*/
		function parse( text:String, parser:IBeanParser = null ):ILoaderQueue;
		
		/**
		* 	Gets the object that encapsulates constants for the bean document.
		*/
		function get constants():Object;

		/**
		* 	A collection of bindings to expose when parsing bean files.
		*/
		function get bindings():IBindingCollection;
		function set bindings( bindings:IBindingCollection ):void;
		
		/**
		*	Removes all beans from this document.
		*/
		function clear():void;
		
		/**
		* 	The number of beans stored in this document.
		*/
		function get length():uint;
		
		/**
		*	An array of string identifiers for each of the bean
		* 	descriptors encapsulated by this document.
		*/
		function get beanNames():Array;
		
		/**
		* 	Determines whether this document has a bean descriptor.
		* 
		* 	The default implementation compares by instance as well as
		* 	by identifier.
		* 
		* 	@param descriptor The bean descriptor to test for existence.
		* 
		* 	@return A boolean indicating whether the descriptor exists in this
		* 	document.
		*/
		function hasBeanDescriptor( descriptor:IBeanDescriptor ):Boolean;
		
		/**
		* 	Adds a bean descriptor to this document.
		* 
		* 	@param descriptor The bean descriptor.
		* 
		* 	@return A boolean indicating whether the bean decsriptor
		* 	was added.
		*/
		function addBeanDescriptor( descriptor:IBeanDescriptor ):Boolean;
		
		/**
		* 	Attempts to remove a bean descriptor.
		* 
		* 	@param descriptor The bean descriptor.
		* 
		* 	@return A boolean indicating whether the descriptor was removed.
		*/
		function removeBeanDescriptor( descriptor:IBeanDescriptor ):Boolean;
		
		/**
		* 	Gets a bean descriptor by identifier.
		* 
		* 	@param beanName The identifier of the bean descriptor.
		* 
		* 	@return The bean descriptor if found otherwise <code>null</code>.
		*/
		function getBeanDescriptor( beanName:String ):IBeanDescriptor;
		
		/**
		* 	Retrieves a bean with the specified bean name that <em>is</em> of any
		* 	of the class types specified in the type parameter.
		* 
		* 	@param beanName The name of the bean to retrieve.
		* 	@param types A vector of class types that the bean must be one of.
		* 
		* 	@return A matching bean if found otherwise <code>null</code>.
		*/
		function getBeanByType( beanName:String, types:Vector.<Class> ):Object;
		
		/**
		* 	Copies the contents of another bean document into this
		* 	document.
		* 
		* 	@param document The target document to copy into this document.
		* 	
		* 	@return The number of descriptors in this document after the copy.
		*/
		function copy( document:IBeanDocument ):uint;
	}
}