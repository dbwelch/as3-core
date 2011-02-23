package com.ffsys.w3c.xni
{
	import javax.xml.namespace.QualifiedName;
	
	/**
	* 	A qualified name representation for XNI.
	* 
	* 	This implementation adds support for storing
	* 	the raw qualified name in addition to it's
	* 	component parts.
	*/
	public class XNIQName extends QualifiedName
	{
		private var _rawname:String;
		
		/**
		*	Creates an <code>XNIQName</code> instance.
		* 
		* 	@param prefix The qualified name prefix.
		* 	@param localpart The local part of the qualified
		* 	name.
		* 	@param rawname The fully qualified name.
		* 	@param uri The namespace uri.
		*/
		public function XNIQName(
			prefix:String,
			localpart:String,
			rawname:String,
			uri:String )
		{
			super( uri, localpart, prefix );
			_rawname = rawname;
		}
		
		/**
		* 	The prefix for the qualified name.
		*/
		public function get prefix():String
		{
			return getPrefix();
		}
		
		public function set prefix( value:String ):void
		{
			setPrefix( value );
		}
		
		/**
		* 	The local part of the qualified name.
		*/
		public function get localpart():String
		{
			return getLocalPart();
		}
		
		public function set localpart( value:String ):void
		{
			setLocalPart( value );
		}		
		
		/**
		* 	The raw qualified name.
		*/
		public function get rawname():String
		{
			return _rawname;
		}
		
		public function set rawname( value:String ):void
		{
			_rawname = value;
		}
		
		/**
		* 	The namespace URI.
		*/
		public function get uri():String
		{
			return getNamespaceURI();
		}
		
		public function set uri( value:String ):void
		{
			setNamespaceURI( value );
		}
	}
}