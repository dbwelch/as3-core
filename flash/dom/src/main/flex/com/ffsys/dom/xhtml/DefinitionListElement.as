package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a definition list, the <code>dl</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class DefinitionListElement extends BlockElement
	{
		/**
		* 	Creates a <code>DefinitionListElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function DefinitionListElement( xml:XML = null )
		{
			super( xml );
		}
	}
}