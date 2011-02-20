package java.nio
{
	
	/**
	* 	A byte buffer.
	* 
	* 	<p>This class defines six categories of operations upon byte buffers:</p>
	* 
	* 	<ul>
	* 		<li>Absolute and relative get and put methods that read
	* 		and write single bytes;</li>
	* 		<li>Relative bulk get methods that transfer contiguous
	* 		sequences of bytes from this buffer into an array;</li>
	* 		<li>Relative bulk put methods that transfer contiguous
	* 		sequences of bytes from a byte array or some other byte
	* 		buffer into this buffer;</li>
	* 		<li>Absolute and relative get and put methods that read
	* 		and write values of other primitive types, translating
	* 		them to and from sequences of bytes in a particular byte order;</li>
	* 		<li>Methods for creating view buffers, which allow a byte
	* 		buffer to be viewed as a buffer containing values of some
	* 		other primitive type; and</li>
	* 		<li>Methods for compacting, duplicating, and slicing a byte buffer.</li>
	* 	</ul>
	* 
	* 	<p>Byte buffers can be created either by allocation, which
	* 	allocates space for the buffer's content, or by wrapping
	* 	an existing byte array into a buffer.</p>
	*/
	public class ByteBuffer extends Buffer
	{
		/**
		* 	@private
		* 
		* 	Creates a <code>ByteBuffer</code> instance.
		* 
		* 	@param capacity The capacity of the buffer.
		*/
		public function ByteBuffer( capacity:uint )
		{
			super( capacity );
		}
		
		/**
		* 	Allocates a new byte buffer.
		* 
		* 	The new buffer's position will be zero,
		* 	its limit will be its capacity, and its mark
		* 	will be undefined. It will have a backing array,
		* 	and its array offset will be zero.
		* 
		* 	@param capacity The new buffer's capacity, in bytes.
		* 
		* 	@throws IllegalArgumentException If the capacity is a negative integer.
		* 
		* 	@return The new byte buffer.
		*/
		public static function allocate( capacity:uint ):ByteBuffer
		{
			return new ByteBuffer( capacity );
		}
	}
}