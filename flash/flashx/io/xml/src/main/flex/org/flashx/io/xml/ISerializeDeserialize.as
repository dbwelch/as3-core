package org.flashx.io.xml {
	
	/**
	*	Describes the contract for custom classes that want to provide
	*	their own XML serialize/deserialize functionality. This allows
	*	for private member variables to be serialized and deserialized
	*	as well as enabling an ISerializeContract to describe the
	*	contract for the serialization process. A contract describes
	*	the properties of the instance that should be serialized.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.05.2007
	*/
	public interface ISerializeDeserialize
		extends IDeserializeProperty {
	
		/**
		*	Instructs the instance to return an XML serialized representation of itself
		*	against a given ISerializeContract.
		*
		*	@param x the target XML node this instance is being serialized into
		*	@param serializer the Serializer performing the serialization
		*	@param contract the ISerializeContract to serialize against
		*
		*	@return a serialized XML representation of the instance
		*/
		function serialize( x:XML, serializer:Serializer, contract:ISerializeContract ):XML;
		
		/**
		*	Instructs the instance to deserialize from an XML serialized state
		*	into an Object structure.
		*
		*	@param x the source XML to deserialize from
		*	@param obj the current Object being deserialized into
		*	@param contract the ISerializeContract to deserialize against
		*
		*	@return the deserialized instance
		*/
		function deserialize( x:XML, obj:Object, deserializer:Deserializer, contract:ISerializeContract ):Object;
		
		/**
		*	Given an <code>Array</code> of <code>String</code> property
		*	name values the instance implementing this interface should
		*	return an <code>Object</code> with the property name as the key
		*	and the value of the property on the instance being serialized.
		*
		*	@param names an Array of String property names
		*	
		*	@return an Object containing the property values with the String names as the keys
		*/
		function getProperties( names:Array ):Object;
		
		/**
		*	Must return the default contract to use when serializing.
		*
		*	If you have not declared a custom contract return a new
		*	SerializeContract instance. This is a placeholder class
		*	with no public properties declared, so no serialization occurs.
		*
		*	@return an instance conforming to the ISerializeContract interface 
		*/
		function getDefaultContract():ISerializeContract;
	}
	
}