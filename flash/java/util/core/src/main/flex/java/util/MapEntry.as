package java.util
{
	import java.lang.JavaObject;
	
	/**
	*	Represents an entry in a Map.
	*/
	public class MapEntry extends JavaObject {
		
		/**
		* 	The key for the map entry.
		*/
		public var key:Object;

		/**
		* 	The value for the map entry.
		*/
		public var value:Object;

		/**
		* 	The index of the entry.
		*/
		public var index:uint;

		/**
		* 	Creates a <code>MapEntry</code> instance.
		* 
		* 	@param key The key for the map entry.
		* 	@param value The value for the map entry.
		* 	@param index The index of the entry.
		*/
		public function MapEntry( key:Object, value:Object, index:uint )
		{
			this.key = key;
			this.value = value;		
			this.index = index;
		}
	}
}