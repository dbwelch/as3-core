package com.ffsys.ui.dom
{
	import com.ffsys.ui.containers.Container;
	
	/**
	*	A container for the document body elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class BodyElement extends Node
		implements IDocumentBody
	{
		/**
		* 	Creates a <code>BodyElement</code> instance.
		*/
		public function BodyElement( xml:XML = null )
		{
			super( xml );
		}
	}
}