package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a table header, the <code>th</code> element.
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
	dynamic public class TableHeaderElement extends VisualElement
	{
		//TODO
		//Other: colspan axis rowspan valign scope align headers abbr
		
		/**
		* 	Creates a <code>TableHeaderElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function TableHeaderElement( xml:XML = null )
		{
			super( xml );
		}
	}
}
