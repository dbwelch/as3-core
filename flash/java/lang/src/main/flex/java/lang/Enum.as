package java.lang
{
	
	/**
	* 	
	*/
	public class Enum extends Object
	{	
		private var _enums:Vector.<Enum>;
		private var _name:String;
		private var _ordinal:int = -1;
		
		/**
		* 	@private
		* 
		* 	Creates an <code>Enum</code> instance.
		* 
		* 	@param name The name(s) of the enum.
		* 	@param ordinal The ordinal index of the enum
		* 	in the declaration.
		*/
		public function Enum( name:Object = null, ordinal:int = -1 )
		{
			super();
			if( name is Array && ordinal == -1 )
			{
				toEnum( name as Array );
			}else if( name is String && ordinal > -1 )
			{
				_name = name as String;
				_ordinal = ordinal;
			}
		}
		
		/**
		* 
		*/
		public function get name():String
		{
			return _name;
		}
		
		/**
		* 	
		*/
		public function get ordinal():int
		{
			return _ordinal;
		}
		
		/**
		* 	
		*/
		public function toString():String
		{
			return name;
		}
		
		/**
		* 	@private
		*/
		private function toEnum( names:Array ):void
		{
			var t:T = T.getInstance( this );
			_name = t.path;
			_enums = new Vector.<Enum>();
			for( var i:int = 0;i < names.length;i++ )
			{
				_enums.push( new t.definition( "" + names[ i ], i ) );
			}
		}
	}
}