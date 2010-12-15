package com.ffsys.ioc
{
	import com.ffsys.core.IDestroy;
	import com.ffsys.core.IStringIdentifier;
	
	/**
	*	Describes the contract for implementations that encapsulate
	* 	the information for a bean.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.12.2010
	*/
	public interface IBeanDescriptor
		extends	IStringIdentifier,
				IDestroy
	{
		/**
		* 	The document this bean descriptor belongs to.
		*/
		function get document():IBeanDocument;
		function set document( document:IBeanDocument ):void;
		
		/**
		* 	The class used to instantiate the bean.
		*/
		function get instanceClass():Class;
		function set instanceClass( clazz:Class ):void;
		
		/**
		*	Whether the bean is a singleton.
		*/
		function get singleton():Boolean;
		function set singleton( value:Boolean ):void;
		
		/**
		* 	Properties to apply after instantiating the bean.
		*/
		function get properties():Object;
		function set properties( properties:Object ):void;
		
		/**
		* 	A bean policy used to determine how this bean should
		* 	be handled when it matches an existing bean definition.
		*/
		function get policy():String;
		function set policy( value:String ):void;		
		
		/**
		* 	Transfers the properties of an anonymous object representing
		* 	a bean descriptor into this descriptor.
		* 
		* 	@param target The target object containing bean information.
		*/
		function transfer( target:Object ):void;
		
		/**
		* 	Merges the properties of a source bean descriptor
		* 	into this descriptor overwriting any existing properties
		* 	defined by this bean descriptor.
		* 
		* 	@param source The source bean descriptor to merge into this bean descriptor.
		* 
		* 	@return A boolean indicating whether any properties were set.
		*/
		function merge( source:IBeanDescriptor ):Boolean;
		
		/**
		* 	Gets the bean that this descriptor represents.
		* 
		* 	@param inject Whether dependency injection is enabled when retrieving
		* 	the bean instance.
		* 
		* 	@return The bean instance.
		*/
		function getBean( inject:Boolean = true ):Object;
		
		/**
		* 	Determines whether this descriptor
		* 	represents a class to be instantiated.
		* 
		* 	@return Whether this bean descriptor is valid.
		*/
		function isBean():Boolean;
		
		/**
		* 	Gets a copy of the properties associated with this bean descriptor.
		* 
		* 	@return A copy of the bean properties.
		*/
		function copy():Object;
	
		/**
		* 	Gets the properties associated with this bean descriptor with
		* 	any expressions resolved.
		* 
		* 	@return A copy of the properties associated with this bean with
		* 	any bean expressions resolved.
		*/
		function getProperties():Object;
	}
}