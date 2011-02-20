package java.nio.charset
{
	import flash.utils.ByteArray;
	
	import java.nio.ByteOrder;
	
	/**
	* 	Type safe enumeration of byte sequences that determine
	* 	known byte order marks.
	*/
	public class ByteOrderMark extends Object
	{
		/*
		00 00 FE FF	UCS-4, big-endian machine (1234 order)
		FF FE 00 00	UCS-4, little-endian machine (4321 order)
		00 00 FF FE	UCS-4, unusual octet order (2143)
		FE FF 00 00	UCS-4, unusual octet order (3412)
		FE FF ## ##	UTF-16, big-endian
		FF FE ## ##	UTF-16, little-endian
		EF BB BF	UTF-8
		*/		
		
		/**
		* 	UCS-4, big-endian machine (1234 order).
		* 
		* 	<pre>0x00 0x00 0xFE 0xFF</pre>
		* 
		* 	The character set that this BOM declares is not supported
		* 	by the virtual machine but is declared if this BOM requires
		* 	detection as unsupported.
		*/
		public static const UCS_4_BIG_ENDIAN:ByteOrderMark = new ByteOrderMark(
			"UCS-4-BE",
			ByteOrder.BIG_ENDIAN, 
			0x00, 0x00, 0xFE, 0xFF );
			
		/**
		* 	UCS-4, little-endian machine (4321 order).
		* 
		* 	<pre>0xFF 0xFE 0x00 0x00</pre>
		* 
		* 	The character set that this BOM declares is not supported
		* 	by the virtual machine but is declared if this BOM requires
		* 	detection as unsupported.
		*/
		public static const UCS_4_LITTLE_ENDIAN:ByteOrderMark = new ByteOrderMark(
			"UCS-4-LE",
			ByteOrder.LITTLE_ENDIAN, 
			0xFF, 0xFE, 0x00, 0x00 );

		/**
		* 	UTF-16, big-endian.
		* 
		* 	The notation ## is used to denote any byte value
		* 	except that two consecutive ##s cannot be both 00.
		* 
		* 	<pre>0xFE 0xFF 0x## 0x##</pre>
		*/
		public static const UTF_16_BIG_ENDIAN:ByteOrderMark = new ByteOrderMark(
			"UTF-16-BE",
			ByteOrder.BIG_ENDIAN, 
			0xFE, 0xFF );
			
		/**
		* 	UTF-16, little-endian.
		* 
		* 	The notation ## is used to denote any byte value
		* 	except that two consecutive ##s cannot be both 00.
		* 
		* 	<pre>0xFF 0xFE 0x## 0x##</pre>
		*/
		public static const UTF_16_LITTLE_ENDIAN:ByteOrderMark = new ByteOrderMark(
			"UTF-16-LE",
			ByteOrder.LITTLE_ENDIAN, 
			0xFF, 0xFE );
			
		/**
		* 	UTF-8.
		* 
		* 	<pre>0xEF 0xBB 0xBF</pre>
		*/
		public static const UTF_8:ByteOrderMark = new ByteOrderMark(
			"UTF-8",
			null,
			0xEF, 0xBB, 0xBF );
		
		private var _name:String;
		private var _endian:ByteOrder;
		private var _bytes:ByteArray;
	
		/**
		* 	@private
		* 
		* 	Creates a <code>ByteOrderMark</code> instance.
		* 
		* 	@param name A descriptive name.
		* 	@param endian The endian of this byte order mark.
		*	@param bytes The bytes as a sequence of integers.
		*/
		public function ByteOrderMark(
			name:String,
			endian:ByteOrder,
			... bytes )
		{
			super();
			_name = name;
			_endian = endian;
			_bytes = new ByteArray();
			if( endian != null )
			{
				_bytes.endian = endian.toString();
			}
			for( var i:int = 0;i < bytes.length;i++ )
			{
				if( bytes[ i ] is int )
				{
					_bytes.writeByte( bytes[ i ] as int );
				}
			}
			_bytes.position = 0;
		}
		
		/**
		* 	A descriptive name for this byte order mark.
		*/
		public function get name():String
		{
			return _name;
		}
		
		/**
		* 	The byte endian for this byte order
		* 	mark.
		* 
		* 	If this is null it indicates that this
		* 	byte order does not represents a single byte
		* 	character set, such as, UTF-8.
		*/
		public function get endian():ByteOrder
		{
			return _endian;
		}
		
		/**
		* 	The sequence of bytes for this byte order mark.
		*/
		public function get bytes():ByteArray
		{
			return _bytes;
		}
		
		/**
		* 	Tests whether a candidate byte array
		* 	matches this byte order mark.
		* 
		* 	The position of the candidate byte
		* 	array is always restored before this
		* 	method returns.
		* 
		* 	@param candidate The candidate array.
		* 
		* 	@throws ArgumentError If candidate is null
		* 	or less than 4 bytes in length.
		* 
		* 	@return Whether the candidate array byte
		* 	array <em>starts with</em> this byte order mark.
		*/
		public function test( candidate:ByteArray ):Boolean
		{
			if( candidate == null || candidate.length < 4 )
			{
				throw new ArgumentError( "Cannot test a BOM against an invalid byte array." );
			}
			
			var pos:uint = candidate.position;
			candidate.position = 0;
			bytes.position = 0;
			for( var i:int = 0;i < bytes.length;i++ )
			{
				if( bytes.readByte() != candidate.readByte() )
				{
					candidate.position = pos;
					return false;
				}
			}
			candidate.position = pos;
			return true;
		}
		
		/**
		* 	Concatenates the byte sequence of this byte order mark
		* 	with the target array of bytes into a new byte array.
		* 
		* 	@param target The target byte array to concatenate
		* 	with this byte order mark.
		* 
		* 	@return The new concatenated byte array.
		*/
		public function concat( target:ByteArray ):ByteArray
		{
			var output:ByteArray = target;
			if( target != null )
			{
				output = new ByteArray();
				output.writeBytes( bytes, 0, bytes.length );
				output.writeBytes( target, 0, target.length );
			}
			output.position = 0;
			return output;
		}
		
		/**
		* 	A descriptive representation of this
		* 	byte order mark.
		* 	
		* 	@return A descriptive string of this
		* 	byte order mark.
		*/
		public function toString():String
		{
			return _name;
		}
	}
}