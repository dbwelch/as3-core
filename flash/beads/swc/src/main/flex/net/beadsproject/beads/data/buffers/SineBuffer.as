package net.beadsproject.beads.data.buffers
{
	import flash.utils.IDataOutput;	
	
	import net.beadsproject.beads.data.Buffer;
	import net.beadsproject.beads.data.BufferFactory;
	
	
	/**
	* 	//
	*/
	public class SineBuffer extends BufferFactory
	{
		public static const NAME:String = "Sine";
		
		/**
		* 	Creates a SineBuffer instance.
		*/
		public function SineBuffer()
		{
			super();
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function get name():String
		{
			return NAME;
		}
		
		static public function write(
			output:IDataOutput, position:Number, size:uint = 0 ):uint
		{
			if( size == 0 )
			{
				size = Buffer.DEFAULT_BUFFER_SIZE;
			}
			
			trace("SineBuffer::write()", position, size );
			
			//trace("SineBuffer::generateBuffer()", size );
			var b:Buffer = new Buffer( size );
			//trace("SineBuffer::generateBuffer()", b );
			for( var i:int = 0;i < size;i++ )
			{
				b.buf[ i ] = Math.sin( ( Number( i + position ) / Math.PI / 2 ) );
				
				//b.buf[ i ] = Math.sin( 2.0 * Math.PI * ( i / size ) );
				
				//output.writeFloat( Math.sin( ( Number( i + position ) / Math.PI / 2 ) ) );
			}
			return b.write( output );
		}
		
		/**
		* 	@inheritDoc
		*/
		override public function generateBuffer( size:uint ):Buffer
		{
			//trace("SineBuffer::generateBuffer()", size );
			var b:Buffer = new Buffer( size );
			//trace("SineBuffer::generateBuffer()", b );
			for( var i:int = 0;i < size;i++ )
			{
				//b.buf[ i ] = Math.sin( 2.0 * Math.PI * (i / size) );
				
				//r = Math.sin((Number( c + event.position ) / Math.PI / 2 )) * 0.125;
				
				b.buf[ i ] = Math.sin( ( i / Math.PI / 2 ) );
			}
			return b;
		}
	}
}