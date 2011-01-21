package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a label, the <code>label</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  21.01.2011
	*/
	dynamic public class LabelElement extends InlineElement
	{
		/**
		* 	Creates a <code>LabelElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function LabelElement( xml:XML = null )
		{
			super( xml );
		}
	}
}