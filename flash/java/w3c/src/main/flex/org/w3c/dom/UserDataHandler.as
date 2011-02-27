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
	public interface UserDataHandler
	{		
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
		function handle(
			operation:Number,
			key:String, 
			data:*,
			src:Node,
			dst:Node ):void;
	}
}