package org.w3c.dom
{
	/**
	* 	Encapsulates the constants that represent Node types.
	*/
	public class NodeType extends Object
	{		
		/**
		* 	The node is an Element.
		*/
		public static const ELEMENT_NODE:Number = 1;
	
		/**
		* 	The node is an Attr.
		*/
		public static const ATTRIBUTE_NODE:Number = 2;
	
		/**
		* 	The node is a Text node.
		*/
		public static const TEXT_NODE:Number = 3;
	
		/**
		* 	The node is a CDATASection.
		*/
		public static const CDATA_SECTION_NODE:Number = 4;
	
		/**
		* 	The node is an EntityReference.
		*/
		public static const ENTITY_REFERENCE_NODE:Number = 5;
	
		/**
		* 	The node is an Entity.
		*/
		public static const ENTITY_NODE:Number = 6;
	
		/**
		* 	The node is a ProcessingInstruction.
		*/
		public static const PROCESSING_INSTRUCTION_NODE:Number = 7;
	
		/**
		* 	The node is a Comment.
		*/
		public static const COMMENT_NODE:Number = 8;
	
		/**
		* 	The node is a Document.
		*/
		public static const DOCUMENT_NODE:Number = 9;
	
		/**
		* 	The node is a DocumentType.
		*/
		public static const DOCUMENT_TYPE_NODE:Number = 10;
	
		/**
		* 	The node is a DocumentFragment.
		*/
		public static const DOCUMENT_FRAGMENT_NODE:Number = 11;
	
		/**
		* 	The node is a Notation.
		*/
		public static const NOTATION_NODE:Number = 12;
	}
}