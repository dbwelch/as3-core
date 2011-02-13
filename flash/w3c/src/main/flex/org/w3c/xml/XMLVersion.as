package org.w3c.xml
{
	/**
	* 	Represents an XML (Extensible Markup Language) version.
	*/
	public class XMLVersion extends Object
	{
		/**
		* 	Represents the "1.0" XML version.
		*/
		public static const XML_1_0_VERSION:String = "1.0";
		
		/**
		* 	Represents the "1.1" XML version.
		*/
		public static const XML_1_1_VERSION:String = "1.1";
		
		/**
		* 	A version constant representing the "1.0" version.
		*/
		public static const XML_1_0:XMLVersion =
			new XMLVersion( XML_1_0_VERSION );
			
		/**
		* 	A version constant representing the "1.1" version.
		*/
		public static const XML_1_1:XMLVersion =
			new XMLVersion( XML_1_1_VERSION );
		
		private var _version:String;
	
		public function XMLVersion( version:String = null )
		{
			super();
			this.version = version;
		}
		
		/**
		* 	The version as a string.
		*/
		public function get version():String
		{
			if( _version == null )
			{
				_version = XML_1_0_VERSION;
			}
			return _version;
		}
		
		public function set version( value:String ):void
		{
			_version = value;
		}
		
		public function toString():String
		{
			return "[object XMLVersion][" + this.version + "]";
		}
	}
}