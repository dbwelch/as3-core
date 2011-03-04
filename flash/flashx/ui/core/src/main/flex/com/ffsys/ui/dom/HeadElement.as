package com.ffsys.ui.dom
{
	/**
	*	A <code>DOM</code> element used to store the
	* 	the meta information about the document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class HeadElement extends Node
		implements IDocumentHead
	{
		/**
		* 	Creates a <code>HeadElement</code> instance.
		*/
		public function HeadElement( xml:XML = null )
		{
			super( xml );
		}
	}
}