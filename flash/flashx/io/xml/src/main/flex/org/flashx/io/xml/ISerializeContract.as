package org.flashx.io.xml {
	
	/**
	*	Describes the contract for XML serialization description contracts.
	*
	*	A class that is an XML description simply lists the member variables
	*	that should be serialized on the target instance as public member
	*	variables.
	*
	*	The method getPropertyNames() should return an Array of the property
	*	names declared that should be serialized on the target instance.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  26.05.2007
	*/
	public interface ISerializeContract {
		
		/**
		*	Returns an Array of the public member names declared in this contract.
		*
		*	@return an Array of public member names
		*/
		function getPropertyNames():Array;
		
		/**
		*	Instructs the SerializeContract instance to serialize the properties
		*	declared in the <code>obj</code> second argument. Key names are the
		*	node/attribute names.
		*/
		function serialize( x:XML = null, obj:Object = null, serializer:Serializer = null, options:SerializeOptions = null ):XML;
	}
	
}

