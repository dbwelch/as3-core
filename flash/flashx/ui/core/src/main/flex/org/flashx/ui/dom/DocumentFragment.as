package org.flashx.ui.dom
{
	
	/**
	*	Represents a document fragment element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	public class DocumentFragment extends Node
	{
		/**
		* 	Creates a <code>DocumentFragment</code> instance.
		*/
		public function DocumentFragment( xml:XML = null )
		{
			_nodeType = Node.DOCUMENT_FRAGMENT_NODE;
			super( xml );
		}
	}
}