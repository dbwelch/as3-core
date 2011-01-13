package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a paragraph, the <code>p</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.01.2011
	*/
	dynamic public class ParagraphElement extends BlockElement
	{
		/**
		* 	Creates a <code>ParagraphElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function ParagraphElement( xml:XML = null )
		{
			super( xml );
		}
	}
}