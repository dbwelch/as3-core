package org.flashx.io.xml {
	
	import flash.utils.Dictionary;
	
	/**
	*	Stores SerializeContract instances based on Class reference.
	*
	*	This enables a Serializer instance to map nested objects to
	*	particular contracts when operating in a generic recursive
	*	fashion.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  30.05.2007
	*/
	dynamic public class ContractRegistry extends Dictionary {
		
		public function ContractRegistry( weakReference:Boolean = true )
		{
			super( weakReference );
		}
		
		public function set( c:Class, contract:ISerializeContract ):void
		{	
			this[ c ] = contract;
		}
		
		public function get( c:Class ):ISerializeContract
		{
			return this[ c ];
		}
	}
	
}
