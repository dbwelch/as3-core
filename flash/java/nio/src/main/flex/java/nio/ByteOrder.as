package java.nio
{
	import flash.utils.Endian;
	
	/**
	* 	A typesafe enumeration for byte orders.
	*/
	public class ByteOrder extends Object
	{
		/**
		* 	Constant denoting big-endian byte order.
		* 
		* 	In this order, the bytes of a multibyte value
		* 	are ordered from most significant to least significant.
		*/
		public static const BIG_ENDIAN:ByteOrder =
			new ByteOrder( Endian.BIG_ENDIAN );
		
		/**
		* 	Constant denoting little-endian byte order.
		* 
		* 	In this order, the bytes of a multibyte value
		* 	are ordered from least significant to most significant.
		*/
		public static const LITTLE_ENDIAN:ByteOrder =
			new ByteOrder( Endian.LITTLE_ENDIAN );
		
		private var _value:String;
		
		/**
		* 	@private
		* 
		* 	Creates a <code>ByteOrder</code> instance.
		* 
		* 	@param value The byte order value.
		*/
		public function ByteOrder( value:String )
		{
			super();
			_value = value;
		}		
		
		/**
		* 	Constructs a string describing this object.
		* 
		* 	This method returns the string "BIG_ENDIAN"
		* 	for BIG_ENDIAN and "LITTLE_ENDIAN" for
		* 	LITTLE_ENDIAN.
		* 
		* 	@return A descriptive string.
		*/
		public function toString():String
		{
			return _value;
		}
	}
}