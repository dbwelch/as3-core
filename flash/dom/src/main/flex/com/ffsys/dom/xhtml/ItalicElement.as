package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents italicized text, the <code>i</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class ItalicElement extends InlineElement
	{
		/**
		* 	Creates an <code>ItalicElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function ItalicElement( xml:XML = null )
		{
			super( xml );
		}
	}
}