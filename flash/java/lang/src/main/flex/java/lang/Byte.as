package java.lang
{
	import flash.utils.ByteArray;
	
	/**
	* 	The Byte class wraps a value of primitive type
	* 	byte in an object.
	* 
	* 	An object of type Byte contains a single field
	* 	whose type is byte.
	* 
	* 	In addition, this class provides several methods
	* 	for converting a byte to a String and a String
	* 	to a byte, as well as other constants and methods
	* 	useful when dealing with a byte.
	*/
	public class Byte extends Object
	{
		/**
		* 	A constant holding the maximum value a
		* 	byte can have, 27-1.
		*/
		public static const MAX_VALUE:int = 127;
		
		/**
		* 	A constant holding the minimum value a
		* 	byte can have, -27.
		*/
		public static const MIN_VALUE:int = -128;
		
		/**
		* 	The number of bits used to represent a byte
		* 	value in two's complement binary form.
		*/
		public static const SIZE:uint = 8;
		
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
		* 	@private
		* 
		* 	The primitive byte value.
		*/
		protected function get byte():int
		{
			if( _byteArray.length == 0 )
			{
				return 0;
			}
			_byteArray.position = 0;
			return _byteArray.readByte();
		}
		
		/**
		* 	@private
		* 
		* 	The primitive byte value.
		*/
		protected function set byte( value:int ):void
		{
			_byteArray = new ByteArray();
			_byteArray.writeByte( value );
		}
		
		/**
		* 	The primitive byte value.
		* 
		* 	@return The value of this byte as
		* 	as an integer.
		* 	
		*/
		public function valueOf():int
		{
			return this.byte;
		}
		
		/**
		* 	Decodes a String into a Byte.
		* 
		* 	Accepts decimal, hexadecimal, and octal
		* 	numbers given by the following grammar:
		* 
		* 	<pre>DecodableString:
		*	Signopt DecimalNumeral
		*	Signopt 0x HexDigits
		*	Signopt 0X HexDigits
		*	Signopt # HexDigits
		*	Signopt 0 OctalDigits
		*	Sign: -</pre>
		* 
		* 	DecimalNumeral, HexDigits, and OctalDigits are defined
		* 	in §3.10.1 of the Java Language Specification.
		* 		
		*	The sequence of characters following an (optional)
		* 	negative sign and/or radix specifier ("0x", "0X", "#",
		* 	or leading zero) is parsed as by the Byte.parseByte
		* 	method with the indicated radix (10, 16, or 8). This
		* 	sequence of characters must represent a positive value
		* 	or a NumberFormatException will be thrown. The result is
		* 	negated if first character of the specified String is
		* 	the minus sign. No whitespace characters are permitted in the String.
		* 
		* 	@param nm The String to decode.
		* 
		* 	@throws NumberFormatException If the String does not contain a parsable byte.
		* 
		* 	@return A Byte object holding the byte value represented by nm.
		* 
		* 	@todo Implement byte string decoding.
		*/
		public static function decode( nm:String ):Byte
		{
			return null;
		}
	}
}