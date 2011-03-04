package com.ffsys.utils.byte {
	
	import flash.utils.ByteArray;
	
	/**
	*	Utility methods for working with
	*	<code>ByteArray</code> instances and
	*	binary values.
	*	
	*	Indices for accessing bits are left to
	*	right. Consider the decimal value 128
	*	in binary notation:
	*	
	*	<pre>10000000</pre>
	*	
	*	To access the bit that is set in this
	*	example, you would use a zero index:
	*	
	*	<pre>ByteUtils.getBitAt( 128, 0 );	//true</pre>
	*
	*	@langversion ActionScript 3.0
	*	@playerversion Flash 9.0
	*
	*	@author Mischa Williamson
	*	@since  13.12.2007
	*/
	public class ByteUtils extends Object {
		
		/**
		*	@private	
		*/
		public function ByteUtils()
		{
			super();
		}
		
		
		static public function getBitIndexValue(
			length:int, index:int ):Number
		{
			if( index > ( length - 1 ) )
			{
				throw new Error(
					"ByteUtils.getBitIndexValue, invalid index " + index );
			}
			
			var power:int = ( length - ( index + 1 ) );
			
			var value:Number =	
				Math.pow( 2, power );
			
			return value;
		}
		
		/**
		*	Gets the <code>Boolean</code> value for the
		*	bit of a byte at an <code>index</code>.
		*	
		*	@param The <code>Number</code> that contains the bits.
		*	@param The bit <code>index</code>.
		*	@param length The number of available bits.
		*	
		*	@return A <code>Boolean</code> indicating the
		*	state of the bit.
		*/
		static public function getBitAt(
			byte:Number, index:int = 0, length:int = 0 ):Boolean
		{
			if( !length )
			{
				length = getBitLength( byte );
			}
			
			var value:Number =
				getBitIndexValue( length, index );
			
			if( byte & value )
			{
				return true;
			}
			
			return false;
		}
		
		/**
		*	Sets the <code>Boolean</code> value for an
		*	individual bit of a byte at an <code>index</code>.
		*	
		*	@param byte The <code>Number</code> that contains the bits.
		*	@param index The bit <code>index</code>.
		*	@param flag The <code>Boolean</code> flag for the bit.
		*	@param length The number of available bits.
		*	
		*	@return The modified <code>byte</code> value.
		*/
		static public function setBitAt(
			byte:Number,
			index:int = 0,
			flag:Boolean = false,
			length:int = 0 ):int
		{
			if( !length )
			{
				length = getBitLength( byte );
			}
			
			var value:Number = getBitIndexValue( length, index );
			
			//switch bit on
			if( flag )
			{
				byte = byte | value;
			//switch bit off
			}else if( getBitAt( byte, index, length ) )
			{
				byte = byte ^ value;
			}
						
			return byte;
		}
		
		/**
		*	Determines whether a <code>Number</code>
		*	has a bit set at a given <code>index</code>.
		*	
		*	@param byte The <code>Number</code> to inspect.
		*	@param index The bit index.
		*	
		*	@return A <code>Boolean</code> indicating whether
		*	the bit at <code>index</code> is set.
		*/
		static public function hasBitSetAt(
			byte:Number, index:int = 0 ):Boolean
		{
			return ( getBitAt( byte, index ) == true );
		}
		
		/**
		*	Determines the number of bits that would
		*	be required to represent a given <code>Number</code>.
		*	
		*	@param byte The <code>Number</code> to determine
		*	the bit length of.
		*	
		*	@return The number of bits required to
		*	represent <code>byte</code>.
		*/
		static public function getBitLength( byte:Number ):int
		{
			var len:int = 8;
			
			var bit8:Number = Math.pow( 2, 8 );
			var bit16:Number = Math.pow( 2, 16 );
			var bit32:Number = Math.pow( 2, 32 );
			
			if( byte >= bit8 && byte < bit16 )
			{
				len = 16;
			}else if( byte >= bit16 && byte < bit32 )
			{
				len = 32;
			}else if( byte >= bit32 )
			{
				len = 64;
			}
			
			return len;			
		}
		
		/**
		*	Creates a complete clone of a <code>ByteArray</code>.
		*	
		*	@param bytes The <code>ByteArray</code> to clone.
		*	
		*	@return The cloned <code>ByteArray</code>.
		*/
		static public function clone( bytes:ByteArray ):ByteArray
		{
			if( !bytes )
			{
				bytes = new ByteArray();
			}
			
			var cloned:ByteArray = new ByteArray();
			bytes.position = 0;
			bytes.readBytes( cloned, 0, bytes.length );
			cloned.position = 0;
			bytes.position = 0;
			return cloned;
		}
		
		/**
		*	Gets the number of bytes available in a
		*	<code>ByteArray</code>.
		*	
		*	@param bytes The <code>ByteArray</code> to inspect.
		*	
		*	@return An unsigned integer indicating the number of
		*	bytes that can be read from the <code>ByteArray</code>.
		*/
		static public function getBytesAvailable( bytes:ByteArray ):uint
		{
			if( !bytes )
			{
				return 0;
			}
			
			return ( bytes.length - bytes.position );
		}
		
		static public function writeByteArrayWithLength(
			target:ByteArray, element:ByteArray ):void
		{
			if( target && element )
			{
				target.writeUnsignedInt( element.length );
				target.writeBytes( element, 0, element.length );
			}
		}
		
		static public function readByteArrayWithLength(
			target:ByteArray ):ByteArray
		{
			var length:int;
			
			try{
				length = target.readUnsignedInt();
			}catch( e:Error )
			{
				throw new Error( "ByteUtils.readByteArrayWithLength(), could not read length : " +
					target );
			}
			
			var element:ByteArray = new ByteArray();
			target.readBytes( element, 0, length );
			return element;
		}		
		
		/**
		*	Pads a ByteArray with null bytes up until the modulo
		*	of a given amount is equal to zero.
		*	
		*	Temporarily kept for reference purposes.
		*/
		
		/*
		static public function padNullBytes(
			bytes:ByteArray, amount:int = 4 ):ByteArray
		{
			
			if( !bytes )
			{
				bytes = new ByteArray();
			}
			
			var mod:Number = Math.floor( bytes.length % amount );
			
			if( mod != 0 )
			{
				bytes.length += ( amount - mod );
			}
			
			return bytes;
		}
		*/
		
	}
	
}
