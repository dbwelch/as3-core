package com.ffsys.io.xml {
	
	/**
	*	Describes the contract for instances that
	*	handle setting deserialized properties
	*	themselves.
	*	
	*	This allows for serialization and 
	*	deserialization routines that can handle
	*	private member variables.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  10.09.2007
	*/
	public interface IDeserializeProperty {
		
		/**
		*	Instructs the instance created during the
		*	deserialization process to set a
		*	deserialized property on itself.
		*
		*	@param prop The <code>String</code> name of the property to set.
		*	@param value The <code>Object</code> value for the property.
		*/
		function setDeserializedProperty( name:String, value:Object ):void;
	}
}