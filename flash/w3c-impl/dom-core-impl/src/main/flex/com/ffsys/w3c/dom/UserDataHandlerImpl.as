package com.ffsys.w3c.dom
{
	import org.w3c.dom.Node;	
	import org.w3c.dom.UserDataHandler;
	
	/**
	* 	An abstract super class for 
	* 	user data handler implementations.
	*/
	public class UserDataHandlerImpl extends Object
		implements UserDataHandler
	{
		/**
		*	The node is cloned, using Node.cloneNode().
		*/
		public static const NODE_CLONED:Number = 1;
		
		/**
		* 	The node is imported, using Document.importNode().
		*/
		public static const NODE_IMPORTED:Number = 2;
		
		/**
		* 	The node is deleted.
		* 
		*	Note: This may not be supported or may not be
		* 	reliable in certain environments, such as Java,
		* 	where the implementation has no real control
		* 	over when objects are actually deleted.
		*/
		public static const NODE_DELETED:Number = 3;			
		
		/**
		* 	The node is renamed, using Document.renameNode().
		*/
		public static const NODE_RENAMED:Number = 4;
		
		/**
		* 	The node is adopted, using Document.adoptNode().
		*/
		public static const NODE_ADOPTED:Number = 5;
		
		/**
		* 	@private
		* 
		* 	Creates a <code>UserDataHandlerImpl</code> instance.
		*/
		public function UserDataHandlerImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		public function handle(
			operation:Number,
			key:String, 
			data:*,
			src:Node,
			dst:Node ):void
		{
			//
		}
	}
}