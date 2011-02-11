package com.ffsys.dom.core
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
		* 	Creates a <code>DocumentFragmentImpl</code> instance.
		*/
		public function DocumentFragmentImpl( xml:XML = null )
		{
			super( xml );
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