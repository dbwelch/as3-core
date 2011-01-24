package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents tabular data, the <code>table</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class TableElement extends BlockElement
	{
		
		//TODO
		//Other: summary width
		
		/**
		* 	Creates a <code>TableElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function TableElement( xml:XML = null )
		{
			super( xml );
		}
	}
}