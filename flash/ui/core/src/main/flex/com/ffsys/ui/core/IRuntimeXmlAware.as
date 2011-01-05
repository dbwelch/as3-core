package com.ffsys.ui.core
{

	public interface IRuntimeXmlAware
	{
		/**
		* 	Invoked for display objects that wish to be assigned
		* 	the xml definition that created them.
		*/
		function get xml():XML;
		function set xml( value:XML ):void;		
	}
}