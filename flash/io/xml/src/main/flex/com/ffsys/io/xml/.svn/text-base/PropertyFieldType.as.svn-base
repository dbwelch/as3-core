package com.ffsys.io.xml {

	import com.ffsys.utils.array.ArrayUtils;
	
	/**
	*	Represents the types that can be used to determine
	*	which value should be used as the property name
	*	when serializing/deserializing.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  17.07.2007
	*/
	public class PropertyFieldType extends Object {
		
		static public const ATTRIBUTE:String = "attribute";
		static public const CHILD_NODE:String = "childNode";
		static public const NODE_NAME:String = "nodeName";
		
		static public const TYPES:Array = [ ATTRIBUTE, CHILD_NODE, NODE_NAME ];
	 	
		public function PropertyFieldType()
		{
			super();
		}
		
		/**
		*	Determines whether a property field type is valid.
		*
		*	@param type a String of the property field type
		*
		*	@return a Boolean indicating whether the property field type is valid
		*/
		static public function isValidType( type:String ):Boolean
		{
			return ArrayUtils.contains( TYPES, type );
		}		
		
	}
	
}
