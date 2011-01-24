package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents a set of fields, the <code>fieldset</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class FieldSetElement extends BlockElement
	{
		/**
		* 	Creates a <code>FieldSetElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function FieldSetElement( xml:XML = null )
		{
			super( xml );
		}
	}
}