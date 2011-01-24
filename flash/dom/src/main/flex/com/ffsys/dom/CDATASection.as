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
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return Node.CDATA_SECTION_NODE;
		}
		
		/**
		* 	An <code>XML</code> representation of this node.
		*/
		override public function get xml():XML
		{
			if( _xml == null || _xml.toString() != data )
			{
				_xml = new XML( "<![CDATA[" + data + "]]>" );
			}
			return _xml;
		}
	}
}