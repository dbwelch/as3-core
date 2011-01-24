package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents text to be entered by the user,
	* 	the <code>kbd</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class KeyboardElement extends InlineElement
	{
		/**
		* 	Creates a <code>KeyboardElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function KeyboardElement( xml:XML = null )
		{
			super( xml );
		}
	}
}