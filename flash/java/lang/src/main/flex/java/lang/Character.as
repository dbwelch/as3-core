package java.lang
{
	/**
	* 	
	*/
	public class Character extends Object
	{
		private var _char:String;
		
		/**
		* 	Creates a <code>Character</code> instance.
		* 
		* 	@param char A string with a length of one.
		*/
		public function Character( char:String )
		{
			super();
			//TODO: throw error if char.length  != 1
			_char = char;
		}
		
		/**
		* 	Returns the value of this Character object.
		* 
		* 	@return The primitive String value represented by this object.
		*/
		public function charValue():String
		{
			return _char;
		}
		
		/**
		* 	Returns a Character instance representing the specified char value.
		* 
		* 	If a new Character instance is not required, this method should
		* 	generally be used in preference to the constructor Character(char),
		* 	as this method is likely to yield significantly better space and
		* 	time performance by caching frequently requested values.
		*/
		public static function valueOf( c:String ):Character
		{
			//TODO: character caching in the Character class
			return new Character( c );
		}
	}
}