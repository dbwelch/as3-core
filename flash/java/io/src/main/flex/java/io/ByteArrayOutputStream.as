package java.io
{
	import flash.utils.ByteArray;
	
	/**
	* 	This class implements an output stream
	* 	in which the data is written into a byte array.
	* 
	* 	The buffer automatically grows as data is written
	* 	to it. The data can be retrieved using
	* 	toByteArray() and toString().
	* 
	* 	Closing a ByteArrayOutputStream has no effect.
	* 	The methods in this class can be called after
	* 	the stream has been closed without generating
	* 	an IOException.
	*/
	public class ByteArrayOutputStream extends OutputStream
	{		
		/**
		* 	Creates a <code>ByteArrayOutputStream</code> instance.
		*/
		public function ByteArrayOutputStream()
		{
			super();
			target = new ByteArray();
		}
		
		/**
		* 	Resets the count field of this byte array
		* 	output stream to zero, so that all currently
		* 	accumulated output in the output stream is discarded.
		* 
		* 	The output stream can be used again,
		* 	reusing the already allocated buffer space.
		*/
		public function reset():void
		{
			target = new ByteArray();
			buf.position = 0;
		}
		
		/**
		* 	Returns the current size of the buffer.
		* 
		* 	@return The value of the count field, which
		* 	is the number of valid bytes in this output stream.
		*/
		public function size():uint
		{
			return count;
		}
		
		/**
		* 	Creates a newly allocated byte array.
		* 
		* 	Its size is the current size of this
		* 	output stream and the valid contents
		* 	of the buffer have been copied into it.
		* 
		* 	@return The current contents of this
		* 	output stream, as a byte array.
		* 
		* 	@todo Ensure it's a new buffer returned.
		*/
		public function toByteArray():ByteArray
		{
			return buf;
		}
		
		/**
		* 	Writes len bytes from the specified byte array 
		* 	starting at offset off to this byte array output stream.
		* 
		* 	@param b The data.
		* 	@param off The start offset in the data. 
		* 	@param len The number of bytes to write.
		*/
		override public function write(
			b:ByteArray, off:int, len:int ):void
		{
			//
		}		
		
		/**
		*	The buffer where data is stored.
		*/
		protected function get buf():ByteArray
		{
			return ByteArray( this.target );
		}
		
		/**
		* 	The number of valid bytes in the buffer.
		*/
		protected function get count():uint
		{
			if( buf != null )
			{
				return buf.length;
			}
			return 0;
		}
		
		/**
		* 	Converts the buffer's contents into a string
		* 	by decoding the bytes using the specified
		* 	charsetName.
		* 
		* 	The length of the new String is a function of
		* 	the charset, and hence may not be equal to the
		* 	length of the byte array.
		* 
		* 	This method always replaces malformed-input
		* 	and unmappable-character sequences with
		* 	this charset's default replacement string.
		* 	The CharsetDecoder class should be used when
		* 	more control over the decoding process is required.
		* 
		* 	@param charsetName The name of a supported charset.
		* 
		* 	@throws UnsupportedEncodingException If the named
		* 	charset is not supported.
		* 
		* 	@return String decoded from the buffer's contents.
		*/
		public function toString( charsetName:String = "unicode" ):String
		{
			if( buf != null && count > 0 )
			{
				var original:uint = buf.position;
				buf.position = 0;
				var output:String = buf.readMultiByte( buf.length, charsetName );
				buf.position = original;
				return output;
			}
			return "";
		}
	}
}