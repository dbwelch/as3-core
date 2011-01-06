package com.ffsys.ui.core
{
	import com.ffsys.io.xml.IParser;

	public interface IRuntimeXmlAware
	{
		/**
		* 	Invoked for display objects that wish to be assigned
		* 	the xml definition that created them.
		*/
		function get xml():XML;
		function set xml( value:XML ):void;	
		
		/**
		* 	The parser that deserialized the xml.
		*/
		function get parser():Object;
		function set parser( value:Object ):void;
	}
}