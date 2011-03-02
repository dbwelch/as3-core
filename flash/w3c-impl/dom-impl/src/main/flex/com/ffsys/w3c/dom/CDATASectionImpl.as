package com.ffsys.w3c.dom
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
		* 	The bean name for this node.
		*/
		public static const NAME:String = "CDATASection";
		
		/**
		* 	The node name for CDATA section nodes.
		*/
		public static const NODE_NAME:String = "#cdata-section";
		
		/**
		* 	Creates a <code>CDATASectionImpl</code> instance.
		*/
		public function CDATASectionImpl()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeName():String
		{
			return NODE_NAME;
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get nodeType():Number
		{
			return NodeType.CDATA_SECTION_NODE;
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