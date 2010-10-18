package com.ffsys.io.xml.parsers {
	
	import com.ffsys.io.xml.DeserializationMode;
	import com.ffsys.io.xml.Parser;

	/**
	*	A parser implementation for testing primtive data type deserialization.
	*  
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*	
	*	@author Mischa Williamson
	*	@since  18.10.2010
	*/
	public class PrimitiveParser extends Parser {		

		/**
		*	Creates a <code>PrimitiveParser</code> instance.
		*	
		*	@param root The class to instantiate for the root node.
		*	@param node The class to use when no mapping can be found.
		*/
		public function PrimitiveParser(
			root:Class = null, node:Class = null )
		{
			if( !root )
			{
				root = Object;
			}
			
			super( root, node );
		}
		
		/**
		*	@inheritDoc
		*/
		override protected function initialize():void
		{
			super.initialize();
			
			this.deserializer.mode = DeserializationMode.POST_PROPERTY_SET;
			
			classNodeNameMap.add(
				Object,
				"object",
				"object",
				false );
				
			classNodeNameMap.add(
				Array,
				"array",
				"array",
				false );						
		}
		
		/**
		*	@inheritDoc
		*/
		public function parse(
			x:XML, target:Object = null ):Object
		{
			return _deserializer.deserialize( x, target ) as Object;
		}
	}
}