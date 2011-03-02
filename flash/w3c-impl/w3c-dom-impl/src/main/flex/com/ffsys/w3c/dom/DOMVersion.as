package com.ffsys.w3c.dom
{
	
	/**
	* 	Encapsulates the availabe DOM levels as constants
	* 	and provides a mechanism for validating and comparing
	* 	version numbers.
	*/
	public class DOMVersion extends Object
	{
		/**
		* 	Represents the DOM level 1 version number.
		*/
		public static const LEVEL_1:String = "1.0";
		
		/**
		* 	Represents the DOM level 2 version number.
		*/
		public static const LEVEL_2:String = "2.0";
		
		/**
		* 	Represents the DOM level 3 version number.
		*/
		public static const LEVEL_3:String = "3.0";
		
		/**
		* 	Represents the DOM version <code>1.0</code>.
		*/
		public static const VERSION_1:DOMVersion = new DOMVersion( LEVEL_1 );
		
		/**
		* 	Represents the DOM version <code>2.0</code>.
		*/
		public static const VERSION_2:DOMVersion = new DOMVersion( LEVEL_2 );
		
		/**
		* 	Represents the DOM version <code>3.0</code>.
		*/
		public static const VERSION_3:DOMVersion = new DOMVersion( LEVEL_3 );
		
		private var _primary:String;
		private var _compatibilties:Vector.<DOMVersion>;

		/**
		* 	Creates a <code>DOMVersion</code> instance.
		* 
		* 	@param primary A primary version number.
		* 	@param compatibilties Alternative <code>valid</code>
		* 	version number string values.
		*/
		public function DOMVersion(
			primary:String = null,
			compatibilties:Array = null )
		{
			super();
			_primary = primary;
			
			if( compatibilties != null
				&& compatibilties.length > 0 )
			{
				_compatibilties = new Vector.<DOMVersion>();
				var o:Object = null;
				for( var i:int = 0;i < compatibilties.length;i++ )
				{
					o = compatibilties[ i ];
					if( o !== primary && ( o === LEVEL_1 || o === LEVEL_2 || o === LEVEL_3 ) )
					{
						_compatibilties.push( new DOMVersion( "" + o ) );
					}
				}
			}
		}
		
		/**
		* 	The primary version number.
		*/
		public function get primary():String
		{
			return _primary;
		}
		
		/**
		* 	Determines whether this version is a valid
		* 	DOM version.
		*/
		public function isValid():Boolean
		{
			return VERSION_1.equals( this )
				|| VERSION_2.equals( this )
				|| VERSION_3.equals( this );
		}
		
		/**
		* 	Tests a candidate string against this version.
		* 
		* 	@param candidate The candidate.
		* 
		* 	@return Whether this version is considered to be
		* 	equal to the candidate.
		*/
		public function test( candidate:String ):Boolean
		{
			return equals( new DOMVersion( candidate ) );
		}
		
		/**
		* 	Determines whether the versions are equals.
		*/
		public function equals( candidate:DOMVersion ):Boolean
		{
			var valid:Boolean = candidate != null
				&& candidate.primary === this.primary;
				
			//trace("[EQUALS] DOMVersion::equals()", candidate, valid );
				
			if( !valid
				&& _compatibilties != null && _compatibilties.length > 0 )
			{
				for( var i:int = 0;i < _compatibilties.length;i++ )
				{
					if( _compatibilties[ i ].equals( candidate ) )
					{
						valid = true;
						break;
					}
				}
			}
			
			return valid;
		}
		
		/**
		* 	Creates a lone of this version.
		* 
		* 	The cloned version has the same primary version
		* 	number and will also support any version numbers
		* 	specified in the compatibilties array.
		* 
		* 	@param compatibilties A list of string version numbers
		* 	that this version is also compatible with.
		* 
		* 	@return The cloned version.
		*/
		public function clone( compatibilties:Array = null ):DOMVersion
		{
			return new DOMVersion( this.primary, compatibilties );
		}
		
		/**
		* 	A string representation of this version.
		* 
		* 	@return A version string.
		*/
		public function toString():String
		{
			return this.primary != null ? this.primary : "";
		}
	}
}