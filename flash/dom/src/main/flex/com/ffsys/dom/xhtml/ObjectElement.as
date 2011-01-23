package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents an object, the <code>object</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  23.01.2011
	*/
	dynamic public class ObjectElement extends InlineElement
	{
		//Other : classid codetype archive width type codebase height data name standby declare tabindex
		
		/**
		* 	Creates a <code>ObjectElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function ObjectElement( xml:XML = null )
		{
			super( xml );
		}
	}
}