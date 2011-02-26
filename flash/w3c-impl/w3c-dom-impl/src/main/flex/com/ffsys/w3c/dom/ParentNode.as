package com.ffsys.w3c.dom
{
	/**
	* 	Abstract super class for nodes that may have
	* 	child nodes.
	*/
	public class ParentNode extends ChildNode
	{
		/**
		* 	Creates a <code>ParentNode</code> instance.
		* 
		* 	@param owner The owner of the node.
		*/
		public function ParentNode( owner:CoreDocumentImpl = null )
		{
			super( owner );
		}
	}
}