package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a list item, the <code>li</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	dynamic public class ListItemElement extends InlineElement
	{
		/**
		* 	Creates a <code>ListItemElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function ListItemElement( xml:XML = null )
		{
			super( xml );
		}
	}
}