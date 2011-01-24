package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a definition, the <code>dd</code> element.
	* 
	* 	This element is not considered to be either <code>block</code>
	* 	or <code>inline</code> by default but is a container for other elements.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class DefinitionElement extends VisualElement
	{
		/**
		* 	Creates a <code>DefinitionElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function DefinitionElement( xml:XML = null )
		{
			super( xml );
		}
	}
}