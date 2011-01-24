package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a button, the <code>button</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class ButtonElement extends InlineElement
	{
		//TODO
		//Other: disabled onfocus type accesskey onblur name value tabindex
		
		/**
		* 	Creates a <code>ButtonElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function ButtonElement( xml:XML = null )
		{
			super( xml );
		}
	}
}