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
		implements EmptyElement
	{
		//TODO
		//Other: accept disabled alt onchange size checked readonly onselect onfocus type accesskey onblur src name value inputmode maxlength tabindex
		
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