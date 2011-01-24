package com.ffsys.dom.xhtml
{
	import com.ffsys.dom.*;
	
	/**
	*	Represents teletype (monospaced) text, the <code>tt</code> element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  24.01.2011
	*/
	dynamic public class TeleTypeTextElement extends InlineElement
	{
		/**
		* 	Creates a <code>TeleTypeTextElement</code> instance.
		* 
		* 	@param xml An <code>XML</code> fragment that
		* 	defines the element.
		*/
		public function TeleTypeTextElement( xml:XML = null )
		{
			super( xml );
		}
	}
}