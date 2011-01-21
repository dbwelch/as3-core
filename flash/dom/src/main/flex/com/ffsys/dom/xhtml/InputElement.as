package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a form input, the <code>input</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.01.2011
	*/
	dynamic public class InputElement extends InlineElement
	{
		/**
		* 	Creates an <code>InputElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function InputElement( xml:XML = null )
		{
			super( xml );
		}
	}
}