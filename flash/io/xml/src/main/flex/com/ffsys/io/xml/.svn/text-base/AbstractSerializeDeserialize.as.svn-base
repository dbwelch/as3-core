package com.ffsys.io.xml {
	
	import com.ffsys.io.xml.Deserializer;
	import com.ffsys.io.xml.ISerializeContract;	
	import com.ffsys.io.xml.ISerializeDeserialize;
	import com.ffsys.io.xml.Serializer;
	import com.ffsys.io.xml.SerializeContract;
	
	import com.ffsys.io.xml.DeserializeError;
	
	/**
	*	Reference implementation of a class that handles serializing and deserializing within
	*	it's own scope. This allows an ISerializeContract to be used when serializing
	*	the instance. The contract determines which properties are serialized.
	*
	*	In addition this allows for private member variables to be serialized/deserialized
	*	if necessary.
	*
	*	This is a reference implementation of the ISerializeDeserialize interface
	*	and allows your classes to use this as a super class for performing custom
	*	serialization/deserialization.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  29.05.2007
	*/
	public class AbstractSerializeDeserialize extends Object
		implements ISerializeDeserialize {
		
		public function AbstractSerializeDeserialize()
		{
			super();
		}
		
		public function getDefaultContract():ISerializeContract
		{
			return new SerializeContract();
		}
		
		public function getProperties( names:Array ):Object
		{
			var obj:Object = {};
			
			var i:int = 0;
			var l:int = names.length;
			
			var name:String = null;
			
			for( ;i < l;i++ )
			{
				name = names[ i ];
				obj[ name ] = this[ name ];
			}
			
			return obj;
		}
		
		public function serialize( x:XML, serializer:Serializer, contract:ISerializeContract ):XML
		{
			var names:Array = contract.getPropertyNames();
			var props:Object = getProperties( names );
			
			return contract.serialize( x, props, serializer );
		}
		
		public function setDeserializedProperty( prop:String, val:Object ):void
		{
			this[ prop ] = val;
		}
		
		public function deserialize( x:XML, obj:Object, deserializer:Deserializer, contract:ISerializeContract ):Object
		{
			var names:Array = contract.getPropertyNames();
			
			var i:int = 0;
			var l:int = names.length;
			
			var name:String;
			
			var node:XML;
			
			for( ;i < l;i++ )
			{
				name = names[ i ];
				
				if( SerializeContract( contract ).isAttributeProperty( name ) )
				{
					this[ name ] = x.attribute( name );
					continue;
				}				
				
				node = XML( x[ name ] );
				
				if( !node )
				{
					throw new DeserializeError( "ISerializeDeserialize cannot deserialize non-existent node for: " + name );
				}
				
				/*
				trace( "Property name  : " + name );
				trace( "Property node is null  : " + ( node == null ) );
				trace( "Property node  : " + node.toXMLString() );
				*/
				
				this[ name ] = deserializer.parse( XML( node ), this, true );
			}
			
			return this;
		}		

	}
	
}
