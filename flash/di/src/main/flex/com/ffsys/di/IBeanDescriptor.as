package com.ffsys.di
{
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
	public interface IBeanDescriptor extends IStringIdentifier
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
		* 	Transfers the properties of an anonymous object representing
		* 	a bean descriptor into this descriptor.
		* 
		* 	@param target The target object containing bean information.
		*/
		function transfer( target:Object ):void;
		
		/**
		* 	Gets the bean that this descriptor represents.
		* 
		* 	@return The bean instance.
		*/
		function getBean():Object;
		
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