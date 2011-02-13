package com.ffsys.dom
{
	import com.ffsys.dom.core.*;
	
	/**
	*	Represents an <code>XHTML</code> document.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  09.01.2011
	*/
	dynamic public class XhtmlDocument extends Document
	{
		private var _version:String;
		private var _schemaLocation:String;
		
		/**
		* 	Creates an <code>XhtmlDocument</code> instance.
		*/
		public function XhtmlDocument( xml:XML = null )
		{
			super( xml );
		}
		
		/**
		* 	The version of the document.
		*/
		public function get version():String
		{
			return _version;
		}
		
		public function set version( value:String ):void
		{
			_version = value;
		}
		
		/**
		* 	A schema location for the document.
		*/
		public function get schemaLocation():String
		{
			return _schemaLocation;
		}
		
		public function set schemaLocation( value:String ):void
		{
			_schemaLocation = value;
		}
	}
}