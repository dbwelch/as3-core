package com.ffsys.utils.reflection.members {
	
	import com.ffsys.utils.array.ArrayUtils;
	import com.ffsys.utils.reflection.Reflection;
	
	/**
	*	Represents the available identifier types for members.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.08.2007
	*/
	public class MemberType extends Object {
		
		static public const PUBLIC_TYPE:String = "public";
		static public const PRIVATE_TYPE:String = "private";
		static public const PROTECTED_TYPE:String = "protected";
		static public const INTERNAL_TYPE:String = "internal";
		
		static public const VALID_TYPES:Array = [
			PUBLIC_TYPE,
			PRIVATE_TYPE,
			PROTECTED_TYPE,
			INTERNAL_TYPE
		];
		
		/**
		*	@private
		*/
		public function MemberType()
		{
			super();
		}
		
		/**
		*	Determines whether a member type is valid.
		*
		*	@param type a String of the member type
		*
		*	@return a Boolean indicating whether the member type is valid
		*/
		static public function isValidType( type:String ):Boolean
		{
			return ArrayUtils.contains( VALID_TYPES, type );
		}		
		
	}
	
}
