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
	public class DocumentFragmentImpl extends NodeImpl
		implements DocumentFragment
	{
		/**
		* 	The node name for document fragment nodes.
		*/
		public static const NODE_NAME:String = "#document-fragment";
		
		/**
		* 	Creates a <code>DocumentFragmentImpl</code> instance.
		*/
		public function DocumentFragmentImpl()
		{
			super();
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
			return NodeImpl.DOCUMENT_FRAGMENT_NODE;
		}
	}
}