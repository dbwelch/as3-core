package org.w3c.dom
{
	/**
	* 	Represents a user data handler.
	* 
	* 	When associating an object to a key on
	* 	a node using Node.setUserData() the
	* 	application can provide a handler that
	* 	gets called when the node the object
	* 	is associated to is being cloned,
	* 	imported, or renamed. This can be used
	* 	by the application to implement various
	* 	behaviors regarding the data it associates
	* 	to the DOM nodes. This interface defines that handler.
	*/
	public class UserDataHandler
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
		* 	Handles a user data operation.
		* 
		* 	This method is called whenever the node
		* 	for which this handler is registered is imported or cloned. 
		*	DOM applications must not raise exceptions in
		* 	a UserDataHandler. The effect of
		* 	throwing exceptions from the handler is DOM
		* 	implementation dependent.
		* 
		* 	@param operation Specifies the type of operation that
		* 	is being performed on the node.
		* 	@param key Specifies the key for which this
		* 	handler is being called.
		* 	@param data Specifies the data for which this
		* 	handler is being called.
		* 	@param src Specifies the node being cloned, adopted, imported,
		* 	or renamed. This is null when the node is being deleted.
		* 	@param dst Specifies the node newly created if any, or null.
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