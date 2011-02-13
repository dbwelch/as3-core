package java.io
{
	import flash.utils.ByteArray;
	import flash.utils.IDataInput;
	
	/**
	*	A ByteArrayInputStream contains an internal buffer that
	* 	contains bytes that may be read from the stream.
	* 
	* 	<p>An internal counter keeps track of the next
	* 	byte to be supplied by the read method.</p>
	* 
	* 	<p>Closing a ByteArrayInputStream has no effect.
	* 	The methods in this class can be called after the
	* 	stream has been closed without generating an IOException.</p>
	*/
	public class ByteArrayInputStream extends InputStream
	{
		private var _buf:ByteArray;
		private var _marked:int;
		
		/**
		* 	Creates a <code>ByteArrayInputStream</code> instance.
		* 
		* 	@param buffer the input buffer.
		* 	@param offset 
		* 	@param length
		* 
		* 	@todo Implement offset.
		* 	@todo Implement length.
		*/
		public function ByteArrayInputStream(
			buffer:ByteArray = null,
			offset:int = 0,
			length:int = 0 )
		{
			if( buffer == null )
			{
				buffer = new ByteArray();
			}
			super();
			target = buffer;
		}
		
		/**
		*	An array of bytes that was provided
		* 	by the creator of the stream.
		*/
		protected function get buf():ByteArray
		{
			return ByteArray( this.target );
		}
		
		/**
		* 	The index one greater than the last
		* 	valid character in the input stream buffer.
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
		*	The currently marked position
		* 	in the stream.
		*/
		protected function get marked():int
		{
			return _marked;
		}
		
		/**
		*	The index of the next character to
		* 	read from the input stream buffer.
		*/
		protected function get pos():int
		{
			if( buf != null )
			{
				return buf.position;
			}
			return 0;
		}
	}
}