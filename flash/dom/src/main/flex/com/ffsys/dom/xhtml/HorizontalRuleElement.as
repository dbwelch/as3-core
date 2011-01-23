package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a horizontal rule, the <code>hr</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.01.2011
	*/
	dynamic public class HorizontalRuleElement extends BlockElement
		implements EmptyElement
	{
		/**
		* 	Creates a <code>HorizontalRuleElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function HorizontalRuleElement( xml:XML = null )
		{
			super( xml );
		}
	}
}