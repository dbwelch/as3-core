package java.lang
{
	import java.nio.CharBuffer;
	
	/**
	* 	A Readable is a source of characters.
	* 
	* 	Characters from a Readable are made available to callers
	* 	of the read method via a CharBuffer.
	*/
	public interface Readable
	{
		/**
		* 	Attempts to read characters into the specified character buffer.
		* 
		* 	The buffer is used as a repository of characters as-is:
		* 	the only changes made are the results of a put operation.
		* 	No flipping or rewinding of the buffer is performed.
		* 
		* 	@param cb The buffer to read characters into.
		* 
		* 	@throws IOException If an I/O error occurs.
		* 	@throws NullPointerException If cb is null.
		* 	@throws ReadOnlyBufferException If cb is a read only buffer.
		* 
		* 	@return The number of char values added to the buffer, or -1
		* 	if this source of characters is at its end.
		*/
		function read( cb:CharBuffer ):int;
	}
}