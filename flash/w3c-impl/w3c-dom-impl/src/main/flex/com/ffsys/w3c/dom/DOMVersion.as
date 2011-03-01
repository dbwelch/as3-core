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
		private var _alternatives:Vector.<DOMVersion>;

		/**
		* 	Creates a <code>DOMVersion</code> instance.
		* 
		* 	@param primary A primary version number.
		* 	@param alternatives Alternative <code>valid</code>
		* 	version number string values.
		*/
		public function DOMVersion( primary:String = null, ...alternatives )
		{
			super();
			_primary = primary;
			
			if( alternatives != null
				&& alternatives.length > 0 )
			{
				_alternatives = new Vector.<DOMVersion>();
				var o:Object = null;
				for( var i:int = 0;i < alternatives.length;i++ )
				{
					o = alternatives[ i ];
					if( o !== primary && ( o === LEVEL_1 || o === LEVEL_2 || o === LEVEL_3 ) )
					{
						_alternatives.push( new DOMVersion( "" + o ) );
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
		* 	Determines whether the versions are equals.
		*/
		public function equals( candidate:DOMVersion ):Boolean
		{
			var valid:Boolean = candidate != null
				&& candidate.primary === this.primary;
				
			if( !valid
				&& _alternatives != null && _alternatives.length > 0 )
			{
				for( var i:int = 0;i < _alternatives.length;i++ )
				{
					if( _alternatives[ i ].equals( candidate ) )
					{
						valid = true;
						break;
					}
				}
			}
			
			return valid;
		}
	}
}