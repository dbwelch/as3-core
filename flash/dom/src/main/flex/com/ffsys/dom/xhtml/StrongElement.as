package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents strong emphasis, the <code>strong</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	dynamic public class StrongElement extends InlineElement
	{
		/**
		* 	Creates a <code>StrongElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function StrongElement( xml:XML = null )
		{
			super( xml );
		}
	}
}