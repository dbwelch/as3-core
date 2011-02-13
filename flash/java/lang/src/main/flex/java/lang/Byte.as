package java.lang
{
	import flash.utils.ByteArray;
	
	/**
	* 	
	*/
	public class Byte extends Object
	{
		
		/*
		
		static byte	MAX_VALUE = 127
		          A constant holding the maximum value a byte can have, 27-1.
		static byte	MIN_VALUE = -128
		          A constant holding the minimum value a byte can have, -27.
		static int	SIZE = 8
		          The number of bits used to represent a byte value in two's complement binary form.
		static Class<Byte>	TYPE = int
		          The Class instance representing the primitive type byte.
		
		*/
		
		/*
		
		
		 byte	byteValue() 
		          Returns the value of this Byte as a byte.
		 int	compareTo(Byte anotherByte) 
		          Compares two Byte objects numerically.
		static Byte	decode(String nm) 
		          Decodes a String into a Byte.
		 double	doubleValue() 
		          Returns the value of this Byte as a double.
		 boolean	equals(Object obj) 
		          Compares this object to the specified object.
		 float	floatValue() 
		          Returns the value of this Byte as a float.
		 int	hashCode() 
		          Returns a hash code for this Byte.
		 int	intValue() 
		          Returns the value of this Byte as an int.
		 long	longValue() 
		          Returns the value of this Byte as a long.
		static byte	parseByte(String s) 
		          Parses the string argument as a signed decimal byte.
		static byte	parseByte(String s, int radix) 
		          Parses the string argument as a signed byte in the radix specified by the second argument.
		 short	shortValue() 
		          Returns the value of this Byte as a short.
		 String	toString() 
		          Returns a String object representing this Byte's value.
		static String	toString(byte b) 
		          Returns a new String object representing the specified byte.
		static Byte	valueOf(byte b) 
		          Returns a Byte instance representing the specified byte value.
		static Byte	valueOf(String s) 
		          Returns a Byte object holding the value given by the specified String.
		static Byte	valueOf(String s, int radix) 
		          Returns a Byte object holding the value extracted from the specified String when parsed with the radix given by the second argument.		
		
		
		*/
		
		private var _byteArray:ByteArray = new ByteArray();
		
		/**
		* 	Creates a <code>Byte</code> instance.
		* 
		* 	@param byte An integer in the range -128 to 127.
		*/
		public function Byte( byte:int = 0 )
		{
			super();
			this.byte = byte;
		}
		
		/**
		* 	The primitive byte value.
		*/
		public function get byte():int
		{
			_byteArray.position = 0;
			return _byteArray.readByte();
		}
		
		public function set byte( value:int ):void
		{
			_byteArray = new ByteArray();
			_byteArray.writeByte( value );
		}
		
		/**
		* 	The primitive byte value.
		*/
		public function valueOf():Object
		{
			return byte;
		}
		
		/**
		* 	@todo Implement.
		*/
		public static function decode( nm:String ):Byte
		{
			return null;
		}
	}
}