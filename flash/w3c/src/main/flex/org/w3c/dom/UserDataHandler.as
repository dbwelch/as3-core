package org.w3c.dom
{
	/**
	* 	TODO
	*/
	public class UserDataHandler
	{
		public static const NODE_CLONED:Number = 1;
		
		public static const NODE_IMPORTED:Number = 2;
		
		public static const NODE_DELETED:Number = 3;			
		
		public static const NODE_RENAMED:Number = 4;
		
		public static const NODE_ADOPTED:Number = 5;
		
		/**
		* 	Represents a user data handler
		* 	method signature.
		*/
		static public function signature(
			index:Number,
			name:String, 
			value:*,
			source:Node,
			target:Node ):void
		{
			//
		}
	}
}