package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents an ordered list, the <code>ol</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	dynamic public class OrderedListElement extends BlockElement
	{
		/**
		* 	Creates a <code>OrderedListElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function OrderedListElement( xml:XML = null )
		{
			super( xml );
		}
	}
}