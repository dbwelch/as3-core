package com.ffsys.net.asax
{
	
	/**
	*	Represents a parsed attribute associated with
	* 	an element token.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  11.01.2011
	*/
	public class SaxAttribute extends Object
	{
		private var _xml:XML;
		
		/**
		* 	Creates a <code>SaxAttribute</code> instance.
		* 
		* 	@param xml The XML that defined the attribute.
		*/
		public function SaxAttribute( xml:XML = null ) 
		{
			super();
			this.xml = xml;
		}
		
		/**
		* 	Determinines whether the attribute was qualified
		* 	using a namespace.
		*/
		public function isQualified():Boolean
		{
			return uri && uri.toString().length > 0;
		}
		
		/**
		* 	The XML that defined the attribute.
		*/
		public function get xml():XML
		{
			if( _xml == null )
			{
				return new XML();
			}
			return _xml;
		}
		
		public function set xml( value:XML ):void
		{
			_xml = value;
		}
		
		/**
		*	A namespace <code>URI</code> for this attribute.
		*/
		public function get uri():String
		{
			if( _xml && _xml.name() )
			{
				return _xml.name().uri;
			}
			return null;
		}
		
		/**
		* 	The value of this attribute.
		*/
		public function get value():String
		{
			return xml.toString();
		}
		
		/**
		* 	The local name of the attribute.
		*/
		public function get name():String
		{
			if( _xml && _xml.name() )
			{
				return _xml.name().localName;
			}
			return null;
		}
	}
}