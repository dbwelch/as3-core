package net.beadsproject.beads.data
{
	import flash.utils.IDataInput;	
	import flash.utils.IDataOutput;

	public class Buffer extends Object
	{
		private var _buf:Vector.<Number>;
		
		/**
		* 	The default buffer size.
		* 
		* 	Should be a value between 2048 and 8192, a value
		* 	less than 2048 will stop the current sound playing.
		*/
		public static const DEFAULT_BUFFER_SIZE:uint = 8192;
	
		/**
		* 	Creates a <code>Buffer</code> instance.
		* 
		* 	@param size The size of the buffer.
		*/
		public function Buffer( size:uint = DEFAULT_BUFFER_SIZE )
		{
			super();
			_buf = new Vector.<Number>( size, true );
		}
		
		/**
		* 	The underlying data for the buffer.
		*/
		public function get buf():Vector.<Number>
		{
			return _buf;
		}
		
		/**
		* 	The length of this buffer.
		*/
		public function get length():uint
		{
			return _buf.length;
		}
		
		/**
		* 	Writes this buffer to the data output
		* 	as a series of floats.
		* 
		* 	@param output The data output.
		* 
		* 	@return The length of this buffer.
		*/
		public function write( output:IDataOutput ):uint
		{
			//trace("Buffer::write()", output, _buf.length );
			for( var i:int = 0;i < _buf.length;i++ )
			{
				output.writeFloat( _buf[ i ] );
				output.writeFloat( _buf[ i ] );
			}
			return _buf.length;
		}
	}
}