package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a span of inline text, the <code>span</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	dynamic public class SpanElement extends InlineElement
	{
		/**
		* 	Creates a <code>SpanElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function SpanElement( xml:XML = null )
		{
			super( xml );
		}
	}
}