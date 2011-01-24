package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents an inline code sample, the <code>samp</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class SampleElement extends InlineElement
	{
		/**
		* 	Creates a <code>SampleElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function SampleElement( xml:XML = null )
		{
			super( xml );
		}
	}
}