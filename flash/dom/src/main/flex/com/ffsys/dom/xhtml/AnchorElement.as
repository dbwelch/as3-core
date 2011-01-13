package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents an anchor, the <code>a</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.01.2011
	*/
	dynamic public class AnchorElement extends BlockElement
	{
		/**
		* 	Creates a <code>AnchorElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function AnchorElement( xml:XML = null )
		{
			super( xml );
		}
	}
}