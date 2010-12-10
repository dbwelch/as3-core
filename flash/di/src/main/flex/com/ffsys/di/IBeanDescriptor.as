package com.ffsys.di
{
	import com.ffsys.core.IStringIdentifier;
	
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
		*/
		function transfer( target:Object ):void;
		
		/**
		* 	Gets the bean that this descriptor represents.
		*/
		function getBean():Object;
		
		/**
		* 	Determines whether this descriptor
		* 	represents a class to be instantiated.
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
		*/
		function getProperties():Object;
	}
}