package java.lang
{
	/**
	* 	Represents the <em>type of a value</em>.
	* 
	* 	This is used by the collections implementation
	* 	to restrict the <em>value</em> a collection may store <em>to
	* 	a particular type</em>.
	*/
	public class V extends Object
	{
		private var _type:Class;
		
		/**
		* 	Represents the <code>Object</code> value type.
		*/
		public static const OBJECT:V = new V( Object );
		
		/**
		* 	Creates a <code>V</code> instance.
		* 
		* 	@param type The type that this value represents.
		* 
		* 	@throws ArgumentError If type is null.
		*/
		public function V( type:Class )
		{
			super();
			if( type == null )
			{
				throw new ArgumentError( "A value type <V> cannot be null." );
			}
			_type = type;
		}
		
		/**
		* 	The type that a value can be.
		*/
		public function get type():Class
		{
			return _type;
		}
		
		/**
		* 	A list of all types supported by this value.
		*/
		public function get types():Vector.<Class>
		{
			var v:Vector.<Class> = new Vector.<Class>();
			v.push( type );
			return v;
		}

		/**
		* 	A string representation of this key.
		* 
		* 	@return A string representation of this key.
		*/
		public function toString():String
		{
			var t:T = T.getInstance( _type );
			return "<V><" + t.name + ">";
		}
	}
}