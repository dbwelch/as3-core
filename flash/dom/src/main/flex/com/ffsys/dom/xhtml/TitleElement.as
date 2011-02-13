package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;	
	import com.ffsys.dom.core.Element;
	
	/**
	*	Represents the title of a document, the <code>title</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  14.01.2011
	*/
	public class TitleElement extends Element
		implements TextElement
	{
		/**
		* 	Creates a <code>TitleElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function TitleElement( xml:XML = null )
		{
			super( xml );
		}
	}
}