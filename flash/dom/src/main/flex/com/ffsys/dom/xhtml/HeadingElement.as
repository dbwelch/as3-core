package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a heading, the <code>h1</code> to <code>h6</code> elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	dynamic public class HeadingElement extends BlockElement
	{
		/**
		* 	Creates a <code>HeadingElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function HeadingElement( xml:XML = null )
		{
			super( xml );
		}
	}
}