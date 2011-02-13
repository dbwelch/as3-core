package java.io
{
	
	/**
	* 	A Closeable is a source or destination of data that can be closed.
	* 
	* 	The close method is invoked to release resources that the object
	* 	is holding (such as open files or network connections).
	* 
	*/
	public interface Closeable
	{
		/**
		* 	Closes this stream and releases any
		* 	system resources associated with it.
		* 
		* 	If the stream is already closed then
		* 	invoking this method has no effect.
		* 
		* 	@throws IOError If an I/O error occurs.
		*/
		function close():void;
	}
}