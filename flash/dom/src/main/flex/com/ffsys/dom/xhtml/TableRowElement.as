package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a table row, the <code>tr</code> element.
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
	dynamic public class TableRowElement extends VisualElement
	{
		//TODO
		//Other: align valign
		
		/**
		* 	Creates a <code>TableRowElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function TableRowElement( xml:XML = null )
		{
			super( xml );
		}
	}
}
