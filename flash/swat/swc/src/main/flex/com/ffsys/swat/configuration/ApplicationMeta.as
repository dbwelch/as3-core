package com.ffsys.swat.configuration {
	
	/**
	*	Encapsulates meta information about the application.
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  19.10.2010
	*/
	public class ApplicationMeta extends Object {
		
		/**
		*	The default <code>name</code> used if none
		*	is specified.
		*/
		static public const DEFAULT_APPLICATION_NAME:String =
			"application";
		
		/**
		*	A delimiter to use when retrieving the version
		* 	when no specific version has been specified.
		*/
		static public const VERSION_DELIMITER:String = ".";
		
		private var _name:String = DEFAULT_APPLICATION_NAME;
		private var _version:String;
		private var _majorVersion:int = 0;
		private var _minorVersion:int = 0;
		private var _revision:int = 1;
		
		/**
		*	Creates an <code>ApplicationMeta</code> instance.
		*/
		public function ApplicationMeta()
		{
			super();
		}
		
		/**
		*	The <code>name</code> of this application.	
		*/
		public function set name( val:String ):void
		{
			_name = val;
		}
		
		public function get name():String
		{
			return _name;
		}
		
		/**
		*	The full <code>version</code> of this application.
		*/
		public function set version( val:String ):void
		{
			_version = val;
		}
		
		public function get version():String
		{
			if( _version == null )
			{
				var parts:Array = [ majorVersion, minorVersion, revision ];
				_version =  parts.join( VERSION_DELIMITER );
			}
			
			return _version;
		}
		
		/**
		*	The major version for this application.
		*/
		public function set majorVersion( val:int ):void
		{
			_majorVersion = val;
		}
		
		public function get majorVersion():int
		{
			return _majorVersion;
		}
		
		/**
		*	The minor version for this application.	
		*/
		public function set minorVersion( val:int ):void
		{
			_minorVersion = val;
		}
		
		public function get minorVersion():int
		{
			return _minorVersion;
		}
		
		/**
		*	The revision for this application.	
		*/
		public function set revision( val:int ):void
		{
			_revision = val;
		}
		
		public function get revision():int
		{
			return _revision;
		}
	}
}