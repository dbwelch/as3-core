package org.flashx.io.xml {
	
	/**
	*	Describes the contract for instances
	*	that control the property name field and
	*	type that can be used when serializing/
	*	deserializing.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2007
	*/
	public interface ISerializeDeserializeProperty {
		function set propertyField( val:String ):void;
		function get propertyField():String;
		
		function set propertyFieldType( val:String ):void;
		function get propertyFieldType():String;
	}
	
}
