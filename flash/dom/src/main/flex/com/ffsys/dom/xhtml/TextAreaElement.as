package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a text area, the <code>textarea</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.01.2011
	*/
	dynamic public class TextAreaElement extends InlineElement
		implements TextElement
	{
		//cols disabled onchange rows readonly onselect onfocus accesskey onblur name inputmode tabindex
		
		/**
		* 	Creates an <code>TextAreaElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function TextAreaElement( xml:XML = null )
		{
			super( xml );
		}
	}
}