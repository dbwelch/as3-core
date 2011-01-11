package com.ffsys.net.sax
{

	public class SAXAttribute extends Object
	{
		
		private var _xml:XML;
	
		public function SAXAttribute( xml:XML = null ) 
		{
			super();
			this.xml = xml;
		}
		
		/**
		* 	The XML that defined the attribute.
		*/
		public function get xml():XML
		{
			return _xml;
		}
		
		public function set xml( value:XML ):void
		{
			_xml = value;
		}
		
		/**
		* 	The local name of the attribute.
		*/
		public function get name():String
		{
			if( _xml )
			{
				return _xml.name().localName;
			}
			return null;
		}
	}
}