package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents bold text, the <code>b</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class BoldElement extends InlineElement
	{
		/**
		* 	Creates a <code>BoldElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function BoldElement( xml:XML = null )
		{
			super( xml );
		}
	}
}