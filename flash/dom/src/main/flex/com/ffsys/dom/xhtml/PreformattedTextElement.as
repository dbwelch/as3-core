package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents preformatted text, the <code>pre</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class PreformattedTextElement extends BlockElement
	{
		/**
		* 	Creates a <code>PreformattedTextElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function PreformattedTextElement( xml:XML = null )
		{
			super( xml );
		}
	}
}