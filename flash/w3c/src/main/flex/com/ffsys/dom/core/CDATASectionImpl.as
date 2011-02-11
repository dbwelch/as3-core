package com.ffsys.dom.core
{
	import org.w3c.dom.*;
		
	/**
	*	Represents a character data section.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class CDATASectionImpl extends TextImpl
		implements CDATASection
	{
		/**
		* 	Creates a <code>CDATASectionImpl</code> instance.
		*/
		public function CDATASectionImpl( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeImpl.CDATA_SECTION_NODE;
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