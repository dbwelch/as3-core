package com.ffsys.dom
{
	
	/**
	*	Represents a visual element that is treated as a block.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.01.2011
	*/
	dynamic public class InlineElement extends VisualElement
	{
		/**
		* 	Creates a <code>InlineElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function InlineElement( xml:XML = null )
		{
			super( xml );
		}
	}
}