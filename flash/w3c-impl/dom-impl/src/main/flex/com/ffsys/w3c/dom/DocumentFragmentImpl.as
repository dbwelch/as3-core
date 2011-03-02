package com.ffsys.w3c.dom
{
	import org.w3c.dom.*;	
	
	/**
	*	Represents a document fragment.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class DocumentFragmentImpl extends ParentNode
		implements DocumentFragment
	{
		/**
		* 	The bean name for this node.
		*/
		public static const NAME:String = "DocumentFragment";
		
		/**
		* 	The node name for document fragment nodes.
		*/
		public static const NODE_NAME:String = "#document-fragment";
		
		/**
		* 	Creates a <code>DocumentFragmentImpl</code> instance.
		* 
		* 	@param owner The owner document.
		*/
		public function DocumentFragmentImpl(
			owner:CoreDocumentImpl = null )
		{
			super( owner );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return NODE_NAME;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeType.DOCUMENT_FRAGMENT_NODE;
		}
	}
}