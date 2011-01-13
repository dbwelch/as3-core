package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents emphasis, the <code>em</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	dynamic public class EmElement extends InlineElement
	{
		/**
		* 	Creates a <code>EmElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function EmElement( xml:XML = null )
		{
			super( xml );
		}
	}
}