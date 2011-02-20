package java.nio
{
	import flash.utils.ByteArray;
	
	/**
	* 	A container for data of a specific primitive type.
	* 
	* 	<p>A buffer is a linear, finite sequence of elements of
	* 	a specific primitive type. Aside from its content, the
	* 	essential properties of a buffer are its capacity, limit,
	* 	and position:</p>
	*
	*	<p>A buffer's capacity is the number of elements it contains.
	* 	The capacity of a buffer is never negative and never changes.</p>
	*
	*	<p>A buffer's limit is the index of the first element that should
	* 	not be read or written. A buffer's limit is never negative and
	* 	is never greater than its capacity.</p>
	*
	*	<p>A buffer's position is the index of the next element to be
	* 	read or written. A buffer's position is never negative and is
	* 	never greater than its limit.</p>
	*
	*	<p>There is one subclass of this class for each non-boolean
	* 	primitive type.</p>
	* 
	* 	<p><strong>Transferring data</strong></p>
	* 
	* 	<p>Each subclass of this class defines two categories of get
	* 	and put operations:</p>
	* 
	* 	<p>Relative operations read or write one or more elements
	* 	starting at the current position and then increment the
	* 	position by the number of elements transferred. If the requested
	* 	transfer exceeds the limit then a relative get operation throws
	* 	a BufferUnderflowException and a relative put operation throws
	* 	a BufferOverflowException; in either case, no data is transferred.</p>
	* 
	* 	<p>Absolute operations take an explicit element index and do
	* 	not affect the position. Absolute get and put operations throw
	* 	an IndexOutOfBoundsException if the index argument exceeds the limit.</p>
	* 
	* 	<p>Data may also, of course, be transferred in to or out of a buffer
	* 	by the I/O operations of an appropriate channel, which are always
	* 	relative to the current position.</p>
	* 
	* 	<p><strong>Marking and resetting</strong></p>	
	* 
	* 	<p>A buffer's mark is the index to which its position will
	* 	be reset when the reset method is invoked. The mark is not always
	* 	defined, but when it is defined it is never negative and is never
	* 	greater than the position. If the mark is defined then it is
	* 	discarded when the position or the limit is adjusted to a value
	* 	smaller than the mark. If the mark is not defined then invoking
	* 	the reset method causes an InvalidMarkException to be thrown.</p>
	* 
	* 	<p><strong>Invariants</strong></p>
	* 
	* 	<p>The following invariant holds for the mark, position, limit,
	* 	and capacity values:</p>
	* 
	* 	<pre>0 &lt;= mark &lt;= position &lt;= limit &lt;= capacity</pre>
	* 
	* 	<p>A newly-created buffer always has a position of zero and a mark
	* 	that is undefined. The initial limit may be zero, or it may be some
	* 	other value that depends upon the type of the buffer and the manner
	* 	in which it is constructed. The initial content of a buffer is, in
	* 	general, undefined.</p>
	* 
	* 	<p><strong>Clearing, flipping, and rewinding</strong></p>
	* 
	* 	<p>In addition to methods for accessing the position, limit, and
	* 	capacity values and for marking and resetting, this class also
	* 	defines the following operations upon buffers:</p>
	* 
	* 	<ul>
	* 		<li>clear() makes a buffer ready for a new sequence of channel-read
	* 		or relative put operations: It sets the limit to the capacity
	* 		and the position to zero.</li>
	* 		<li>flip() makes a buffer ready for a new sequence of channel-write
	* 		or relative get operations: It sets the limit to the current position
	* 		and then sets the position to zero.</li>
	* 		<li>rewind() makes a buffer ready for re-reading the data that it
	* 		already contains: It leaves the limit unchanged and sets the
	* 		position to zero.</li>
	* 	</ul>
	* 
	* 	<p><strong>Read-only buffers</strong></p>
	* 
	* 	<p>Every buffer is readable, but not every buffer is writable.
	* 	The mutation methods of each buffer class are specified as optional
	* 	operations that will throw a ReadOnlyBufferException when invoked
	* 	upon a read-only buffer. A read-only buffer does not allow its content
	* 	to be changed, but its mark, position, and limit values are mutable.
	* 	Whether or not a buffer is read-only may be determined by invoking
	* 	its isReadOnly method.</p>
	*/
	public class Buffer extends Object
	{
		/**
		* 	@private
		*/
		protected var _array:ByteArray;
		
		/**
		* 	@private
		*/
		protected var _isReadOnly:Boolean;
		
		/**
		* 	@private
		*/
		protected var _isDirect:Boolean;

		private var _capacity:uint;
		private var _limit:uint;
		
		/**
		* 	Creates a <code>Buffer</code> instance.
		* 
		* 	@param capacity The capacity of the buffer.
		*/
		public function Buffer( capacity:uint )
		{
			super();
			_capacity = capacity;
			_array = new ByteArray();
		}
		
		/**
		* 	Returns the byte array that backs this buffer 
		* 	(optional operation).
		* 
		* 	Modifications to this buffer's content will cause
		* 	the returned array's content to be modified, and
		* 	vice versa.
		* 
		* 	Invoke the hasArray method before invoking this method
		* 	in order to ensure that this buffer has an accessible
		* 	backing array.
		* 
		* 	@return The array that backs this buffer.
		*/
		public function array():ByteArray
		{
			return _array;
		}
		
		/**
		* 	@private
		*/
		internal function setArray( array:ByteArray ):void
		{
			_array = array;
		}
		
		/**
		* 	Returns the offset within this buffer's backing array
		* 	of the first element of the buffer (optional operation).
		* 
		* 	If this buffer is backed by an array then buffer position
		* 	p corresponds to array index p + arrayOffset().
		*/
		public function arrayOffset():uint
		{
			return _array.position;
		}
		
		/**
		* 	Relative bulk get method.
		* 
		* 	This method transfers bytes from this buffer into the
		* 	given destination array. If there are fewer bytes remaining
		* 	in the buffer than are required to satisfy the request,
		* 	that is, if length > remaining(), then no bytes are
		* 	transferred and a BufferUnderflowException is thrown.
		* 
		* 	Otherwise, this method copies length bytes from this buffer
		* 	into the given array, starting at the current position of
		* 	this buffer and at the given offset in the array. The
		* 	position of this buffer is then incremented by length.
		* 
		* 	In other words, an invocation of this method of the form
		* 	<code>src.get(dst, off, len)</code> has exactly the same
		* 	effect as the loop:
		* 
		* 	<pre>for (int i = off; i &lt; off + len; i++)
		* 	{
		*	  dst[i] = src.getBytes();
		* 	}</pre>
		*/
		
		/*
		public function getBytes(
			dst:ByteArray, offset:uint = 0, length:uint = 0 ):ByteBuffer
		{
			//TODO
			return this;
		}
		*/
		
		/**
		* 	
		*/
		public function hasArray():Boolean
		{
			return _array != null;
		}
		
		/**
		* 	Returns this buffer's capacity.
		* 
		* 	@return The capacity of this buffer.
		*/
		public function capacity():uint
		{
			/*
			if( hasArray() && array().length > _capacity )
			{
				return array().length;
			}
			*/
			return _capacity;
		}
		
		/**
		* 	Sets and retrieves this buffer's position.
		* 
		* 	If the mark is defined and larger than
		* 	the new position then it is discarded.
		* 
		* 	@param value The new position value; must be
		* 	non-negative and no larger than the current limit.
		*/
		public function position( value:int = -1 ):uint
		{
			if( hasArray() && value >= 0 )
			{
				_array.position = value;
			}
			return _array.position;
		}
		
		public function get limit():uint
		{
			return _limit;
		}
		
		public function set limit( value:uint ):void
		{
			_limit = value;
		}
		
		/**
		* 	Sets this buffer's mark at its position.
		* 
		* 	@return This buffer.
		*/
		public function mark():Buffer
		{
			//TODO
			return this;
		}
		
		/**
		* 	Resets this buffer's position to the
		* 	previously-marked position.
		* 
		* 	Invoking this method neither changes nor
		* 	discards the mark's value.
		* 
		* 	@throws InvalidMarkException If the mark has not been set.
		* 
		* 	@return This buffer.
		*/
		public function reset():Buffer
		{
			//TODO
			return this;
		}
		
		/**
		* 	Clears this buffer.
		* 
		* 	The position is set to zero, the
		* 	limit is set to the capacity, and the mark is discarded.
		* 
		*	Invoke this method before using a sequence of channel-read or put
		* 	operations to fill this buffer. For example:
		* 
		* 	<pre>buf.clear();  // Prepare buffer for reading
	 	*	in.read(buf);      // Read data</pre>
	 	* 
	 	* 	This method does not actually erase the data in the buffer,
	 	* 	but it is named as if it did because it will most often be
	 	* 	used in situations in which that might as well be the case.
		* 
		* 	@return This buffer.
		*/
		public function clear():Buffer
		{
			//TODO
			return this;
		}
		
		/**
		* 	Flips this buffer.
		* 
		* 	The limit is set to the current position
		* 	and then the position is set to zero. If the mark is
		* 	defined then it is discarded.
		* 
		* 	After a sequence of channel-read or put operations, invoke this
		* 	method to prepare for a sequence of channel-write or relative get
		* 	operations. For example:
		* 
		* 	<pre>buf.put(magic);    // Prepend header
		*	in.read(buf);      // Read data into rest of buffer
		*	buf.flip();        // Flip buffer
		*	out.write(buf);    // Write header + data to channe</pre>
		* 
		* 	This method is often used in conjunction with the compact method
		* 	when transferring data from one place to another.
		* 
		* 	@return This buffer.
		*/
		public function flip():Buffer
		{
			//TODO
			return this;
		}
		
		/**
		* 	Rewinds this buffer.
		* 
		* 	The position is set to zero and the mark is discarded.
		* 
		* 	Invoke this method before a sequence of channel-write or
		* 	get operations, assuming that the limit has already been
		* 	set appropriately. For example:
		* 
		* 	<pre>out.write(buf);    // Write remaining data
		*	buf.rewind();      // Rewind buffer
		*	buf.get(array);    // Copy data into array</pre>
		* 
		* 	@return This buffer.
		*/
		public function rewind():Buffer
		{
			//TODO
			return this;
		}
		
		/**
		*	Returns the number of elements between the current
		* 	position and the limit.
		* 	
		* 	@return The number of elements remaining in this buffer.
		*/
		public function remaining():uint
		{
			//TODO			
			return capacity() - position();
		}
		
		/**
		* 	Tells whether there are any elements between the
		* 	current position and the limit.
		* 
		* 	@return true if, and only if, there is at least one
		* 	element remaining in this buffer.
		*/
		public function hasRemaining():Boolean
		{
			//TODO
			return remaining() > 0;
		}
		
		/**
		* 	Tells whether or not this buffer is read-only.
		* 
		* 	@return true if, and only if, this buffer is read-only.
		*/
		public function get isReadOnly():Boolean
		{
			return _isReadOnly;
		}
		
		/**
		* 	@private
		*/
		internal function setReadOnly( value:Boolean ):void
		{
			_isReadOnly = value;
		}
		
		/**
		* 	Tells whether or not this buffer is direct.
		* 
		* 	@return true if, and only if, this buffer is direct.
		*/
		public function get isDirect():Boolean
		{
			return _isDirect;
		}
	}
}