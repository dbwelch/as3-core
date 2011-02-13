package java.io
{
	import flash.net.*;	
		
	import flash.utils.ByteArray;	
	import flash.utils.IDataOutput;
	
	/**
	* 	This abstract class is the superclass of all
	* 	classes representing an output stream of bytes.
	* 
	* 	An output stream accepts output bytes and
	* 	sends them to some sink.
	* 
	* 	Applications that need to define a subclass of
	* 	OutputStream must always provide at least a method
	* 	that writes one byte of output.
	*/
	public class OutputStream extends Object
		implements Closeable, Flushable
	{
		/**
		* 	@private
		*/
		protected var target:IDataOutput;
		
		/**
		* 	Creates an <code>OutputStream</code> instance.
		*/
		public function OutputStream()
		{
			super();
		}
		
		/**
		* 	Writes len bytes from the specified byte
		* 	array starting at offset off to this output
		* 	stream.
		* 
		* 	The general contract for write(b, off, len)
		* 	is that some of the bytes in the array b are
		* 	written to the output stream in order; element b[off]
		* 	is the first byte written and b[off+len-1] is
		* 	the last byte written by this operation.
		* 
		* 	The write method of OutputStream calls the
		* 	write method of one argument on each of the
		* 	bytes to be written out. Subclasses are encouraged
		* 	to override this method and provide a more
		* 	efficient implementation.
		* 
		* 	If b is null, a NullPointerException is thrown.
		* 
		* 	If off is negative, or len is negative, or
		* 	off+len is greater than the length of the array b,
		* 	then an IndexOutOfBoundsException is thrown.
		* 
		* 	@param b The data.
		* 	@param off The start offset in the data.
		* 	@param len The number of bytes to write.
		* 
		* 	@throws IOException If an I/O error occurs.
		* 	In particular, an IOException is thrown
		* 	if the output stream is closed.
		*/
		public function write(
			b:ByteArray, off:int, len:int ):void
		{
			//
		}
		
		/**
		* 	Closes this output stream and releases
		* 	any system resources associated with this stream.
		* 
		* 	The general contract of close is that it closes
		* 	the output stream. A closed stream cannot perform
		* 	output operations and cannot be reopened.
		* 
		* 	@throws IOException If an I/O error occurs.
		*/
		public function close():void
		{
			if( target is Socket )
			{
				try
				{
					Socket( target ).close();
				}catch( e:Error )
				{
					throw e;
				}
			}
		}
		
		/**
		* 	Flushes this output stream and forces any
		* 	buffered output bytes to be written out.
		* 
		* 	The general contract of flush is that calling
		* 	it is an indication that, if any bytes previously
		* 	written have been buffered by the implementation
		* 	of the output stream, such bytes should immediately
		* 	be written to their intended destination.
		* 
		* 	If the intended destination of this stream is
		* 	an abstraction provided by the underlying operating
		* 	system, for example a file, then flushing the stream
		* 	guarantees only that bytes previously written to the
		* 	stream are passed to the operating system for writing;
		* 	it does not guarantee that they are actually
		* 	written to a physical device such as a disk drive.
		* 
		* 	The flush method of OutputStream does nothing.
		* 
		* 	@throws IOException If an I/O error occurs.
		*/
		public function flush():void
		{
			if( target is Socket )
			{
				try
				{
					Socket( target ).flush();
				}catch( e:Error )
				{
					throw e;
				}
			}
		}
	}
}