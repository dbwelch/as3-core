package com.ffsys.di
{
	import flash.events.IEventDispatcher;
	import com.ffsys.core.IStringIdentifier;
	
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
		extends	IStringIdentifier,
				IEventDispatcher {
		
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
		* 	Attempts to retrieve an instance of a bean.
		* 	
		* 	@param beanName The bean descriptor identifier.
		* 
		* 	@return An instance of the bean or null if no matching
		* 	bean descriptor was located.
		*/
		function getBean( beanName:String ):Object;	
		
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
	}
}