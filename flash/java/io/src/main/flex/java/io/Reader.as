package java.io
{
	
	/*
	
	 void	mark(int readAheadLimit) 
	          Marks the present position in the stream.
	 boolean	markSupported() 
	          Tells whether this stream supports the mark() operation.
	 int	read() 
	          Reads a single character.
	 int	read(char[] cbuf) 
	          Reads characters into an array.
	abstract  int	read(char[] cbuf, int off, int len) 
	          Reads characters into a portion of an array.
	 int	read(CharBuffer target) 
	          Attempts to read characters into the specified character buffer.
	 boolean	ready() 
	          Tells whether this stream is ready to be read.
	 void	reset() 
	          Resets the stream.
	 long	skip(long n) 
	          Skips characters.	
	
	
	*/

	public class Reader extends Object
		implements Closeable
	{
	
		/**
		* 	Creates a <code>Reader</code> instance.
		*/
		public function Reader()
		{
			super();
		}
		
		/**
		* 	Closes the stream and releases any system
		* 	resources associated with it.
		*/
		public function close():void
		{
			//TODO
		}		
	}
}