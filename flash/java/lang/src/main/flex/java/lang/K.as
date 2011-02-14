package java.lang
{
	/**
	* 	Represents the <em>type of a key</em>.
	* 
	* 	This is used by the collections implementation
	* 	to restrict the <em>key</em> a collection may store <em>to
	* 	a particular type</em>.
	*/
	public class K extends Object
	{
		private var _type:Class;
		
		/**
		* 	Creates a <code>K</code> instance.
		* 
		* 	@param type The type that this key represents.
		* 
		* 	@throws ArgumentError If type is null.
		*/
		public function K( type:Class )
		{
			super();
			if( type == null )
			{
				throw new ArgumentError( "A key type <K> cannot be null." );
			}
			_type = type;
		}
		
		/**
		* 	The type that a key can be.
		*/
		public function get type():Class
		{
			return _type;
		}

		/**
		* 	A string representation of this key.
		* 
		* 	@return A string representation of this key.
		*/
		public function toString():String
		{
			var t:T = T.getInstance( _type );
			return "<K><" + t.name + ">";
		}
	}
}