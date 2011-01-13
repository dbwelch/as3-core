package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents an unordered list, the <code>ul</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	dynamic public class UnorderedListElement extends BlockElement
	{
		/**
		* 	Creates a <code>UnorderedListElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function UnorderedListElement( xml:XML = null )
		{
			super( xml );
		}
	}
}