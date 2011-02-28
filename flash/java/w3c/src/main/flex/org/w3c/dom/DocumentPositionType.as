package org.w3c.dom
{
	/**
	* 	Encapsulates the constants that represent document
	* 	positions.
	*/
	public class DocumentPositionType extends Object
	{
		/**
		* 	The two nodes are disconnected.
		* 
		* 	Order between disconnected nodes is always implementation-specific.
		*/
		public static const DOCUMENT_POSITION_DISCONNECTED:Number = 0x01;
	
		/**
		* 	The second node precedes the reference node.	
		*/
		public static const DOCUMENT_POSITION_PRECEDING:Number = 0x02;
	
		/**
		* 	The node follows the reference node.
		*/
		public static const DOCUMENT_POSITION_FOLLOWING:Number = 0x04;
	
		/**
		* 	The node contains the reference node.
		* 	
		* 	A node which contains is always preceding, too.
		*/
		public static const DOCUMENT_POSITION_CONTAINS:Number = 0x08;
	
		/**
		* 	The node is contained by the reference node.
		* 	
		* 	A node which is contained is always following, too.
		*/
		public static const DOCUMENT_POSITION_CONTAINED_BY:Number = 0x10;
	
		/**
		* 	The determination of preceding versus
		* 	following is implementation-specific.
		*/
		public static const DOCUMENT_POSITION_IMPLEMENTATION_SPECIFIC:Number = 0x20;	
	}
}