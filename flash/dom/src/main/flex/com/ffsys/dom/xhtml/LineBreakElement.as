package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a line break, the <code>br</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.01.2011
	*/
	dynamic public class LineBreakElement extends InlineElement
		implements EmptyElement
	{
		/**
		* 	Creates a <code>LineBreakElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function LineBreakElement( xml:XML = null )
		{
			super( xml );
		}
	}
}