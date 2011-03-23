package java.util
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
		
	/**
	*	This class implements a vector of bits that grows as needed.
	* 
	* 	Each component of the bit set has a boolean value. The bits of
	* 	a BitSet are indexed by nonnegative integers. Individual indexed bits
	* 	can be examined, set, or cleared. One BitSet may be used to modify
	* 	the contents of another BitSet through logical AND, logical inclusive OR,
	* 	and logical exclusive OR operations.
	* 
	* 	By default, all bits in the set initially have the value false.
	* 
	* 	Every bit set has a current size, which is the number of bits of
	* 	space currently in use by the bit set. Note that the size is related
	* 	to the implementation of a bit set, so it may change with implementation.
	* 
	* 	The length of a bit set relates to logical length of a bit set and is
	* 	defined independently of implementation.
	*/
	public class BitSet extends Object
	{
		/**
		* 	@private
		*/
		internal var _bytes:ByteArray;
		
		/**
		* 	Creates a <code>BitSet</code> instance.
		* 
		* 	Creates a bit set whose initial size is
		* 	large enough to explicitly represent bits
		* 	with indices in the range 0 through nbits-1.
		* 
		* 	All bits are initially false.
		* 
		* 	@param nbits The initial size of the bit set.
		*/
		public function BitSet( nbits:uint = 0 )
		{
			super();
			//TODO: throw NegativeArraySizeException
			allocate( nbits );
		}
		
		/*
		* 	The bits for this bit set represented
		* 	as a list of unsigned integers.
		* 
		* 	The bits in this BitSet. The ith bit is
		* 	stored in bits[i/64] at bit position i % 64
		* 	(where bit position 0 refers to the least
		* 	significant bit and 63 refers to the most
		* 	significant bit).
		*/
		
		/*
		public function bits():Vector.<Number>
		{
			//TODO
			return null;
		}
		*/
		
		/**
		* 	@private
		*/
		protected function get bytes():ByteArray
		{
			if( _bytes == null )
			{
				_bytes = new ByteArray();
			}
			return _bytes;
		}
		
		/**
		* 	Retreives a copy of the bytes represented
		* 	by this bit set as a new byte array.
		* 
		* 	@return A new byte array with a copy of the
		* 	current state of this bit set and it's position
		* 	reset to zero ready to read.
		*/
		public function toByteArray():ByteArray
		{
			//store current position
			var c:uint = bytes.position;
			bytes.position = 0;
			var copy:ByteArray = new ByteArray();
			copy.writeBytes( bytes, 0, bytes.length );
			bytes.position = c;
			return copy;
		}
		
		/**
		* 	@private
		* 
		* 	Allocates the bytes necessary to represent
		* 	the number of requested bits.
		* 
		* 	@param nbits The number of bits to allocate.
		*/
		protected function allocate( nbits:uint = 0 ):void
		{
			_bytes = new ByteArray();
			//_bytes.endian = Endian.BIG_ENDIAN;
			var n:uint = Math.ceil( nbits / 8 );
			while( n > 0 )
			{
				//write the initial null (zero) bytes
				_bytes.writeByte( 0 );
				n--;
			}
		}
		
		/**
		* 	Returns the number of bits of space actually in
		* 	use by this BitSet to represent bit values. The maximum
		* 	element in the set is the size - 1st element.
		* 
		* 	@return The number of bits currently in this bit set.
		*/
		public function size():int
		{
			//bytes to bit length
			return bytes.length * 8;
		}
		
		/*
		
	 void	and(BitSet set) 
	          Performs a logical AND of this target bit set with the argument bit set.
	 void	andNot(BitSet set) 
	          Clears all of the bits in this BitSet whose corresponding bit is set in the specified BitSet.
	 int	cardinality() 
	          Returns the number of bits set to true in this BitSet.
	 void	clear() 
	          Sets all of the bits in this BitSet to false.
	 void	clear(int bitIndex) 
	          Sets the bit specified by the index to false.
	 void	clear(int fromIndex, int toIndex) 
	          Sets the bits from the specified fromIndex (inclusive) to the specified toIndex (exclusive) to false.
	 Object	clone() 
	          Cloning this BitSet produces a new BitSet that is equal to it.
	 boolean	equals(Object obj) 
	          Compares this object against the specified object.
	 void	flip(int bitIndex) 
	          Sets the bit at the specified index to the complement of its current value.
	 void	flip(int fromIndex, int toIndex) 
	          Sets each bit from the specified fromIndex (inclusive) to the specified toIndex (exclusive) to the complement of its current value.
	 boolean	get(int bitIndex) 
	          Returns the value of the bit with the specified index.
	 BitSet	get(int fromIndex, int toIndex) 
	          Returns a new BitSet composed of bits from this BitSet from fromIndex (inclusive) to toIndex (exclusive).
	 int	hashCode() 
	          Returns a hash code value for this bit set.
	 boolean	intersects(BitSet set) 
	          Returns true if the specified BitSet has any bits set to true that are also set to true in this BitSet.
	 boolean	isEmpty() 
	          Returns true if this BitSet contains no bits that are set to true.
	 int	length() 
	          Returns the "logical size" of this BitSet: the index of the highest set bit in the BitSet plus one.
	 int	nextClearBit(int fromIndex) 
	          Returns the index of the first bit that is set to false that occurs on or after the specified starting index.
	 int	nextSetBit(int fromIndex) 
	          Returns the index of the first bit that is set to true that occurs on or after the specified starting index.
	 void	or(BitSet set) 
	          Performs a logical OR of this bit set with the bit set argument.
	 void	set(int bitIndex) 
	          Sets the bit at the specified index to true.
	 void	set(int bitIndex, boolean value) 
	          Sets the bit at the specified index to the specified value.
	 void	set(int fromIndex, int toIndex) 
	          Sets the bits from the specified fromIndex (inclusive) to the specified toIndex (exclusive) to true.
	 void	set(int fromIndex, int toIndex, boolean value) 
	          Sets the bits from the specified fromIndex (inclusive) to the specified toIndex (exclusive) to the specified value.
	 int	size() 
	          Returns the number of bits of space actually in use by this BitSet to represent bit values.
	 String	toString() 
	          Returns a string representation of this bit set.
	 void	xor(BitSet set) 
	          Performs a logical XOR of this bit set with the bit set argument.		
		
		*/
	}
}