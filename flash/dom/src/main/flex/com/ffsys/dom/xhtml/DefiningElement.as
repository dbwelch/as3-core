package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents the element that contains the defining instance
	* 	of the enclosed term, the <code>dfn</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class DefiningElement extends InlineElement
	{
		/**
		* 	Creates a <code>DefiningElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function DefiningElement( xml:XML = null )
		{
			super( xml );
		}
	}
}