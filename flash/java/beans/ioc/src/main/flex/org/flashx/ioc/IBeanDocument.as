package org.flashx.ioc
{
	import flash.events.IEventDispatcher;
	
	import org.flashx.io.loaders.core.ILoaderQueue;	
	import org.flashx.utils.substitution.IBindingCollection;	
		
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
				IBeanElement {
					
		/**
		* 	Gets the default instance class to use
		* 	when none has been specified for a bean
		* 	definition.
		* 
		* 	The default implementation returns a dynamic object.
		* 
		* 	@return The default instance class.
		*/
		function getDefaultInstanceClass():Class;
					
		/**
		* 	A list of document cross references.
		* 
		* 	Beans stored in this document can access
		* 	all the beans defined in any of the documents
		* 	contained in this list.
		*/
		function get xrefs():Vector.<IBeanDocument>;
					
		/**
		* 	An injector to use when beans are retrieved from this document.
		*/
		function get injector():IBeanInjector;
		function set injector( value:IBeanInjector ):void;
		
		/**
		* 	A collection of type injectors used by the document.
		*/
		function get types():Vector.<BeanTypeInjector>;
		
		/**
		* 	The delimiter to use when parsing array values.
		* 
		* 	The default value is a vertical bar.
		*/
		function get delimiter():String;
		function set delimiter( value:String ):void;
	
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
		* 
		* 	This method dynamically generates the array of bean names
		* 	on every invocation so should not be invoked within an
		* 	iteration.
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
		* 	@param xrefs Whether to also search in document cross references.
		* 
		* 	@return The bean descriptor if found otherwise <code>null</code>.
		*/
		function getBeanDescriptor( beanName:String, xrefs:Boolean = false ):IBeanDescriptor;
		
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
		
		
		/**
		* 	Indicates whether this bean document is locked.
		* 
		* 	All bean documents are locked by default. When a bean
		* 	document is locked any attempt to add a bean with the same
		* 	<code>id</code> to a document will result in a runtime exception.
		*/
		function get locked():Boolean;
		function set locked( value:Boolean ):void;
		
		/**
		* 	The bean creation policy for the document.
		* 
		* 	By default this value is <code>null</code> indicating
		* 	that the default behaviour should occur.
		* 
		* 	If this value has been specified and the bean being added
		* 	has the default bean creation policy, the policy assigned
		* 	to this document will take precedence.
		*/
		function get policy():String;
		function set policy( value:String ):void;
	}
}