package org.flashx.ioc
{
	import org.flashx.core.IDestroy;
	import org.flashx.core.IStringIdentifier;
	
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
		extends	IBeanElement
	{
		/**
		* 	A collection of string aliases for this bean definition.
		*/
		function get names():Vector.<String>;
		function set names( value:Vector.<String> ):void;
		
		/**
		* 	Clears this bean descriptor ready for an object
		* 	to be transferred into this descriptor. 
		*/
		function clear():void;
		
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
		* 	Sets a property on a target object.
		* 
		* 	@param target The bean target.
		* 	@param name The property name.
		* 	@param value The balue to set the property to.
		* 
		* 	@return A boolean indicating whether the property was successfully set.
		*/
		function setBeanProperty( target:Object, name:String, value:* ):Boolean;
		
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
		* 	@param finalize Whether the bean should be notified as being
		* 	finalized when the instantiation is complete.
		* 
		* 	@return The bean instance.
		*/
		function getBean( inject:Boolean = true, finalize:Boolean = true ):Object;
		
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
		function copy( target:Object = null ):Object;
	
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