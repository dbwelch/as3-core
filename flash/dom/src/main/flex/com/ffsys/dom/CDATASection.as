package com.ffsys.dom
{
	/**
	*	Represents a character data section element.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class CDATASection extends CharacterData
	{
		/**
		* 	Creates a <code>CDATASection</code> instance.
		*/
		public function CDATASection( xml:XML = null )
		{
			_nodeType = Node.CDATA_SECTION_NODE;
			super( xml );
		}
	}
}