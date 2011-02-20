package net.beadsproject.beads.data
{
	import flash.utils.Dictionary;	
	
	import net.beadsproject.beads.data.buffers.SineBuffer;	

	public class BufferFactory extends Object
	{
		private static const defaults:Dictionary = new Dictionary();
		
		/*
		public static const SAW:Buffer = new SawBuffer().getDefault();
		public static const SQUARE:Buffer = new SquareBuffer().getDefault();
		public static const TRIANGLE:Buffer = new TriangleBuffer().getDefault();
		public static const NOISE:Buffer = new NoiseBuffer().getDefault();		
		*/
		
		/**
		* 	Creates a <code>BufferFactory</code> instance.
		*/
		public function BufferFactory()
		{
			super();
		}
		
		/**
		* 	Generates the audio buffer.
		* 
		* 	@param size The size of the buffer.
		* 
		* 	@return The created audio buffer data.
		*/
		public function generateBuffer( size:uint ):Buffer
		{
			return new Buffer( size );
		}
		
		/**
		* 	The name of this type of buffer factory.
		*/
		public function get name():String
		{
			return null;
		}
		
		/**
		* 	@private
		*/
		protected function getDefaultBuffer():Buffer
		{
			var nm:String = null;
			for( nm in defaults )
			{
				if( name == nm )
				{
					return Buffer( defaults[ nm ] );
				}
			}
			return null;
		}
		
		/**
		* 	
		*/
		public function getDefault():Buffer
		{
			var existing:Buffer = getDefaultBuffer();
			if( existing == null )
			{
				existing = defaults[ name ] = generateBuffer(
					Buffer.DEFAULT_BUFFER_SIZE );
			}
			return existing;
		}
	}
}