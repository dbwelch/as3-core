package com.ffsys.w3c.dom.core
{
	import org.w3c.dom.*;	
	
	/**
	* 	TODO
	*/
	public class TypeInfoImpl extends Object
		implements TypeInfo
	{
		/**
		* 	TODO
		*/
		public static const DERIVATION_RESTRICTION:Number = 0x01;
		
		/**
		* 	TODO
		*/
		public static const DERIVATION_EXTENSION:Number = 0x02;
		
		/**
		* 	TODO
		*/
		public static const DERIVATION_UNION:Number = 0x04;
		
		/**
		* 	TODO
		*/
		public static const DERIVATION_LIST:Number = 0x08;
		
		private var _typeName:String;
		private var _typeNamespace:String;
		
		/**
		* 	Creates a <code>TypeInfoImpl</code> instance.
		*/
		public function TypeInfoImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get typeName():String
		{
			//TODO			
			return _typeName;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function get typeNamespace():String
		{
			//TODO			
			return _typeNamespace;
		}
		
		/**
		* 	@inheritDoc
		*/
		public function isDerivedFrom(
			typeNamespaceArg:String,
			typeNameArg:String,
			derivationMethod:int ):Boolean
		{
			//TODO
			return false;
		}
	}
}